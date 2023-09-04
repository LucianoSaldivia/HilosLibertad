# config_boards.py

# Placas conectadas (sólo sesiones de éstas se escribirán en la base)
BOARD0 = True
BOARD1 = True
BOARD2 = False
BOARD3 = False

# Maquinas de cada placa
step = 1 # auxiliar para formar las listas a partir de range
BOARD0_MAQ = list( range(1 , 16+step, step) ) if BOARD0 else list()
BOARD0_MAQ.remove(8 ) # Bornera sin Máquina conectada
BOARD1_MAQ = list( range(17, 32+step, step) ) if BOARD1 else list()
BOARD1_MAQ.remove(21) # Bornera sin Máquina conectada
BOARD1_MAQ.remove(32) # Bornera sin Máquina conectada
BOARD2_MAQ = list( range(33, 48+step, step) ) if BOARD2 else list()
BOARD3_MAQ = list( range(49, 64+step, step) ) if BOARD3 else list()

# Maquinas totales
MAX_MAQS = 64

# Maquinas conectadas
CONNECTED_MAQS = BOARD0_MAQ + BOARD1_MAQ + BOARD2_MAQ + BOARD3_MAQ

# print(CONNECTED_MAQS)
