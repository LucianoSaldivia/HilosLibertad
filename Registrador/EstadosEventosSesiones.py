# EstadosEventosSesiones.py

import enum
import datetime
import time


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
N_MAQ = 32
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
def sampleInit(sample: list = None, offset: int = 1, state: State = INIT_STATE) -> list:
    """Retorna una lista de largo MAX_MAQ + 1.
    Si no se pasa lista, retorna:
        [datetime.now(), STOPPED, STOPPED, ...]
    Si se pasa lista sin offset, retorna:
        [datetime.now(), sample[0], ..., sample[len(sample)-1], STOPPED, STOPPED, ...]
    Si se pasa lista y offset, la lista sample, empieza en el índice offset.
        debe cumplirse: offset >= 1 and offset < ( MAX_MAQ - len(sample) )
    """
    
    # Inicio todas en state (INIT_STATE) por default
    if sample is None:
        # out[0] = datetime.datetime.now()
        out = list( [datetime.datetime.now()] )
        out.extend( [state] * (MAX_MAQ) )
        return out

    # Tengo un muestreo incompleto, testeo offset
    elif not ( 1 <= offset < MAX_MAQ - len(sample) ):
        raise Exception(f"""Debe cumplirse: 1 <= offset < MAX_MAQ - len(sample)
        offset = {offset}
        MAX_MAQ - len(sample) = {MAX_MAQ - len(sample)}""")
    else:
        
        # out[0] = datetime.datetime.now()
        out = list( [datetime.datetime.now()] )

        # Agrego lo que esté antes del offset
        for i in range(1, offset):
            out.append(state)

        # Agrego sample a partir de offset
        for i in sample:
            if i == 0 or i == State.STOPPED or i is None:
                out.append( State.STOPPED.value )
            elif i != 0 or i == State.WORKING:
                out.append( State.WORKING.value )
        
        # Agrego el resto
        for i in range(offset + len(sample), MAX_MAQ + 1):
            out.append(state)

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
        raise Exception(f"""Debe cumplirse: len(prev_st) == len(curr_st)
        len(prev_st) = {len(prev_st)}
        len(curr_st) = {len(curr_st)}""")
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

def _testSession(session_n: int, lastReport: list = None, lastSample: list = None, secs_between_samples: float = 0.03) -> tuple[list, list]:
    """Hace una sesión de testeo. Si todo sale bien, devuelve:
    (reportList, lastSample)
    Sesiones de testeo, según session_n:
        0.  Empiezan todas 
            Terminan todas
        
        1.  Empiezan todas
            Termina la primera mitad
            Termina la segunda mitad
        
        2.  Empieza la primera mitad
            Termina la primera mitad y empieza la segunda
            Termina la segunda mitad
        
        3.  Empiezan todas
            Terminan las impares
            Terminan las pares
        
        4.  Empizan las pares
            Terminan las pares y empiezan las impares
            Terminan las impares y empiezan las pares
    """
    if session_n < 0:
        raise Exception(f"""session_n debe ser positivo.
        session_n = {session_n}""")
    else:
        if lastSample == None:
            prev_sample = sampleInit()
        else:
            prev_sample = lastSample
    
    if   session_n == 0:
        # Empiezan todas
        curr_sample = sampleInit(state=State.WORKING)
        reporte = getReportList(prev_sample, curr_sample, lastReport)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )
        
        # Terminan todas
        prev_sample = curr_sample
        curr_sample = sampleInit()
        return getReportList(prev_sample, curr_sample, reporte), curr_sample
    
    elif session_n == 1:
        # Empiezan todas
        curr_sample = sampleInit(state=State.WORKING)
        reporte = getReportList(prev_sample, curr_sample, lastReport)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )
        
        # Termina la primera mitad
        prev_sample = curr_sample
        curr_sample = sampleInit(state=State.WORKING)
        for i in range( 1, int(len(curr_sample)/2) ):
            curr_sample[i] = State.STOPPED
        reporte = getReportList(prev_sample, curr_sample, reporte)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )

        # Termina la segunda mitad
        prev_sample = curr_sample
        curr_sample = sampleInit()
        return getReportList(prev_sample, curr_sample, reporte), curr_sample
    
    elif session_n == 2:
        # Empieza la primera mitad
        curr_sample = sampleInit()
        for i in range( 1, int(len(curr_sample)/2) ):
            curr_sample[i] = State.WORKING
        reporte = getReportList(prev_sample, curr_sample, lastReport)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )
        
        # Termina la primera mitad y empieza la segunda
        prev_sample = curr_sample
        curr_sample = sampleInit()
        for i in range( int(len(curr_sample)/2), len(curr_sample) ):
            curr_sample[i] = State.WORKING
        reporte = getReportList(prev_sample, curr_sample, reporte)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )

        # 2. Termina la segunda mitad
        prev_sample = curr_sample
        curr_sample = sampleInit()
        return getReportList(prev_sample, curr_sample, reporte), curr_sample
    
    elif session_n == 3:
        # Empiezan todas
        curr_sample = sampleInit(state=State.WORKING)
        reporte = getReportList(prev_sample, curr_sample, lastReport)
        
        # Doy tiempo entre samples
        time.sleep( secs_between_samples )

        # Terminan las impares
        prev_sample = curr_sample
        curr_sample = sampleInit(state=State.WORKING)
        for i in range(1, len(curr_sample), 2):
            curr_sample[i] = State.STOPPED
        reporte = getReportList(prev_sample, curr_sample, reporte)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )

        # Terminan las pares
        prev_sample = curr_sample
        curr_sample = sampleInit()
        return getReportList(prev_sample, curr_sample, reporte), curr_sample
    
    elif session_n == 4:
        # Empiezan las pares
        curr_sample = sampleInit(state=State.STOPPED)
        for i in range(2, len(curr_sample), 2):
            curr_sample[i] = State.WORKING
        reporte = getReportList(prev_sample, curr_sample, lastReport)
        
        # Doy tiempo entre samples
        time.sleep( secs_between_samples )

        # Terminan las pares y empiezan las impares
        prev_sample = curr_sample
        curr_sample = sampleInit(state=State.STOPPED)
        for i in range(1, len(curr_sample), 2):
            curr_sample[i] = State.WORKING
        reporte = getReportList(prev_sample, curr_sample, reporte)

        # Doy tiempo entre samples
        time.sleep( secs_between_samples )

        # Terminan las impares
        prev_sample = curr_sample
        curr_sample = sampleInit()
        return getReportList(prev_sample, curr_sample, reporte), curr_sample


if __name__ == "__main__":

    # # Testeo una sesión
        # session_under_test = 1

        # report, lastSample = testSession2( session_under_test )
        # print( *report, sep = "\n")
        # print()

    # Testeo todas las sesiones en orden
    report, last_sample = _testSession(session_n=0)
    time.sleep(.2)
    report, last_sample = _testSession(session_n=1, lastSample=last_sample, lastReport=report)
    time.sleep(.2)
    report, last_sample = _testSession(session_n=2, lastSample=last_sample, lastReport=report)
    time.sleep(.2)
    report, last_sample = _testSession(session_n=3, lastSample=last_sample, lastReport=report)
    time.sleep(.2)
    report, last_sample = _testSession(session_n=4, lastSample=last_sample, lastReport=report)

    print( *report, sep = "\n")
    print(f"len(report) = {len(report)}")
    print()

