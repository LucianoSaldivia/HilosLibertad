# serial_1.py

import serial
import crc8
from datetime import datetime



PUERTO = "COM3"
MAX_CANT_RECEPCIONES = 10000
TIME_TO_SLEEP_BEFORE_RESPONSE = 0.05

ACK = b'%'
NAK = b'?'
CHAR_FINISH_PDU = b'#'
BUFFER_SIZE_ONLY_DATA_MODE = 10
BUFFER_SIZE_DATA_INFO_MODE = 19


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
    for i in range(0, BUFFER_SIZE_ONLY_DATA_MODE - 1):
        bits_string += "{0:08b}".format( ord(PDU_bytes.decode()[i]) ) + " "
    # Si la trama es DATA + INFO, muestro el resto en ascii [9:17]
    if len(PDU_bytes) == BUFFER_SIZE_DATA_INFO_MODE:
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

if __name__ == "__main__":
  
    with serial.Serial(port = PUERTO,
                        baudrate = 115200,
                        parity = serial.PARITY_NONE,
                        stopbits = serial.STOPBITS_ONE,
                        bytesize = serial.EIGHTBITS ) as serial_port:

        serial_port.flush()

        last_dt = datetime.now()
        contador_naks = 0
        contador_tramas = 1
        while contador_tramas <= MAX_CANT_RECEPCIONES:
            # Recibo hasta CHAR_FINISH_PDU
            recibidos = serial_port.read_until(CHAR_FINISH_PDU)
            check = checkReceivedPDU(recibidos)
            
            # Espero a que se habilite la recepción
            # time.sleep(TIME_TO_SLEEP_BEFORE_RESPONSE)

            if check == True:
                serial_port.write(ACK)
            else:
                serial_port.write(NAK)
                    
            # Calculo la diferencia de tiempo con la trama anterior
            curr_dt = datetime.now()
            delta_dt = curr_dt - last_dt
            last_dt = curr_dt

            # Muestro lo recibido y la respuesta
            if contador_tramas == 1:
                print( f"Trama {contador_tramas} - Hora de inicio: {curr_dt}" )
                pass
            else:
                print( f"Trama {contador_tramas} - deltaT: {delta_dt} - DT: {curr_dt}" )
            showReceivedPDU(recibidos)
            if check == True:
                print(f"Response: ACK( {ACK.decode()} )")
            else: 
                print(f"Response: NAK( {NAK.decode()} )")
                contador_naks += 1

            # Bit 0
            bit0 = int(recibidos[7]) & 0x01
            print( "bit 0: " + str(bit0) )

            # NAKs acumulados
            print( f"NAKs acumulados {contador_naks}" )



            
            print()
            contador_tramas += 1

    if serial_port.is_open:
        serial_port.close()