# Registrador.py

import serial
import crc8
from datetime import datetime
import enum
import defines
import time

# import Sesiones
import SQL_Writer

# Tutoriales y fuentes:
    #
    # Tutorial: Instalar SQL Server
    # https://www.youtube.com/watch?v=YOaC_TyOrdk&ab_channel=C%C3%B3digosdeProgramaci%C3%B3n-MarcoRobles
    #
    # Tutorial: Enviar Queries de python a SQL Server
    # https://www.youtube.com/watch?v=aF552bMEcO4

# Conexión
PUERTO = "COM3"
# Configuración para escritura en Base
MAX_FRAMES_TO_WRITE = 5

# Tiempos de desconexión y limpieza de buffer de recepción
CLEAR_RX_BUFFER_TIME = 14 * defines.TIMEOUT_TIME
DISCONNECTION_TIME = 2 * defines.TIME_DESIRED_BETWEEN_READS



# Posibles estados de cada máquina
class State(enum.IntEnum):
    STOPPED = 0
    WORKING = 1
# Posibles eventos de sesión para cada máquina
class Event(enum.IntEnum):
    NO_SESSION          = 0     # no hay sesión
    SESSION_STARTED     = 1     # Sesión Activa -> inicia
    SESSION_CONTINUES   = 2     # Sesión Activa -> continua
    SESSION_FINISHED    = 3     # Sesión Activa -> termina


# Chequear el PDU recibido
def checkReceivedPDU(PDU_bytes: bytes ) -> bool:
    crc8_obj = crc8.crc8()
    crc8_obj.update( PDU_bytes[0:8] )
    
    # crc8_recv_as_int = PDU_bytes[8]
    # crc8_calc_as_int = int.from_bytes(crc8_obj.digest(), "little")
    
    # Si CRC_Recibido == CRC_Calculado
    if PDU_bytes[8] == int.from_bytes(crc8_obj.digest(), "little"):
        return True
    else:
        # print( f"CRC Recibido: {crc8_recv_as_int}" ) 
        # print( f"CRC Calculado: {crc8_calc_as_int}" )
        return False
# Mostrar el PDU recibido
def showReceivedPDU(PDU_bytes: bytes) -> None:
    bits_string = str()
    ascii_string = str()
    # Convierto los datos [0:7] y el CRC [8] a string
    for i in range(0, defines.BUFFER_SIZE_ONLY_DATA_MODE - 1):
        bits_string += "{0:08b}".format( ord(PDU_bytes.decode()[i]) ) + " "
    # Si la trama es DATA + INFO, muestro el resto en ascii [9:17]
    if len(PDU_bytes) == defines.BUFFER_SIZE_DATA_INFO_MODE:
        ascii_string += chr(PDU_bytes[9]) + ":" \
                        + chr(PDU_bytes[10]) \
                        + chr(PDU_bytes[11]) \
                        + " " # T:00
        ascii_string += chr(PDU_bytes[12]) + ":" \
                        + chr(PDU_bytes[13]) \
                        + chr(PDU_bytes[14]) \
                        + " " # N:00
        ascii_string += chr(PDU_bytes[15]) + ":" \
                        + chr(PDU_bytes[16]) \
                        + chr(PDU_bytes[17]) \
                        + " " # U:00       
    
    print( f"Received: " + bits_string + ascii_string )

# Inicializar Samples en 0
def initSample() -> list:
    out = list()
    
    # Primera posición - Timestamp
    out.append( datetime.now() )

    # Estados de 64 máquinas en 0
    for i in range(1, defines.CANT_MAQ+1):
        out.append( State.STOPPED )  
    return out
# Obtener Samples a partir de Trama
def getSamplesFromFrame(frame: bytes, dt: datetime) -> list:
    """Forma una lista Samples del tipo:
    0 ->    datetime
    1 ->    state_MAQ1
    2 ->    state_MAQ2
    3 ->    state_MAQ3
    ...
    """
    
    out = list()
    out.append( dt )

    # Desde el byte menos significativo al más significativo
    for byte_in_frame in range(7, -1, -1):
        # Desde el LSB hasta el MSB
        for bit_in_byte in range(0, 8):
            # Agrego el valor correspondiente (0 -> STOPPED; 1 -> WORKING)
            out.append( State.WORKING 
                    if ( frame[byte_in_frame] & (0x01 << bit_in_byte) ) 
                    else State.STOPPED )

    # Retorno la lista Sample completa
    return out
