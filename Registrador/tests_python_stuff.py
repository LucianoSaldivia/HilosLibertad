# test_python_suff.py


import serial
import config_serial
import serial.tools.list_ports

def vaciadorDeListas( lista: list ) -> list: 
    lista.clear()
    return lista



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


if __name__ == "__main__":
    
    #print( get_CH340_Port().name )
    with serial.Serial( port = config_serial.PUERTO_SERIE_COM,
                        baudrate = config_serial.SELECTED_BAUDRATE,
                        parity = config_serial.SELECTED_PARITY,
                        stopbits = config_serial.SELECTED_STOPBITS,
                        bytesize = config_serial.SELECTED_BYTE_SIZE,
                        timeout = None
                        ) as serial_port:
        print( "Abierto" )

    if serial_port.is_open:
        serial_port.close()


