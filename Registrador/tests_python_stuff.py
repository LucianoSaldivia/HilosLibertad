# test_python_suff.py


import serial
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

    printAllCOMPorts()