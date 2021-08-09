# defines.py


# Tiempos del Embebido (pero en Segundos)
TIMEOUT_TIME = 0.1
TIME_DESIRED_BETWEEN_READS = 12

# Cantidad de máquinas
CANT_MAQ = 64

# Caracter de fin de trama
CHAR_FINISH_PDU = b"#"
# Caracteres de respuesta a tramas
ACK = b"%"
NAK = b"?"
UNEX_ANS = b"$"
# Tamaños de las tramas según el modo
BUFFER_SIZE_ONLY_DATA_MODE = 10
BUFFER_SIZE_DATA_INFO_MODE = 19