# EstadosEventosSesiones.py

import enum
from datetime import datetime


# Número de máquinas 
# Valor a cambiar en MANTENIMIENTO: 
# DEBE SER MENOR A MAX_MAQ
#    |
#    |
#    |
#    |
# \     /
#  \   /
#   \ /
#    V
N_MAQ = 20
#    A
#   / \
#  /   \
# /     \
#    |
#    |
#    |
#    |

# Número máximo de máquinas (NO CAMBIAR)
MAX_MAQ = 200



# Posibles estados de cada máquina
class State(enum.IntEnum):
    STOPPED = 0
    WORKING = 1
# Posibles eventos para cada máquina
class Event(enum.IntEnum):
    NO_SESSION          = 0     # no hay sesión
    SESSION_STARTED     = 1     # Sesión Activa -> inicia
    SESSION_CONTINUES   = 2     # Sesión Activa -> continua
    SESSION_FINISHED    = 3     # Sesión Activa -> termina


# Estado inicial de cada máquina por default
INIT_STATE = State.STOPPED.value


# Inicialización de una muestra (lista de estados de las máquinas)
def sampleInit(sample: list = None, offset: int = 1) -> list:
    """Retorna una lista de largo MAX_MAQ + 1.
    Si no se pasa lista, retorna:
        [datetime.now(), STOPPED, STOPPED, ...]
    Si se pasa lista sin offset, retorna:
        [datetime.now(), sample[0], ..., sample[len(sample)-1], STOPPED, STOPPED, ...]
    Si se pasa lista y offset, la lista sample, empieza en el índice offset.
        debe cumplirse: offset >= 1 and offset < ( MAX_MAQ - len(sample) )
    """
    
    # Inicio todas en INIT_STATE por default
    if sample is None:
        # out[0] = datetime.now()
        out = list( [datetime.now()] )
        out.extend( [INIT_STATE] * (MAX_MAQ) )
        return out

    # Tengo un muestreo incompleto, testeo offset
    elif not ( 1 <= offset < MAX_MAQ - len(sample) ):
        raise Exception("Debe cumplirse: 1 <= offset < MAX_MAQ - len(sample)")
    else:
        
        # out[0] = datetime.now()
        out = list( [datetime.now()] )

        # Agrego lo que esté antes del offset
        for i in range(1, offset):
            out.append(INIT_STATE)

        # Agrego sample a partir de offset
        for i in sample:
            if i == 0 or i == State.STOPPED or i is None:
                out.append( State.STOPPED.value )
            elif i != 0 or i == State.WORKING:
                out.append( State.WORKING.value )
        
        # Agrego el resto
        for i in range(offset + len(sample), MAX_MAQ + 1):
            out.append(INIT_STATE)

        return out

