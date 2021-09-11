# config_boards.py

# Placas conectadas (sólo sesiones de éstas se escribirán en la base)
BOARD0 = True
BOARD1 = True
BOARD2 = False
BOARD3 = False

# Maquinas de cada placa
BOARD0_MAQ = list( range(1     , 16 + 1) ) if BOARD0 else list()
BOARD1_MAQ = list( range(16 + 1, 32 + 1) ) if BOARD1 else list()
BOARD2_MAQ = list( range(32 + 1, 48 + 1) ) if BOARD2 else list()
BOARD3_MAQ = list( range(48 + 1, 64 + 1) ) if BOARD3 else list()

# Maquinas totales
MAX_MAQS = 64

# Maquinas conectadas
CONNECTED_MAQS = BOARD0_MAQ + BOARD1_MAQ + BOARD2_MAQ + BOARD3_MAQ