# Obtener Lista de Reportes a partir de Samples
def getReportsFromSample(curr_sample: list, last_sample: list, last_reports: list = None) -> list:
    """Compara los cambios de estados, para detectar eventos de la sesión de cada máquina.
    Para cada máquina, evalúa:
        STOPPED a STOPPED   -> NO_SESSION
        STOPPED a WORKING   -> SESSION_STARTED
        WORKING a WORKING   -> SESSION_CONTINUES
        WORKING a STOPPED   -> SESSION_FINISHED
    
    Generando así un reporte para cada máquina:
        [ id_maq, last_event, timestamp ]
    
    Se retorna una lista de estos reportes:
        Si hubo una lista de reportes previa, se agregan los nuevos o actualizan los reportes hechos.
        Si no hay lista de reprtes previa, retorna una lista de nuevos reportes.
    """
    # Si las listas tienen igual tamaño, comparo
    if len(last_sample) == len(curr_sample):
        # Primera lista de reportes (luego de escritura a base de datos)
        if last_reports is None or len(last_reports) == 0:
            new_reports = list()
            # Para cada máquina
            for id in range(1, len(curr_sample)):
                # Si sigue parada, no hay reporte, me voy. Sino analizo
                if not( last_sample[id] == State.STOPPED and curr_sample[id] == State.STOPPED ):
                    
                    # Máquina de WORKING a WORKING -> SESSION_CONTINUES
                    if last_sample[id] == State.WORKING and curr_sample[id] == State.WORKING:
                        new_reports.append( [id, Event.SESSION_CONTINUES, curr_sample[0]] )

                    # Máquina de WORKING a STOPPED -> SESSION_FINISHED
                    elif last_sample[id] == State.WORKING and curr_sample[id] == State.STOPPED:
                        new_reports.append( [id, Event.SESSION_FINISHED, curr_sample[0]] )
                    
                    # Máquina de STOPPED a WORKING -> SESSION_STARTED
                    elif   last_sample[id] == State.STOPPED and curr_sample[id] == State.WORKING: 
                        new_reports.append( [id, Event.SESSION_STARTED, curr_sample[0]] )
            return new_reports
        
        # Ya hubo una lista de reportes, tengo que agregar/actualizar
        else:
            # Para cada máquina
            for id in range(1, len(curr_sample)):
                # Si sigue parada, no hay reporte, me voy. Sino analizo
                if not( last_sample[id] == State.STOPPED and curr_sample[id] == State.STOPPED ):

                    # Máquina de WORKING a WORKING -> SESSION_CONTINUES
                    if last_sample[id] == State.WORKING and curr_sample[id] == State.WORKING:
                        # Creo un flag para marcar si lo encontré y actualicé
                        flag_found_and_updated = False
                        # Recorro last_reports
                        for j in range(len(last_reports)):
                            # Encuentro el último reporte "SESSION_CONTINUES" de ésta máquina
                            if last_reports[j][0] == id and last_reports[j][1] == Event.SESSION_CONTINUES:
                                # Actualizo el timestamp del reporte
                                last_reports[j][2] = curr_sample[0]
                                # Levanto el flag
                                flag_found_and_updated = True
                                break
                        # Si no se encontró ningún "SESSION_CONTINUES", es porque es el primero
                        if flag_found_and_updated == False:
                            # Agrego el reporte de SESSION_CONTINUES
                            last_reports.append( [id, Event.SESSION_CONTINUES, curr_sample[0]] )

                    # Máquina de WORKING a STOPPED -> SESSION_FINISHED
                    elif last_sample[id] == State.WORKING and curr_sample[id] == State.STOPPED:
                        # Agrego el reporte de SESSION_FINISHED
                        last_reports.append( [id, Event.SESSION_FINISHED, curr_sample[0]] )
                    
                    # Máquina de STOPPED a WORKING -> SESSION_STARTED
                    elif   last_sample[id] == State.STOPPED and curr_sample[id] == State.WORKING: 
                        # Agrego el reporte de SESSION_STARTED
                        last_reports.append( [id, Event.SESSION_STARTED, curr_sample[0]] )
            return last_reports   
    
    # Sino, no se pueden comparar
    else:
        raise Exception(f"""Debe cumplirse: len(last_sample) == len(curr_sample)
        len(last_sample) = {len(last_sample)}
        len(curr_sample) = {len(curr_sample)}""")
# Escribir en la base a partir de Lista de Reportes
def writeDatabaseFromReports(report_list: list, db_con: any):
    """A partir de los reportes, genero el conjunto de datos útiles,
    y los mando a la base de datos:
    NO_SESSION          -> ~ (Sesión no activa)
    SESSION_STARTED     -> SQL_Writer.sessionStarted(conn, id_maq, timestamp)
    SESSION_CONTINUES   -> SQL_Writer.sessionContinues(conn, id_maq, timestamp)
    SESSION_FINISHED    -> SQL_Writer.sessionFinished(conn, id_maq, timestamp)
    """
    
    # Recorro todos los reportes
    for reporte in report_list:
        if   reporte[1] == Event.SESSION_CONTINUES:
            SQL_Writer.sessionContinues( db_con, reporte[0], reporte[2] )
        
        elif reporte[1] == Event.SESSION_FINISHED:
            SQL_Writer.sessionFinished( db_con, reporte[0], reporte[2] )
        
        elif reporte[1] == Event.SESSION_STARTED:
            SQL_Writer.sessionStarted( db_con, reporte[0], reporte[2] )

    # Limpio la lista de reportes
    report_list.clear()
    


