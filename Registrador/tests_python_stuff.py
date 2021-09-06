# test_python_suff.py


import serial
import serial.tools.list_ports
import time
import ctypes


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


def show_console():
    """Muestra la Ventana de la Consola."""
    # Show console window
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 4)
    
def hide_console():
    """Esconde la Ventana de la Consola."""
    # Hide console window
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 0)
    


def main():
    
    # printAllCOMPorts()

    for i in range(0, 5):
        if i%2 == 0:
            print("Escondo consola en 1s")
            time.sleep(1)
            hide_console()
        else:
            print("Muestro consola en 1s")
            time.sleep(1)
            show_console()


if __name__ == "__main__":
    main()