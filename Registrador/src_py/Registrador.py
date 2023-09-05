# Registrador.py

import sys
import serial
import crc8
import config_boards
import config_serial
import config_embedded
import config_SQL_Database
import config_relay_types
import console_window_control
from datetime import datetime, timedelta
import enum
import time
import SQL_Writer
from math import sqrt
import error_logger


# Configuración para escritura en Base
MAX_FRAMES_TO_WRITE = 5

# Tiempos de desconexión y limpieza de buffer de recepción
CLEAR_RX_BUFFER_TIME = 14 * config_embedded.TIMEOUT_TIME
DISCONNECTION_TIME = MAX_FRAMES_TO_WRITE * config_embedded.TIME_BETWEEN_FRAMES



# Posibles estados de cada máquina
class State(enum.IntEnum):
    STOPPED = 0                 # Máquina apagada
    WORKING = 1                 # Máquina trabajando
# Posibles eventos de sesión para cada máquina
class Event(enum.IntEnum):
    NO_SESSION          = 0     # no hay sesión
    SESSION_STARTED     = 1     # Sesión Activa -> inicia
    SESSION_CONTINUES   = 2     # Sesión Activa -> continua
    SESSION_FINISHED    = 3     # Sesión Activa -> termina



#       Funciones para tramas
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
    bits_string = bytes_to_bit_str(PDU_bytes, range(0, 9))
    
    # Si la trama es DATA + INFO, muestro el resto en ascii [9:17]
    if len(PDU_bytes) == config_embedded.BUFFER_SIZE_DATA_INFO_MODE:
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
    print( f"Recibido: " + bits_string + ascii_string )
def bytes_to_bit_str(data: bytes, rango: range) -> str: 
    bit_str = str()
    for byte in rango:
        for bit in reversed( range(0, 8) ):
            bit_str += str( ( data[byte] & (1 << bit) ) >> bit )
        bit_str += " "
    return bit_str


#       Funciones para Registrador()
# Inicializar Samples en 0
def initSample() -> list:
    """Inicializa una lista Samples del tipo:
    0 ->    timestamp (datetime)
    1 ->    State.STOPPED
    2 ->    State.STOPPED
    3 ->    State.STOPPED
    ...
    """

    sample = list()
    
    # Primera posición - Timestamp
    sample.append( datetime.now() )

    # Las 64 máquinas inician paradas
    for i in range(1, config_boards.MAX_MAQS + 1):
        sample.append( State.STOPPED )
    
    # Retorno el sample inicializado
    return sample
