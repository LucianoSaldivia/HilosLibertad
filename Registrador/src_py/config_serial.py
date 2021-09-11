# config_serial.py

import serial
import serial.tools.list_ports

# CH340 Port finder
def get_CH340_Port() -> serial.tools.list_ports_common.ListPortInfo:
    ports = serial.tools.list_ports.comports(include_links=False)
    for port in ports:
        if str(port.description).find("USB-Serial CH340"):
            print( "USB-Serial CH340 encontrado en el puerto " + str(port.name) )
            return port
    raise Exception("USB-Serial CH340 no detectado en ningún puerto. Compruebe conexión y Driver.")

# Puerto COM
# PUERTO_SERIE_COM = str(get_CH340_Port().name)
#PUERTO_SERIE_COM = "COM6"


# Configuración
SELECTED_BAUDRATE  = 115200
SELECTED_PARITY    = serial.PARITY_NONE
SELECTED_STOPBITS  = serial.STOPBITS_ONE
SELECTED_BYTE_SIZE = serial.EIGHTBITS


