# EstadosSesiones.py

# _ID_MAQ = "idMaquina"
# _INIT_DT = "fechaHoraEncendido"
# _LAST_DT = "fechaHoraUltimoRegistroEncendido"
# _TRND_OFF = "fueApagadaPorOperarioOPorFallaParticular"



import enum

# N_MAQ es el número máximo de máquinas
N_MAQ = 256
# INI_MAQ_STATE es el valor inicial de la máquina
INI_MAQ_STATE = 0 


# Eventos en la sesión de cada máquina
class SessionEvents(enum.Enum):
    """Eventos en la sesione de cada máquina. Los eventos posibles son:
        NO_SESSION          -> La máquina no se prendió desde la última sesión registrada
        START_SESSION       -> La máquina fue prendida, se inicia una sesión
        CONTINUE_SESSION    -> La máquina sigue prendida, continúa la sesión
        FINISH_SESSION      -> La máquina fue apagada, termina la sesión exitosamente
    """
    NO_SESSION = int(0)
    START_SESSION = int(1)
    CONTINUE_SESSION = int(2)
    FINISH_SESSION = int(3)

# Estados de cada máquina
class State(enum.Enum):
    """Estados de cada máquina. Los estados posibles son:
        STOPPED -> La máquina está apagada
        WORKING -> La máquina está trabajando
    """
    STOPPED = int(0)
    WORKING = int(1)

# Inicialización de una muestra (estados de las máquinas)
def SampleInit(sample: list = None, offset: int = 1) -> list:
    """Retorna una lista de largo N_MAQ, 
    en donde todos los estados indican STOPPED
    [State.STOPPED, State.STOPPED, ...]"""
    if sample is None:
        return [State.STOPPED] * N_MAQ

    elif len(sample) == N_MAQ:
        out = list()

        for i in sample:
            if i == 0 or i == State.STOPPED or i is None:
                out.append(State.STOPPED)
            
            elif i != 0 or i == State.WORKING:
                out.append(State.WORKING)
        
        return out

    else:
        out = list()
        # Agrego lo que esté antes del offset
        for i in range(offset):
            out.append(State.STOPPED)

        # Agrego sample a partir de offset
        for i in sample:
            if i == 0 or i == State.STOPPED or i is None:
                out.append( State.STOPPED )
            elif i == 1 or i == State.WORKING:
                out.append( State.WORKING )
        
        # Agrego el resto
        for i in range(offset + len(sample), N_MAQ):
            out.append(State.STOPPED)

        return out

# Inicialización de lista de eventos (cambios de estados de las máquinas)
def SessionEventsInit() -> list:
    """Retorna una lista de largo N_MAQ, 
    en donde todos los eventos indican NO_SESSION
    [SessionEvents.NO_SESSION,SessionEvents.NO_SESSION, ...]"""
    return [SessionEvents.NO_SESSION] * N_MAQ


def GetSessionsEvents(prev_st: list, curr_st: list) -> list:
    """Compara los cambios de estados, para detectar eventos de la sesión de cada máquina.
    Para cada máquina, evalúa:
        STOPPED a STOPPED   -> NO_SESSION
        STOPPED a WORKING   -> START_SESSION
        WORKING a WORKING   -> CONTINUE_SESSION
        WORKING a STOPPED   -> FINISHED_SESSION
    Retorna una lista con los eventos de cada máquina.
    """

    if len(prev_st) != len(curr_st):
        raise Exception("previous and current state tuples have different length")
    else: 
        out = SessionEventsInit()
        for i in range(len(prev_st)):
            # Machine state from STOPPED to STOPPED -> NO_SESSION
            if   prev_st[i] == State.STOPPED and curr_st[i] == State.STOPPED:
                out[i] = SessionEvents.NO_SESSION
            
            # Machine state from STOPPED to WORKING -> START_SESSION
            elif prev_st[i] == State.STOPPED and curr_st[i] == State.WORKING:
                out[i] = SessionEvents.START_SESSION
            
            # Machine state from WORKING to WORKING -> CONTINUE_SESSION
            elif prev_st[i] == State.WORKING and curr_st[i] == State.WORKING:
                out[i] = SessionEvents.CONTINUE_SESSION
            
            # Machine state from WORKING to STOPPED -> FINISH_SESSION
            elif prev_st[i] == State.WORKING and curr_st[i] == State.STOPPED:
                out[i] = SessionEvents.FINISH_SESSION
        return out
