# config_embedded.py

# ¿Modo de Debug? (para tiempo entre tramas)
DEBUG_MODE = True

# Tiempos del Embebido (pero en Segundos)
if DEBUG_MODE:
    TIME_BETWEEN_FRAMES = 5
else:
    TIME_BETWEEN_FRAMES = 60
TIMEOUT_TIME = 0.1

# TIME_BETWEEN_FRAMES = 5

# Caracter de fin de trama
CHAR_FINISH_PDU = b"#"

# Caracteres de respuesta a tramas
ACK = b"%"
NAK = b"?"
UNEX_ANS = b"$"
FORCE_TIMEOUT = bytes()
FORCED_ANSWERS = {
    "ACK": ACK,
    "ack": ACK,
    "NAK": NAK,
    "nak": NAK,
    "UNEX_ANS": UNEX_ANS,
    "unex_ans": UNEX_ANS,
    "TIMEOUT": FORCE_TIMEOUT,
    "timeout": FORCE_TIMEOUT
}

# Tamaños de las tramas según el modo
BUFFER_SIZE_ONLY_DATA_MODE = 10
BUFFER_SIZE_DATA_INFO_MODE = 19