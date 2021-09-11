from datetime import datetime

# Archivos
log_file_relative_path = "../errors.log"

# Posibles errores: Mensaje
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
    with open(log_file_relative_path, "a") as fd:
        fd.write( log_line )
        print( log_line )