def ActiveSessions(Events: list) -> list:
    out = list()
    for i in range(N_MAQ):
        if Events[i] != SessionEvents.NO_SESSION:
            out.append( [i, Events[i]] )
    return out

# Obtengo lista de listas_, donde listas_ contienen [ID_MAQ, SessionEvent]
def GetActiveSessions(prev_st: list, curr_st: list) -> list:
    """Compara los cambios de estados, para detectar eventos de la sesión de cada máquina.
    Para cada máquina, evalúa:
        STOPPED a STOPPED   -> NO_SESSION           (evento de sesión NO actica)
        STOPPED a WORKING   -> START_SESSION        (evento de sesión activa)
        WORKING a WORKING   -> CONTINUE_SESSION     (evento de sesión activa)
        WORKING a STOPPED   -> FINISHED_SESSION     (evento de sesión activa)
    Arma una lista con índice y evento correspondiente a cada máquina en sesión activa.
    Retorna una lista de estas listas.
    """
    if len(prev_st) != len(curr_st):
        raise Exception("previous and current state tuples have different length")
    else:
        out = list()
        for i in range(len(prev_st)):
            # Si sigue parada, me voy, sino entro
            if not( prev_st[i] == State.STOPPED and curr_st[i] == State.STOPPED ):
                
                # Machine state from STOPPED to WORKING -> START_SESSION
                if   prev_st[i] == State.STOPPED and curr_st[i] == State.WORKING: 
                    out.append( [i, SessionEvents.START_SESSION] )
                
                # Machine state from WORKING to WORKING -> CONTINUE_SESSION
                elif prev_st[i] == State.WORKING and curr_st[i] == State.WORKING:
                    out.append( [i, SessionEvents.CONTINUE_SESSION] )
                
                # Machine state from WORKING to STOPPED -> FINISH_SESSION
                elif prev_st[i] == State.WORKING and curr_st[i] == State.STOPPED:
                    out.append( [i, SessionEvents.FINISH_SESSION] )
    return out



if __name__ == "__main__":

    # Sesión de Testeo
        #
        #   1. Todo apagado
        #   2. Empiezan 1, 2 y 3
        #   3. Continúa 1, 2 y 3
        #   4. Finaliza 1, continúa 2 y 3
        #   5. Continúan 2 y 3
        #   6. Finalizan 2 y 3
        #   7. Continúa todo apagado
        # 

    # Todo apagado
    sample_prev = SampleInit()
    sample_cur = SampleInit()

    print( GetActiveSessions(sample_prev, sample_cur) )

    # Empiezan máquina 1, 2 y 3
    sample_prev = SampleInit()
    sample_cur = SampleInit([1, 1, 1])
    print( GetActiveSessions(sample_prev, sample_cur) )

    # Continúan 1, 2 y 3
    sample_prev = sample_cur
    sample_cur = sample_cur
    print( GetActiveSessions(sample_prev, sample_cur) )

    # Finaliza 1, continúan 2 y 3
    sample_prev = sample_cur
    sample_cur = SampleInit([0, 1, 1])
    print( GetActiveSessions(sample_prev, sample_cur) )

    # Continúan 2 y 3
    sample_prev = sample_cur
    sample_cur = sample_cur
    print( GetActiveSessions(sample_prev, sample_cur) )

    # Finalizan 2 y 3
    sample_prev = sample_cur
    sample_cur = SampleInit()
    print( GetActiveSessions(sample_prev, sample_cur) )

    # Continúan todo apagado
    sample_prev = sample_cur
    sample_cur = sample_cur
    print( GetActiveSessions(sample_prev, sample_cur) )

    print( GetActiveSessions.__doc__ )