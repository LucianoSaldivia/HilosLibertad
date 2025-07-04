# config_boards.py

# Placas conectadas (sólo sesiones de éstas se escribirán en la base)
BOARD0 = True
BOARD1 = True
BOARD2 = False
BOARD3 = False

# Maquinas de cada placa
step = 1 # auxiliar para formar las listas a partir de range
# IdMaq = #Bornera en placa
BOARD0_MAQ = list( range( 0, 16, step) ) if BOARD0 else list()
BOARD0_MAQ.remove( 0) # Bornera sin Máquina conectada
BOARD0_MAQ.remove( 1) # Bornera sin Máquina conectada
BOARD0_MAQ.remove( 2) # Bornera sin Máquina conectada
BOARD0_MAQ.remove( 3) # Bornera sin Máquina conectada
BOARD0_MAQ.remove( 4) # Bornera sin Máquina conectada
BOARD0_MAQ.remove( 5) # Bornera sin Máquina conectada
# IdMaq (= #Bornera) 6, 7 y 8 asignadas
BOARD0_MAQ.remove( 9) # Bornera sin Máquina conectada
BOARD1_MAQ = list( range(16, 32, step) ) if BOARD1 else list()
BOARD1_MAQ.remove(22) # Bornera sin Máquina conectada
BOARD1_MAQ.remove(23) # Bornera sin Máquina conectada
BOARD2_MAQ = list( range(32, 48, step) ) if BOARD2 else list()
BOARD3_MAQ = list( range(48, 64, step) ) if BOARD3 else list()

# Maquinas totales
MAX_MAQS = 64

# Maquinas conectadas
CONNECTED_MAQS = BOARD0_MAQ + BOARD1_MAQ + BOARD2_MAQ + BOARD3_MAQ

# print(CONNECTED_MAQS)


