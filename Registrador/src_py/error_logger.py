from datetime import datetime, timedelta

# Archivos
log_file_relative_path = "errors.log"

# Posibles errores: Mensaje
ErrorLogMsg = {
    "DB_CONN":  "No se pudo conectar con la base de datos",
    "DB_WRITE": "No se pudo escribir en la Base de Datos. Última conexión/escritura OK: ",
    "USB_CONN": "No se pudo conectar con CH340 (Driver USB de la máquina)",
    "USB_MUTE": "No se recibieron más datos de la máquina. Último dato recibido: ",
    "USB_LOST": "Se perdió la conexión con la máquina. Último dato recibido: "
}

def writeErrorLog(timestamp: datetime, type: str, last_ok_timestamp: datetime = None, opt_msg: str = str()) -> None:
    """Escribe el log correspondiente al tipo de error pasado por <type>, con el datetime pasado como timestamp.
    Las opciones para <type> son:
        "DB_CONN", "DB_WRITE", "USB_CONN", "USB_MUTE", "USB_LOST"    
        ( ErrorLogMsg.keys() )
    """
    
    if last_ok_timestamp is None:
        last_ok_timestamp_str = str()
    else:
        last_ok_timestamp_str = str(last_ok_timestamp)
    
    log_line = (
        str(timestamp) + " - " + "Error Log Code: " + type 
        + " - " + ErrorLogMsg.get(type) + 
        last_ok_timestamp_str + ". " + opt_msg + "\n"
    )
    # Abro el archivo como "(a)ppend", "over(w)rite", o (x)"create"
    with open(log_file_relative_path, "a") as fd:
        fd.write( log_line )
        fd.flush()
        print( log_line )


def main():
    writeErrorLog( datetime.now(), "DB_WRITE", datetime.now() - timedelta(minutes=5), msg="holagil" )

if __name__ == "__main__":
    main()