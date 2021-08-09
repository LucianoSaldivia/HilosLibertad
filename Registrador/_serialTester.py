# _serialTester.py

import serial
import crc8
import defines
from datetime import datetime, timedelta
import time
from math import sqrt


# Conexión
PUERTO = "COM3"

# Tiempos de desconexión y limpieza de buffer de recepción
CLEAR_RX_BUFFER_TIME = 14 * defines.TIMEOUT_TIME
DISCONNECTION_TIME = 2 * defines.TIME_DESIRED_BETWEEN_READS


# Funciones para chequear PDU
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

# Calculo del promedio (de forma acumulativa)
def average( new_number: float ):
    average.n += 1
    average.last_average = ( average.last_average * (average.n-1) + new_number ) / average.n
    return average.last_average
average.last_average = timedelta()
average.n = 0
# Calculo de la desviación estándar (de forma acumulativa)
def standardDeviation( new_number: float ):
    standardDeviation.sum  += new_number
    standardDeviation.sum2 += new_number*new_number
    standardDeviation.n    += 1.0
    sum, sum2, n = standardDeviation.sum, standardDeviation.sum2, standardDeviation.n
    return sqrt(sum2/n - sum*sum/n/n)
standardDeviation.n = standardDeviation.sum = standardDeviation.sum2 = 0
# Resets de acumuladores estadísticos
def resetAverage():
    average.last_average = timedelta()
    average.n = 0
def resetStandardDeviation():
    standardDeviation.n = standardDeviation.sum = standardDeviation.sum2 = 0


# Muestro la trama y sus datos
def showAllDataAck( trama: bytes, contador_tramas: int, contador_naks: int, curr_dt: datetime, last_dt: datetime ):
    # Muestro el número de trama y el TimeStamp
    print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()}" )
    # Muestro datos estadísticos (asumiendo distribución normal, mostrando promedio y desviación estándar)
    if contador_tramas >= 3:
        print( f"Promedio(deltaT): {average(curr_dt-last_dt)} - Desviación Estándar(deltaT): {standardDeviation((curr_dt-last_dt).total_seconds())}" )
    # Muestro la trama completa
    showReceivedPDU(trama)
    # Muestro la respuesta y los NAKs acumulados
    print(f"Response: ACK( {defines.ACK.decode()} ) - NAKs acumulados {contador_naks}")
    # Pongo un separador para la siguiente trama
    print()
def showAllDataNak( trama: bytes, contador_tramas: int, contador_naks: int, curr_dt: datetime, last_dt: datetime ):
    # Muestro el número de trama y el TimeStamp
    print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()}" )
    # Muestro datos estadísticos (asumiendo distribución normal, mostrando promedio y desviación estándar)
    if contador_tramas >= 3:
        print( f"Promedio(deltaT): {average(curr_dt-last_dt)} - Desviación Estándar(deltaT): {standardDeviation((curr_dt-last_dt).total_seconds())}" )
    # Muestro la trama completa
    showReceivedPDU(trama)
    # Muestro la respuesta y los NAKs acumulados
    print(f"Response: NAK( {defines.NAK.decode()} ) - NAKs acumulados {contador_naks}")
    # Pongo un separador para la siguiente trama
    print()
def showAllDataForcedAnswer( trama: bytes, contador_tramas: int, contador_naks: int, curr_dt: datetime, last_dt: datetime ):
    # Muestro el número de trama y el TimeStamp
    print( f"Trama {contador_tramas} - TimeStamp: {curr_dt.time()}" )
    # Muestro datos estadísticos (asumiendo distribución normal, mostrando promedio y desviación estándar)
    if contador_tramas >= 3:
        print( f"Promedio(deltaT): {average(curr_dt-last_dt)} - Desviación Estándar(deltaT): {standardDeviation((curr_dt-last_dt).total_seconds())}" )
    # Muestro la trama completa
    showReceivedPDU(trama)
    # Muestro la respuesta y los NAKs acumulados
    print(f"Response: ( {FORCED_ANS.decode()} ) - NAKs acumulados {contador_naks}")
    # Pongo un separador para la siguiente trama
    print()


if __name__ == "__main__":
    """Este programa simula ser el Registrador para el Embebido.
    Muestra además en pantalla, los datos recibidos y si hay desconexiones."""

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
                trama += serial_port.read_until( defines.CHAR_FINISH_PDU )
            # Si hubo desconexion
            else:
                # Saco el timeout
                serial_port.timeout = None
                # Recibo hasta CHAR_FINISH_PDU, sin límite de tiempo
                trama += serial_port.read_until( defines.CHAR_FINISH_PDU )
            
            # Si se recibió una trama completa
            if len(trama) >= defines.BUFFER_SIZE_ONLY_DATA_MODE:
            
                # Obtengo un timestamp
                curr_dt = datetime.now()

                # Chequeo el PDU
                check = checkReceivedPDU(trama)
            
                # ACK
                if check == True:
                    # Respondo ACK
                    serial_port.write(defines.ACK)

                    # Si se recompuso la conexion
                    if hubo_desconexion:
                        # Aviso de la reconexión
                        print( "Se logro una nueva conexión. Empiezo a contar tramas de nuevo." )
                        # Reseteo el contador de tramas
                        contador_tramas = 1 
                        # Reseteo acumuladores estadísticos
                        resetAverage()
                        resetStandardDeviation()
                        # Reseteo el flag de desconexion
                        hubo_desconexion = False
                        # Pongo el timeout nuevamente
                        serial_port.timeout = DISCONNECTION_TIME
                    
                    # Muestro los datos de la trama
                    showAllDataAck( trama, contador_tramas, contador_naks, curr_dt, last_dt )
                    
                    # Guardo el timestamp como el último
                    last_dt = curr_dt

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

                    # Cuento el NAK
                    contador_naks += 1

                    # Muestro los datos de la trama
                    showAllDataNak( trama, contador_tramas, contador_naks, curr_dt, last_dt )

                    # Limpio la trama para recibir una nueva
                    trama = bytes()

                # Cuento la trama llegada (sin importar ACK o NAK)
                contador_tramas += 1
                    
            # Sino se recibió una trama, hubo una DESCONEXIÓN
            else:
                # Seteo el flag de desconexion
                hubo_desconexion = True

                # Aviso de la desconexión
                print( "DESCONEXIÓN: Al menos una trama se perdió!" )  

    if serial_port.is_open:
        serial_port.close()