# Obtener Samples a partir de Trama
def getSamplesFromFrame(frame: bytes, timestamp: datetime) -> list:
    """Forma una lista Samples del tipo:
    0 ->    timestamp (datetime)
    1 ->    state_MAQ1
    2 ->    state_MAQ2
    3 ->    state_MAQ3
    ...
    """

    sample = list()
    sample.append( timestamp )

    # Desde el byte menos significativo al más significativo
    for byte_in_frame in range(7, -1, -1):
        # Desde el LSB hasta el MSB
        for bit_in_byte in range(0, 8):
            # 1 +                                   -> Pasa la posición del bit (0~63) a idMAQ (1~64)
            # bit_in_byte + 8 * (7-byte_in_frame)   -> Devuelve la posición del bit (0~63)
            idMAQ_curr = 1 + bit_in_byte + 8 * (7-byte_in_frame)

            # Estado del bit leído (0 o 1)
            bit_state = bool((frame[byte_in_frame] & (0x01 << bit_in_byte)) >> bit_in_byte)
            
            # Tipo de Relay configurado (NORMAL_ABIERTO o NORMAL_CERRADO)
            relay_type = bool(config_relay_types.RELAY_TYPE[idMAQ_curr])
            
            # Obtengo el estado de la máquina a partir del estado del bit y el tipo de relay
            estado = ( State.WORKING
                    if ( bit_state ^ relay_type )
                    else State.STOPPED )
            
            # Agrego el valor correspondiente (0 -> STOPPED; 1 -> WORKING)
            sample.append( estado )

    # Retorno la lista Sample completa
    return sample
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
                    elif last_sample[id] == State.STOPPED and curr_sample[id] == State.WORKING: 
                        new_reports.append( [id, Event.SESSION_STARTED, curr_sample[0]] )
            
            # Retorno los reportes nuevos
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
            
            # Retorno la lista de reportes actualizada
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
    NO_SESSION          -> ~ (Sesión no activa, no se escribe nada)
    SESSION_STARTED     -> SQL_Writer.sessionStarted(conn, id_maq, timestamp)
    SESSION_CONTINUES   -> SQL_Writer.sessionContinues(conn, id_maq, timestamp)
    SESSION_FINISHED    -> SQL_Writer.sessionFinished(conn, id_maq, timestamp)

    Sólo se toman en cuenta las máquinas conectadas, según la lista CONNECTED_MAQS del archivo boards.py.
    """
    
    # Recorro todos los reportes
    for reporte in report_list:
        
        # Si la máquina es una de las conectadas, escribo en la base
        if reporte[0] in config_boards.CONNECTED_MAQS:
            
            tryToWriteToDataBase( db_con, reporte )
                
    # Limpio la lista de reportes
    report_list.clear()
# Mostrar los reportes en pantalla
def showReports(report_list: list):
    print("Reportes a escribir en la base de datos en la próxima escritura:")
    # Muestro los reportes pasados
    for reporte in report_list:
        print(f"idMAQ: {reporte[0]:02d}, Evento: {repr(reporte[1])}, \t Timestamp: {reporte[2]}")


#       Funciones estadísticas para _serial_tester() y _serial_tester_force_answer()
# Calculo del promedio (de forma acumulativa)
def average( new_number: float ):
    average.n += 1
    average.last_average = ( average.last_average * (average.n-1) + new_number ) / average.n
    return average.last_average
average.last_average = average.n = 0
def resetAverage():
    average.last_average = average.n = 0
# Calculo de la desviación estándar (de forma acumulativa)
def standardDeviation( new_number: float ):
    standardDeviation.sum  += new_number
    standardDeviation.sum2 += new_number*new_number
    standardDeviation.n    += 1.0
    sum, sum2, n = standardDeviation.sum, standardDeviation.sum2, standardDeviation.n
    return sqrt(sum2/n - sum*sum/n/n)
standardDeviation.n = standardDeviation.sum = standardDeviation.sum2 = 0
def resetStandardDeviation():
    standardDeviation.n = standardDeviation.sum = standardDeviation.sum2 = 0


#       Funciones para mostrar la trama completa, según el caso
# Muestro el PDU recibido y los nuevos datos estadísticos
def showAllDataAck( trama: bytes, contador_tramas: int, contador_naks: int, curr_dt: datetime, last_dt: datetime ):
    # Muestro el número de trama y el TimeStamp
    if contador_tramas < 3:
        print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()}" )
    else:
        print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()} - deltaT: {(curr_dt-last_dt)}" )
        # Muestro datos estadísticos (asumiendo distribución normal, mostrando promedio y desviación estándar)
        print( f"Promedio(deltaT): {average((curr_dt-last_dt).total_seconds())}s - Desviación Estándar(deltaT): {standardDeviation((curr_dt-last_dt).total_seconds())}s" )
    # Muestro la trama completa
    showReceivedPDU(trama)
    # Muestro la respuesta y los NAKs acumulados
    print(f"Response: ACK( {config_embedded.ACK.decode()} ) - NAKs acumulados {contador_naks}")
    # Pongo un separador para la siguiente trama
    print()
def showAllDataNak( trama: bytes, contador_tramas: int, contador_naks: int, curr_dt: datetime, last_dt: datetime ):
    # Muestro el número de trama y el TimeStamp
    if contador_tramas < 3:
        print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()}" )
    else:
        print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()} - deltaT: {(curr_dt-last_dt)}" )
        # Muestro datos estadísticos (asumiendo distribución normal, mostrando promedio y desviación estándar)
        print( f"Promedio(deltaT): {average((curr_dt-last_dt).total_seconds())}s - Desviación Estándar(deltaT): {standardDeviation((curr_dt-last_dt).total_seconds())}s" )
    # Muestro la trama completa
    showReceivedPDU(trama)
    # Muestro la respuesta y los NAKs acumulados
    print(f"Response: NAK( {config_embedded.NAK.decode()} ) - NAKs acumulados {contador_naks}")
    # Pongo un separador para la siguiente trama
    print()
def showAllDataForcedAnswer( trama: bytes, contador_tramas: int, contador_naks: int, curr_dt: datetime, last_dt: datetime, forced_ans: bytes ):
    # Muestro el número de trama y el TimeStamp
    if contador_tramas < 3:
        print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()}" )
    else:
        print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()} - deltaT: {(curr_dt-last_dt)}" )
        # Muestro datos estadísticos (asumiendo distribución normal, mostrando promedio y desviación estándar)
        print( f"Promedio(deltaT): {average((curr_dt-last_dt).total_seconds())} - Desviación Estándar(deltaT): {standardDeviation((curr_dt-last_dt).total_seconds())}" )
    # Muestro la trama completa
    showReceivedPDU(trama)
    # Muestro la respuesta y los NAKs acumulados
    print(f"Response: ( {forced_ans.decode()} ) - NAKs acumulados {contador_naks}")
    # Pongo un separador para la siguiente trama
    print()


#       Funciones que detectan errores
def tryToConnectToDataBase(debug_mode: bool=False):
    try:
        db_con = SQL_Writer.connectToDatabase()
    except Exception as exception:
        print("Error al intentar conectarse con la base de datos:")
        print(exception.args[0])
        print()
        error_timestamp = datetime.now()
        error_logger.writeErrorLog( 
            timestamp = error_timestamp, 
            type = "DB_CONN", 
            opt_msg = exception.args[0],
            debug = debug_mode
        )
        sys.exit(1)
    else:
        return db_con
def tryToWriteToDataBase(db_conn, report: list, debug_mode: bool=False):
    """Intenta escribir en la base, si hay una excepción, se guarda en el archivo .log.
    
    El reporte para cada máquina:
        [ id_maq, last_event, timestamp ]"""
    try:
        if   report[1] == Event.SESSION_CONTINUES:
            SQL_Writer.sessionContinues( db_conn, report[0], report[2] )
        
        elif report[1] == Event.SESSION_STARTED:
            SQL_Writer.sessionStarted( db_conn, report[0], report[2] )
        
        elif report[1] == Event.SESSION_FINISHED:
            SQL_Writer.sessionFinished( db_conn, report[0], report[2] )
    
    except Exception as exception:
        print("Error al intentar escribir en la base de datos:")
        print(exception.args[0])
        print()
        error_timestamp = datetime.now()
        error_logger.writeErrorLog( 
            timestamp = error_timestamp, 
            type = "DB_WRITE", 
            last_ok_timestamp = error_timestamp - timedelta(seconds=MAX_FRAMES_TO_WRITE*config_embedded.TIME_BETWEEN_FRAMES),
            opt_msg = exception.args[0],
            debug = debug_mode
        )
        sys.exit(1)
def tryToOpenSerialPort(debug_mode: bool=False):
    try:
        port = serial.Serial( 
            port = str(config_serial.get_CH340_Port().name),
            baudrate = config_serial.SELECTED_BAUDRATE,
            parity = config_serial.SELECTED_PARITY,
            stopbits = config_serial.SELECTED_STOPBITS,
            bytesize = config_serial.SELECTED_BYTE_SIZE,
            timeout = DISCONNECTION_TIME 
        )
    except Exception as exception:
        print("USB-Serial CH340 no encontrado...")
        print(exception.args[0])
        print()
        error_timestamp = datetime.now()
        error_logger.writeErrorLog( 
            timestamp = error_timestamp, 
            type = "USB_CONN",
            opt_msg = exception.args[0],
            debug = debug_mode
        )
        sys.exit(1)
    else:
        return port
def tryToReadSerialPort(port, debug_mode: bool=False):
    try:
        trama = port.read_until( config_embedded.CHAR_FINISH_PDU )
    except serial.serialutil.SerialException as serial_exception:
        print("USB-Serial CH340 desconectado...")
        print(serial_exception.args[0])
        print()
        error_timestamp = datetime.now()
        error_logger.writeErrorLog( 
            timestamp = error_timestamp, 
            type = "USB_HOT_UNPLUGGED",
            opt_msg = serial_exception.args[0],
            debug = debug_mode
        )
        sys.exit(1)
    else:
        return trama


# Funciones del receptor
def Registrador( print_info: bool = True ) -> None:
    """Este programa es el Registrador para el Embebido.
    Recibe las tramas, las procesa, y escribe en la base de datos todo lo util."""

    # Inicio la conexión con la base de datos
    db_con = tryToConnectToDataBase()
    print(f"Conectado a la base de datos: {config_SQL_Database.db_name}")

    # Abro el puerto serie
    serial_port = tryToOpenSerialPort()
    print("Conectado a la máquina (USB-Serial CH340)")


    # Inicio los Samples
    prev_sample = initSample()
    curr_sample = initSample()
    # Inicio las listas de Reportes
    prev_report_list = list()
    curr_report_list = list()

    with serial_port:
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
                trama += tryToReadSerialPort(serial_port)
                
            # Si hubo desconexion
            else:
                # Saco el timeout
                serial_port.timeout = None
                # Recibo hasta CHAR_FINISH_PDU, sin límite de tiempo
                trama += tryToReadSerialPort(serial_port)
            
            # Si se recibió una trama completa
            if len(trama) >= config_embedded.BUFFER_SIZE_ONLY_DATA_MODE:
            
                # Chequeo el PDU
                check = checkReceivedPDU(trama)

                # ACK
                if check == True:
                    # Respondo ACK
                    serial_port.write(config_embedded.ACK)

                    # Si se recompuso la conexion
                    if hubo_desconexion:
                        if print_info:
                            print("Se logro una NUEVA CONEXION")
                        # Reseteo el flag de desconexion
                        hubo_desconexion = False
                        # Pongo el timeout nuevamente
                        serial_port.timeout = DISCONNECTION_TIME

                    if print_info:
                        # Aviso que se recibió la trama con respuesta ACK
                        print("Trama recibida (Respuesta: ACK)")
                        # Muestro la trama recibida
                        showReceivedPDU( trama )

                    # Genero el Sample a partir de la trama recibida
                    curr_sample = getSamplesFromFrame(trama, datetime.now())

                    # Cuento la trama a escribir
                    tramas_a_escribir += 1

                    # Si es la primera trama luego de una escritura
                    if tramas_a_escribir == 1:
                        # Limpio la lista de Reportes previa
                        prev_report_list.clear()
                    
                    # Genero/actualizo la lista de Reportes
                    curr_report_list = getReportsFromSample(curr_sample, prev_sample, prev_report_list)
                    if print_info:
                        # Muestro los reportes acumulados
                        showReports(curr_report_list)
                        
                    # Si tengo todas las tramas para escribir
                    if tramas_a_escribir >= MAX_FRAMES_TO_WRITE:
                        # Escribo en la base todos los reportes
                        writeDatabaseFromReports( curr_report_list, db_con )                                 
                        # Reseteo el contador de tramas a escribir
                        tramas_a_escribir = 0
                        if print_info:
                            # Muestro la tabla actualizada
                            SQL_Writer.selectLast(db_con, config_SQL_Database.LAST_N_TO_SELECT)

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
                    serial_port.write(config_embedded.NAK)

                    if print_info:
                        # Aviso que se recibió la trama con respuesta NAK
                        print("Trama recibida (Respuesta: \t NAK)")
                        # Muestro la trama recibida
                        showReceivedPDU(trama)

                    # Limpio la trama para recibir una nueva
                    trama = bytes()
            
            # Sino se recibió una trama, hubo una DESCONEXIÓN
            else:
                # Seteo el flag de desconexion
                hubo_desconexion = True
                error_logger.writeErrorLog( 
                    timestamp = datetime.now(), 
                    type = "USB_MUTE", 
                    last_ok_timestamp = curr_sample[0],
                    debug = False 
                )


                # Si hay tramas a escribir en la base
                if tramas_a_escribir != 0:
                    if print_info:
                        # Aviso que se perdió al menos una trama
                        print( "DESCONEXION: Al menos una trama se perdio! Guardo en la base lo que tengo" )

                    # Escribo en la base todos los reportes
                    writeDatabaseFromReports( curr_report_list, db_con )                                 
                    # Reseteo el contador de tramas a escribir
                    tramas_a_escribir = 0
                    
                    if print_info:
                        # Muestro la tabla actualizada
                        SQL_Writer.selectLast(db_con, config_SQL_Database.LAST_N_TO_SELECT)
                # No hay tramas a escribir en la base
                else:
                    if print_info:
                        # Aviso que se perdió al menos una trama
                        print( "DESCONEXION: Al menos una trama se perdio! Nada para escribir en la base" )
                
                # Reseteo los samples
                # Se perdió registro, entonces las próximas son todas SESSION_STARTED
                curr_sample = initSample()
                prev_sample = initSample()
                # Reseteo los reportes, por la misma razón
                curr_report_list = list()
                prev_report_list = list()
def SerialTester( forced_answer: bytes = None ) -> None:
    """Este programa testea la conexión serie y la validez de las tramas.
    NO ESCRIBE EN LA BASE DE DATOS - Sólo testea la conexión serie.
    Si se le pasa forced_answer, responde SIEMPRE con éstos bytes sin importar que reciba, 
    de lo contrario, responde lo que corresponda.
    Muestra además en pantalla, los datos recibidos y si hay desconexiones."""

    # Abro el puerto serie
    serial_port = tryToOpenSerialPort(debug_mode=True)
    print("Conectado a la máquina (USB-Serial CH340)")
    

    with serial_port:
        # Limpio cualquier basura previa en el puerto
        serial_port.flush()
        serial_port.reset_input_buffer()

        # Inicializo los contadores
        contador_naks = 0
        contador_tramas = 1

        # Loop principal
        trama = bytes()
        hubo_desconexion = False
        last_dt = datetime.now()
        while 1:
            
            # Si todo anda bien
            if not hubo_desconexion:
                # Recibo hasta CHAR_FINISH_PDU, con DISCONNECTION_TIME segundos como límite
                trama += tryToReadSerialPort(serial_port, debug_mode=True)

            # Si hubo desconexion
            else:
                # Saco el timeout
                serial_port.timeout = None
                # Recibo hasta CHAR_FINISH_PDU, sin límite de tiempo
                trama += tryToReadSerialPort(serial_port, debug_mode=True)
            
            # Si se recibió una trama completa
            if len(trama) >= config_embedded.BUFFER_SIZE_ONLY_DATA_MODE:
            
                # Obtengo un timestamp
                curr_dt = datetime.now()

                # Chequeo el PDU
                check = checkReceivedPDU(trama)
            
                # ACK
                if check == True:
                    if forced_answer in config_embedded.FORCED_ANSWERS.values():
                        # Respuesta forzada
                        serial_port.write(forced_answer)
                        #Muestro los datos de la trama
                        showAllDataForcedAnswer(trama, contador_tramas, contador_naks, curr_dt, last_dt, forced_answer)
                   
                    else:
                        # Testeo normal
                        serial_port.write(config_embedded.ACK)
                        # Muestro los datos de la trama
                        showAllDataAck(trama, contador_tramas, contador_naks, curr_dt, last_dt)
                        # Espero para limpiar el buffer de recepción, 
                        time.sleep(CLEAR_RX_BUFFER_TIME)
                        # Limpio el buffer de recepción por posible unex_ans recibida en el embebido
                        serial_port.reset_input_buffer()

                    # Guardo el timestamp como el último
                    last_dt = curr_dt                    
                    # Limpio la trama para recibir una nueva
                    trama = bytes()
                        
                    # Si se recompuso la conexion
                    if hubo_desconexion:
                        # Aviso de la reconexión
                        print("Se logro una NUEVA CONEXION con esta trama\n\n")
                        # Reseteo el contador de tramas
                        contador_tramas = 1 
                        # Reseteo acumuladores estadísticos
                        resetAverage()
                        resetStandardDeviation()
                        # Reseteo el flag de desconexion
                        hubo_desconexion = False
                        # Pongo el timeout nuevamente
                        serial_port.timeout = DISCONNECTION_TIME

                # NAK
                else:
                    if forced_answer in config_embedded.FORCED_ANSWERS.values():
                        # Respuesta forzada
                        serial_port.write(forced_answer)
                        #Muestro los datos de la trama
                        showAllDataForcedAnswer(trama, contador_tramas, contador_naks, curr_dt, last_dt, forced_answer)
                   
                    else:
                        # Testeo normal
                        serial_port.write(config_embedded.NAK)
                        # Muestro los datos de la trama
                        showAllDataNak(trama, contador_tramas, contador_naks, curr_dt, last_dt)

                    # Cuento el NAK
                    contador_naks += 1
                    # Limpio la trama para recibir una nueva
                    trama = bytes()

                # Cuento la trama llegada (sin importar ACK o NAK)
                contador_tramas += 1
                    
            # Sino se recibió una trama, hubo una DESCONEXIÓN
            else:
                # Seteo el flag de desconexion
                hubo_desconexion = True
                error_logger.writeErrorLog(
                    timestamp = datetime.now(), 
                    type = "USB_MUTE", 
                    last_ok_timestamp = curr_dt,
                    debug = True
                )

                # Aviso de la desconexión
                print("DESCONEXION: Al menos una trama se perdio!")                      

# Función Principal
def main():
    """
    Este programa puede tomar hasta 2 argumentos por línea de comandos:

    1. -registrador <window>
    Para escribir en la base de datos.
        Las opciones para <window?> son: 
            "-background" o "-windowless"   -> Para ejecutar en segundo plano
            "-foreground" o "-windowed"     -> Para mostrar consola con todos los mensajes

    2. -serial_tester
    Para mostrar los datos recibidos. No escribe en la base de datos.

    3. -respuesta_forzada <respuesta>
    Para mostrar los datos recibidos, respondiendo <respuesta> siempre. No escribe en la base de datos.
        Las opciones de <respuesta> están en el diccionario config_embedded.FORCED_ANSWERS
    """
    # Carga estandar de argumentos por línea de comandos a una lista
    args = sys.argv[1:]

    # Default (para debuggear)
    if len(args) == 0:
        Registrador(print_info=True)
    
    # Registrador
    if len(args) == 2 and args[0] == "-registrador":
        if   args[1] == "-background" or args[1] == "-windowless":
            console_window_control.hideConsoleWindow()
            Registrador(print_info=False)

        elif args[1] == "-foreground" or args[1] == "-windowed":
            console_window_control.showConsoleWindow()
            Registrador(print_info=True)
        
    # Serial Tester
    elif len(args) == 1 and args[0] == "-serial_tester":
        SerialTester()

    # Tester Forced Answer
    elif len(args) == 2 and args[0] == "-respuesta_forzada" and args[1] in config_embedded.FORCED_ANSWERS.keys():
        SerialTester(forced_answer=config_embedded.FORCED_ANSWERS.get(args[1]))
   

if __name__ == "__main__":
    main()