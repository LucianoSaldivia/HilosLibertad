# test_python_suff.py


import serial
import serial.tools.list_ports
import time
import ctypes
from datetime import datetime, timedelta


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

def test_error_log():
    writeErrorLog( datetime.now(), ErrorLogMsg.get("DB_WRITE"), datetime.now() - timedelta(minutes=5) )

def main():
    BOARD0_MAQ = list( range(1     , 16 + 1) ) # if BOARD0 else list()
    BOARD1_MAQ = list( range(16 + 1, 23 + 1) ) # if BOARD1 else list()

    print(BOARD0_MAQ + BOARD1_MAQ)

if __name__ == "__main__":
    main()