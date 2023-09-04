# test_python_suff.py


import serial
import serial.tools.list_ports
import time
import ctypes
from datetime import datetime, timedelta
import enum
import config_relay_types


# Python
def vaciadorDeListas( lista: list ) -> list: 
    lista.clear()
    return lista

# Serial
def printAllCOMPorts():
    ports = serial.tools.list_ports.comports(include_links=False)
    for port in ports:
        print(port.device + " " + str(port.hwid) + " *** " + str(port.description) )
    print()
def get_CH340_Port():
    ports = serial.tools.list_ports.comports(include_links=False)
    for port in ports:
        if str(port.description).find("USB-Serial CH340"):
            return port

# Console
def showConsole():
    """Muestra la Ventana de la Consola."""
    # Show console window
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 4)
def hideConsole():
    """Esconde la Ventana de la Consola."""
    # Hide console window
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 0)
    
# Archivos
log_file_name = "errors.log"

# Posibles errores
ErrorLogMsg = {
    "DB_CONN":  "No se pudo conectar con la base de datos.\n",
    "DB_WRITE": "Conexión con la Base de datos OK, no se pudo escribir (falló un insert/update). Última conexión/escritura OK: ",
    "USB_CONN": "No se pudo conectar con CH340 (Driver USB de la máquina).\n",
    "USB_MUTE": "Conexión con el USB OK, pero no se recibieron más datos de la máquina. Último dato recibido: ",
    "USB_LOST": "Se perdió la conexión con la máquina. Último dato recibido: "
}

def writeErrorLog(timestamp: datetime, type: str, last_ok_timestamp: datetime = None):
    """Escribe el log correspondiente al tipo de error pasado por <type>, con el datetime pasado como timestamp.
    Las opciones para <type> son:
        "DB_CONN", "DB_WRITE", "USB_CONN", "USB_MUTE", "USB_LOST"    
        ( ErrorLogMsg.keys() )
    """
    
    if last_ok_timestamp is None:
        end_log_line = "\n"
    else:
        end_log_line = str(last_ok_timestamp) + "\n"
    
    log_line = str(timestamp) + " - " + ErrorLogMsg.get(type) + end_log_line
    
    # Abro el archivo como "(a)ppend", "over(w)rite", o (x)"create"
    with open(log_file_name, "a") as fd:
        fd.write( log_line )
        print( log_line )



class State(enum.IntEnum):
    STOPPED = 0                 # Máquina apagada
    WORKING = 1                 # Máquina trabajando

def getSamplesFromFrame1(frame: bytes, timestamp: datetime) -> list: # Original, Funciona pero asume relay Normalmente Abierto
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
            # Agrego el valor correspondiente (0 -> STOPPED; 1 -> WORKING)
            sample.append( State.WORKING 
                    if ( frame[byte_in_frame] & (0x01 << bit_in_byte) ) 
                    else State.STOPPED )
            
    # Retorno la lista Sample completa
    return sample
def getSamplesFromFrame2(frame: bytes, timestamp: datetime) -> list:
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

            # Muestro todo
            # print(f"idMAQ: {idMAQ_curr:02d} -> Bit: {int(bit_state)} -> Estado: {estado} --- RelayType = {config_relay_types.RELAY_TYPE[idMAQ_curr]}")
          
    # Retorno la lista Sample completa
    return sample

def main():
    # writeErrorLog( datetime.now(), ErrorLogMsg.get("DB_WRITE"), datetime.now() - timedelta(minutes=5) )


    # Empiezo con un string de la trama recibida (ejemplo) como se imprime en el Registrador
    s = "00000000 00001010 00000000 00001010 00000000 00001010 00000000 00001011 11111111" # El último byte es el CRC !
    print(f"s original: \t\t{s}")
    s = s.replace(" ", "")
    print(f"s sin espacios: \t{s}")
    
    def bitstring_to_bytes(s):
        return int(s, 2).to_bytes(len(s) // 8, byteorder='big')

    frame = bitstring_to_bytes(s)

    rango = range(0, 9)
    bit_str = str()
    for byte in rango:
        for bit in reversed( range(0, 8) ):
            bit_str += str( ( frame[byte] & (1 << bit) ) >> bit )
        bit_str += " "

    print( f"Received: " + bit_str)

    sample = getSamplesFromFrame1(frame, datetime.now())
    # sample = getSamplesFromFrame2(frame, datetime.now())

    # Tipo de cada sample
    print(type(sample[-1]))

    for i, estado in enumerate(sample):
        if i == 0:
            print(f"\tSample datetime: {estado}")
        else:
            print(f"idMAQ: {i:02d} -> Estado: {estado} --- RelayType = {config_relay_types.RELAY_TYPE[i]}")
    
    exit()

if __name__ == "__main__":
    main()