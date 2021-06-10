# test_hilos_main.py

from SQL import EstadosSesiones
from SQL import SQL_Test1
from datetime import date, datetime, timedelta
from tcp_ip.EasyWANServer import EasyTCPServer, socket

# Tutoriales y fuentes:
    #
    # Tutorial: Instalar SQL Server
    # https://www.youtube.com/watch?v=YOaC_TyOrdk&ab_channel=C%C3%B3digosdeProgramaci%C3%B3n-MarcoRobles
    #
    # Tutorial: Enviar Queries de python a SQL Server
    # https://www.youtube.com/watch?v=aF552bMEcO4

# Check "netstat -an" on terminal
HOST = "192.168.0.210"  # Standard local area network interface address (192.168...)
PORT = 8082             # Port to listen on (non-privileged ports are > 1023)


def getSamplesFromFrame(frame: bytes) -> list:
    """Decodificación de la trama a lista, donde
    lista[0]    -> ID_MAQ
    lista[3?]   -> STATE
    """
    # Decodifico bytes a str
    datos = frame.decode()
    # Corto en cada instancia de "[" en el str
    datos = datos.split("[")
    
    # # Inicio una lista de Sample
    # estados = EstadosSesiones.SampleInit()

    # Inicio una lista vacía
    estados = [None] * EstadosSesiones.N_MAQ

    for i in range(1, len(datos)):
        estados[ int(datos[i][0]) ] = int( datos[i][3] )
    
    out = EstadosSesiones.SampleInit(estados)

    return out

def useDatabaseWithSessions(sessions: list, db_con: any, timestamp: datetime):
    """A partir de las sesiones activas, genero el conjunto de datos útiles,
    y los mando a la base de datos:
    NO_SESSION          -> ~ (Sesión no activa)
    START_SESSION       -> insertSessionStarts(db_con, session_dict)
    CONTINUE_SESSION    -> updateSessionContinues(db_con, session_dict)
    FINISH_SESSION      -> updateSessionFinishes(db_con, session_dict)
    """
    for i in range(1, len(sessions)):
        if sessions[i] != EstadosSesiones.SessionEvents.NO_SESSION:
            
            if sessions[i] == EstadosSesiones.SessionEvents.START_SESSION:
                session_dict = {
                    SQL_Test1.ID_MAQ: i,
                    SQL_Test1.INIT_DT: timestamp,
                    SQL_Test1.LAST_DT: timestamp,
                    SQL_Test1.TRND_OFF: 0 }
                SQL_Test1.insertSessionStarts(db_con, session_dict)

            if sessions[i] == EstadosSesiones.SessionEvents.CONTINUE_SESSION:
                session_dict = {
                    SQL_Test1.ID_MAQ: i,
                    SQL_Test1.INIT_DT: timestamp,
                    SQL_Test1.LAST_DT: timestamp,
                    SQL_Test1.TRND_OFF: 0 }
                SQL_Test1.updateSessionContinues(db_con, session_dict)
                    
            if sessions[i] == EstadosSesiones.SessionEvents.FINISH_SESSION:
                session_dict = {
                    SQL_Test1.ID_MAQ: i,
                    SQL_Test1.INIT_DT: timestamp,
                    SQL_Test1.LAST_DT: timestamp,
                    SQL_Test1.TRND_OFF: 1 }
                SQL_Test1.updateSessionFinishes(db_con, session_dict)


if __name__ == "__main__":

    # Inicio el server
    server = EasyTCPServer(host= HOST, port= PORT, msgs= True, mirror= False)

    # Inicio los previous samples por default
    prev_samples = EstadosSesiones.SampleInit()

    # Inicio la conexión con la base de datos
    db_con = SQL_Test1.connectToDatabase()

    # Escucho hasta 10 conexiones
    server.listenForConnections(10)
    while True:
        # Acepto primera conexión en cola, o espero hasta que haya una y acepto
        client = server.acceptConnection()
        
        # Recibo bytes en data
        data = server.receiveDataFrom(client, 1024)
        while data:

            # Guardo el timestamp del momento en que se recibió data
            timestamp = datetime.now()

            # Obtengo lista limpia de current samples a partir de data
            curr_samples = getSamplesFromFrame(data)

            # Obtengo lista de sesiones a partir de previous samples y current samples 
            sesiones = EstadosSesiones.GetSessionsEvents(prev_samples, curr_samples)

            # Mando las sesiones activas a la base de datos
            useDatabaseWithSessions(sesiones, db_con, timestamp)

            # Actualizo previous samples para el próximo ciclo del loop
            prev_samples = curr_samples

            # Muestro las últimas 15 filas en la tabla de la base
            # SQL_Test1.selectLast(db_con, 15)

            # Recibo más bytes en data
            data = server.receiveDataFrom(client, 1024)

