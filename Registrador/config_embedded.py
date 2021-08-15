# config_embedded.py

# Tiempos del Embebido (pero en Segundos)
TIMEOUT_TIME = 0.1
# TIME_BETWEEN_FRAMES = 60
TIME_BETWEEN_FRAMES = 5

# Caracter de fin de trama
CHAR_FINISH_PDU = b"#"

# Caracteres de respuesta a tramas
ACK = b"%"
NAK = b"?"
UNEX_ANS = b"$"
FORCE_TIMEOUT = bytes()

# Tamaños de las tramas según el modo
BUFFER_SIZE_ONLY_DATA_MODE = 10
BUFFER_SIZE_DATA_INFO_MODE = 19