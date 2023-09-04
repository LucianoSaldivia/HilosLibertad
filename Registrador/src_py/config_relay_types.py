# config_boards.py

import enum
class RelayType(enum.Flag):
    NORMAL_ABIERTO = False  # Normalmente Abierto (bit=0 -> State.STOPPED; bit=1 -> State.WORKING)
    NORMAL_CERRADO = True   # Normalmente Cerrado (bit=1 -> State.STOPPED; bit=0 -> State.WORKING)

# RELAY_TYPE[ idMAQ ] = RelayType
# idMAQ -> número de bornera entre 1 y 64 (deben estar en CONNECTED_MAQS en config_boards.py)


# Creo el array vacío (valores en 0, no en "RelayType.XXXX")
RELAY_TYPE = [ 0, ]*65


# Comentar los cambios para ver los NORMAL_CERRADO rápidamente



RELAY_TYPE[  1 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  2 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  3 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  4 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  5 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  6 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  7 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  8 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[  9 ] = RelayType.NORMAL_CERRADO
RELAY_TYPE[ 10 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 11 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 12 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 13 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 14 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 15 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 16 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 17 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 18 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 19 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 20 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 21 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 22 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 23 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 24 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 25 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 26 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 27 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 28 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 29 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 30 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 31 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 32 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 33 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 34 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 35 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 36 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 37 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 38 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 39 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 40 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 41 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 42 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 43 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 44 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 45 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 46 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 47 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 48 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 49 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 50 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 51 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 52 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 53 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 54 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 55 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 56 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 57 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 58 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 59 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 60 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 61 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 62 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 63 ] = RelayType.NORMAL_ABIERTO
RELAY_TYPE[ 64 ] = RelayType.NORMAL_ABIERTO

# print(RELAY_TYPE)