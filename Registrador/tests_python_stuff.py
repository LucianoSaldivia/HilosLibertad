# test_python_suff.py


# import serial
    # import serial.tools.list_ports

    # def vaciadorDeListas( lista: list ) -> list: 
    #     lista.clear()
    #     return lista


    # def printAllCOMPorts():
    #     ports = serial.tools.list_ports.comports(include_links=False)
    #     for port in ports:
    #         print(port.device + " " + str(port.hwid) + " *** " + str(port.description) )
    #     print()

    # def get_CH340_Port():
    #     ports = serial.tools.list_ports.comports(include_links=False)
    #     for port in ports:
    #         if str(port.description).find("USB-Serial CH340"):
    #             return port


import ctypes
import time

def show_console():
    """Brings up the Console Window."""
    # Show console
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 4)
    
def hide_console():
    """Hides the Console Window."""
    # Hide console
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 0)
    

console_toggle = False




def main():
    
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