# Obtengo lista simplificada de Reportes
def getReportList(prev_st: list, curr_st: list, lastReport: list = None) -> list:
    """Compara los cambios de estados, para detectar eventos de la sesión de cada máquina.
    Para cada máquina, evalúa:
        STOPPED a STOPPED   -> NO_SESSION
        STOPPED a WORKING   -> SESSION_STARTED
        WORKING a WORKING   -> SESSION_CONTINUES
        WORKING a STOPPED   -> SESSION_FINISHED
    Luego, compara con las sesiones anteriores, y guarda una lista por máquina, que contiene:
        [ ID_MAQ, Start_DT, Last_DT, Last_Event ]
    donde DT es DateTime.
    Retorna una lista de estas listas.

    Para la posición 0, se espera un DateTime del momento en que curr_st fue cargado.
    """
    # Si las listas tienen distinto tamaño, no se pueden comparar
    if len(prev_st) != len(curr_st):
        raise Exception("Debe cumplirse: len(prev_st) == len(curr_st)")
    else:
        
        # Nuevo reporte (luego de escritura a base de datos)
        if lastReport is None:
            new_report = list()
            for i in range(len(curr_st)):
                # Si sigue parada, me voy, sino entro
                if not( prev_st[i] == State.STOPPED and curr_st[i] == State.STOPPED ):

                    # Machine state from STOPPED to WORKING -> SESSION_STARTED
                    if   prev_st[i] == State.STOPPED and curr_st[i] == State.WORKING: 
                        new_report.append( [i, curr_st[0], curr_st[0], Event.SESSION_STARTED] )
                    
                    # Machine state from WORKING to WORKING -> SESSION_CONTINUES
                    elif prev_st[i] == State.WORKING and curr_st[i] == State.WORKING:
                        new_report.append( [i, curr_st[0], curr_st[0], Event.SESSION_CONTINUES] )
                    
                    # Machine state from WORKING to STOPPED -> SESSION_FINISHED
                    elif prev_st[i] == State.WORKING and curr_st[i] == State.STOPPED:
                        new_report.append( [i, curr_st[0], curr_st[0], Event.SESSION_FINISHED] )
            return new_report
        
        # Ya hubo un reporte, tengo que actualizarlo
        else:
            for i in range(len(curr_st)):
                # Si sigue parada, me voy, sino entro
                if not( prev_st[i] == State.STOPPED and curr_st[i] == State.STOPPED ):

                    # Machine state from STOPPED to WORKING -> SESSION_STARTED
                    if   prev_st[i] == State.STOPPED and curr_st[i] == State.WORKING: 
                        # Como sólo empieza, no tengo que chequear nada y agrego a la lista
                        lastReport.append( [i, curr_st[0], curr_st[0], Event.SESSION_STARTED] )
                    
                    # Machine state from WORKING to WORKING -> SESSION_CONTINUES
                    elif prev_st[i] == State.WORKING and curr_st[i] == State.WORKING:
                        for j in range(len(lastReport)):
                            # Encuentro el último reporte "Started" o "Continues" de ésta máquina
                            if lastReport[j][0] == i and lastReport[j][3] != Event.SESSION_FINISHED:
                                # Actualizo el Last_DT
                                lastReport[j][2] = curr_st[0]
                                # Actualizo el Last_Event a SESSION_CONTINUES
                                lastReport[j][3] = Event.SESSION_CONTINUES
                                break
                    
                    # Machine state from WORKING to STOPPED -> SESSION_FINISHED
                    elif prev_st[i] == State.WORKING and curr_st[i] == State.STOPPED:
                        for j in range(len(lastReport)):
                            # Encuentro el último reporte "Started" o "Continues" de ésta máquina
                            if lastReport[j][0] == i and lastReport[j][3] != Event.SESSION_FINISHED:
                                # Actualizo el Last_DT
                                lastReport[j][2] = curr_st[0]
                                # Actualizo el Last_Event a SESSION_FINISHED
                                lastReport[j][3] = Event.SESSION_FINISHED
                                break
            return lastReport    


if __name__ == "__main__":
    from time import time
    # Sesión de Testeo
        #
        #   0. Todo apagado
        #   1. Empiezan 1, 2 y 3
        #   2. Continúa 1, 2 y 3
        #   3. Finaliza 1, continúa 2 y 3
        #   4. Continúan 2 y 3
        #   5. Finalizan 2 y 3
        #   6. Todo apagado
        #   7. Empieza 1, 3 y 4
        #   8. Finalizan 1 y 4
        #   9. Finaliza 3
        #


    # 0. Todo apagado
    sample_prev = sampleInit()
    sample_cur = sampleInit()

    reporte = getReportList(sample_prev, sample_cur)
    print( reporte )

    # 1. Empiezan máquina 1, 2 y 3
    sample_prev = sampleInit()
    sample_cur = sampleInit([1, 1, 1])
    print( getReportList(sample_prev, sample_cur, reporte) )

    # 2. Continúan 1, 2 y 3
    sample_prev = sample_cur
    sample_cur = sample_cur
    print( getReportList(sample_prev, sample_cur, reporte) )

    # 3. Finaliza 1, continúan 2 y 3
    sample_prev = sample_cur
    sample_cur = sampleInit([0, 1, 1])
    print( getReportList(sample_prev, sample_cur, reporte) )

    # 4. Continúan 2 y 3
    sample_prev = sample_cur
    sample_cur = sample_cur
    print( getReportList(sample_prev, sample_cur, reporte) )

    # 5. Finalizan 2 y 3
    sample_prev = sample_cur
    sample_cur = sampleInit()
    print( getReportList(sample_prev, sample_cur, reporte) )

    # 6. Todo apagado
    sample_prev = sample_cur
    sample_cur = sample_cur
    print( getReportList(sample_prev, sample_cur, reporte) )

    # 7. Empieza 1, 3 y 4
    sample_prev = sample_cur
    sample_cur = sampleInit([1, 0, 1, 1])
    print( getReportList(sample_prev, sample_cur, reporte) )
        
    #   8. Finalizan 1 y 4
    sample_prev = sample_cur
    sample_cur = sampleInit([0, 0, 1])
    print( getReportList(sample_prev, sample_cur, reporte) )
         
    #   9. Finaliza 3
    sample_prev = sample_cur
    sample_cur = sampleInit()
    print( getReportList(sample_prev, sample_cur, reporte) )