if __name__ == "__main__":

    # Inicio los Samples
    prev_sample = initSample()
    curr_sample = initSample()
    # Inicio las listas de Reportes
    prev_report_list = list()
    curr_report_list = list()

    # Inicio la conexión con la base de datos
    db_con = SQL_Writer.connectToDatabase()

    # Abro el puerto serie
    with serial.Serial( port = PUERTO,
                        baudrate = 115200,
                        parity = serial.PARITY_NONE,
                        stopbits = serial.STOPBITS_ONE,
                        bytesize = serial.EIGHTBITS,
                        timeout = DISCONNECTION_TIME 
                        ) as serial_port:

        # Limpio cualquier basura previa en el puerto
        serial_port.flush()
        serial_port.reset_input_buffer()

        # Loop principal
        trama = bytes()
        hubo_desconexion = False
        tramas_a_escribir = 0
        while 1:
            
            # Si todo anda bien
            if not hubo_desconexion:
                # Recibo hasta CHAR_FINISH_PDU, con DISCONNECTION_TIME segundos como límite
                trama += serial_port.read_until( defines.CHAR_FINISH_PDU )
            # Si hubo desconexion
            else:
                # Saco el timeout
                serial_port.timeout = None
                # Recibo hasta CHAR_FINISH_PDU, sin límite de tiempo
                trama += serial_port.read_until( defines.CHAR_FINISH_PDU )

            
            # Si se recibió una trama completa
            if len(trama) >= defines.BUFFER_SIZE_ONLY_DATA_MODE:
            
                # Chequeo el PDU
                check = checkReceivedPDU(trama)

                # ACK
                if check == True:
                    # Respondo ACK
                    serial_port.write(defines.ACK)

                    # Si se recompuso la conexion
                    if hubo_desconexion:
                        print( "Se logro una nueva conexión" )
                        # Reseteo el flag de desconexion
                        hubo_desconexion = False
                        # Pongo el timeout nuevamente
                        serial_port.timeout = DISCONNECTION_TIME

                    # Aviso que llegó algo
                    print( "Trama recibida" )

                    # Genero el Sample a partir de la trama recibida
                    curr_sample = getSamplesFromFrame(trama, datetime.now())

                    # Cuento la trama a escribir
                    tramas_a_escribir += 1

                    # Si es la primera trama luego de una escritura
                    if tramas_a_escribir == 1:
                        # Limpio la lista de Reportes previa
                        prev_report_list.clear()
                    
                    # Genero/actualizo la lista de Reportes
                    curr_report_list = getReportsFromSample( curr_sample, prev_sample, prev_report_list )
                        
                    # Si tengo todas las tramas para escribir
                    if tramas_a_escribir >= MAX_FRAMES_TO_WRITE:
                        # Escribo en la base todos los reportes
                        writeDatabaseFromReports( curr_report_list, db_con )                                 
                        # Reseteo el contador de tramas a escribir
                        tramas_a_escribir = 0
                        # Muestro la tabla actualizada
                        SQL_Writer.selectLast(db_con, 50)

                    # Actualizo el Sample previo
                    prev_sample = curr_sample
                    # Actualizo la lista de Reportes previa
                    prev_report_list = curr_report_list
                    
                    # Espero para limpiar el buffer de recepción, 
                    time.sleep(CLEAR_RX_BUFFER_TIME)
                    # Limpio el buffer de recepción por posible unex_ans recibida en el embebido
                    serial_port.reset_input_buffer()
                    # Limpio la trama para recibir una nueva
                    trama = bytes()
                    
                # NAK
                else:
                    # Respondo NAK
                    serial_port.write(defines.NAK)

                    # Muestro la trama
                    showReceivedPDU(trama)

                    # Limpio la trama para recibir una nueva
                    trama = bytes()
            
            # Sino se recibió una trama, hubo una DESCONEXIÓN
            else:
                # Seteo el flag de desconexion
                hubo_desconexion = True

                # Si hay tramas a escribir en la base
                if tramas_a_escribir != 0:
                    # Aviso que se perdió al menos una trama
                    print( "DESCONEXION: Al menos una trama se perdió! Guardo en la base lo que tengo" )

                    # Escribo en la base todos los reportes
                    writeDatabaseFromReports( curr_report_list, db_con )                                 
                    # Reseteo el contador de tramas a escribir
                    tramas_a_escribir = 0
                    # Muestro la tabla actualizada
                    SQL_Writer.selectLast(db_con, 50)
                # No hay tramas a escribir en la base
                else:
                    # Aviso que se perdió al menos una trama
                    print( "DESCONEXION: Al menos una trama se perdió! Nada para escribir en la base" )
                
                # Reseteo los samples
                # Asumo que ninguna máquina continúa, sino que se perdió registro, y las próximas son todas SESSION_STARTED
                curr_sample = initSample()
                prev_sample = initSample()
                # Reseteo los reportes, por la misma razón
                curr_report_list = list()
                prev_report_list = list()

            