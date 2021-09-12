from datetime import datetime
import os, sys

# Ruta a los archivos .log
debug_log_file_relative_path = "\\..\\Logs\\debug_errors.log"
release_log_file_relative_path = "\\..\\Logs\\release_errors.log"


# Posibles errores: Mensaje
ErrorLogMsg = {
    "DB_CONN":              "No se pudo conectar con la base de datos",
    "DB_WRITE":             "No se pudo escribir en la Base de Datos. Última conexión/escritura OK: ",
    "USB_CONN":             "No se pudo conectar con CH340 (Driver USB de la máquina)",
    "USB_MUTE":             "No se recibieron más datos de la máquina. Máquina apagada o desconectada. Último dato recibido: ",
    "USB_HOT_UNPLUGGED":    "Se perdió la conexión con la máquina"
}

error_type_max_chars = len( max(ErrorLogMsg.keys(), key=len) )

def writeErrorLog(timestamp: datetime, type: str, last_ok_timestamp: datetime=None, opt_msg: str=str(), debug: bool=False) -> None:
    """Escribe el log correspondiente al tipo de error pasado por <type>, con el datetime pasado como timestamp.
    Las opciones para <type> son:
        "DB_CONN", "DB_WRITE", "USB_CONN", "USB_MUTE", "USB_LOST"    
        ( ErrorLogMsg.keys() )
    """
    
    if last_ok_timestamp is None:
        last_ok_timestamp_str = str()
    else:
        last_ok_timestamp_str = str(last_ok_timestamp)


    # 26 caracteres para timestamp
    log_line = "{:<26}".format( str(timestamp) ) + " -> "

    # error_type_max_chars caracteres para type
    error_type_format = "{:<%d}" %error_type_max_chars
    log_line += "Error: " + error_type_format.format(type) + " -> " + ErrorLogMsg.get(type)
    log_line += last_ok_timestamp_str + ". " + opt_msg + "\n"

    # Abro el archivo como "(a)ppend", "over(w)rite", o (x)"create"
    file_path = os.path.dirname( os.path.abspath(sys.argv[0]) )
    file_path += debug_log_file_relative_path if debug else release_log_file_relative_path

    with open(file_path, "a") as fd:
        fd.write( log_line )
        fd.flush()
        print( file_path + ": \n" + log_line )


def main():
    writeErrorLog( 
        timestamp = datetime.now(), 
        type = "USB_MUTE",
        opt_msg="test_msg",
        debug=True 
    )


if __name__ == "__main__":
    main()