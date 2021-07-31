import pyodbc
from datetime import datetime, timedelta

# Tutoriales y fuentes:
    #
    # Tutorial: Instalar SQL Server
    # https://www.youtube.com/watch?v=YOaC_TyOrdk&ab_channel=C%C3%B3digosdeProgramaci%C3%B3n-MarcoRobles
    #
    # Tutorial: Enviar Queries de python a SQL Server
    # https://www.youtube.com/watch?v=aF552bMEcO4

device_name = "LUCIANO-PC"
db_name = "prueba1"
table_name = "HL.registros"


VIEW_NAME = "HL.v_registrador"
PROC_INSERT = "HL.sp_insertarSesion"
PROC_UPDATE = "HL.sp_actualizarSesion"
PROC_FINISH = "HL.sp_terminarSesion"

#   Select Functions
def selectLast(conn: any, n: int):
    """Hago un SELECT de los últimos n registros, según la vista VIEW_NAME:
    SELECT TOP n * FROM v_registrador ORDER BY LAST_DT DEST
    """
    print(f"Select last {n} from table")
    cursor = conn.cursor()
    cursor.execute(f"SELECT TOP {n} * FROM {VIEW_NAME} ORDER BY LAST_DT DESC")
    
    _showSelectedRows(cursor)
def selectAll(conn: any):
    """Hago un SELECT de toda la tabla, según la vista VIEW_NAME:
    SELECT * FROM v_registrador ORDER BY LAST_DT DESC
    """
    print("Select complete table")
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {VIEW_NAME} ORDER BY LAST_DT DESC")
    _showSelectedRows(cursor)

#   Procedures Queries Functions
def sessionStarts(conn, data: dict):
    """Llamo al procedimiento PROC_INSERT como en el siguiente ejemplo:
    EXEC HL.sp_insertarSesion 1, '2018-30-09 16:00:00'
    donde le paso:
        ID_MAQ
		INIT_DT como 'YYYY-DD-MM HH:MM:SS'
    """
    print("sessionStarts")
    cursor = conn.cursor()

    init_dt_str = data[INIT_DT].strftime("%Y-%d-%m %H:%M:%S")
    # Ejecuto el procedimiento
    cursor.execute( f"EXEC {PROC_INSERT} {data[ID_MAQ]}, '{init_dt_str}'" )
    conn.commit()
def sessionContinues(conn, data: dict):
    """Llamo al procedimiento PROC_UPDATE como en el siguiente ejemplo:
    EXEC HL.sp_actualizarSesion 1, '2018-30-09 16:05:00'
    donde le paso:
        ID_MAQ
		LAST_DT como 'YYYY-DD-MM HH:MM:SS'
    """
    print("sessionContinues")
    cursor = conn.cursor()

    last_dt_str = data[LAST_DT].strftime("%Y-%d-%m %H:%M:%S")
    # Ejecuto el procedimiento  
    cursor.execute( f"EXEC {PROC_UPDATE} {data[ID_MAQ]}, '{last_dt_str}'" )
    conn.commit()
def sessionFinishes(conn, data: dict):
    """Llamo al procedimiento PROC_FINISH como en el siguiente ejemplo:
    EXEC HL.sp_terminarSesion 1, '2018-30-09 16:45:00'
    donde le paso:
        ID_MAQ
		LAST_DT como 'YYYY-DD-MM HH:MM:SS'
    """
    print("sessionFinishes")
    cursor = conn.cursor()

    last_dt_str = data[LAST_DT].strftime("%Y-%d-%m %H:%M:%S")
    # Ejecuto el procedimiento
    cursor.execute( f"EXEC {PROC_FINISH} {data[ID_MAQ]}, '{last_dt_str}'" )
    conn.commit()

#   Delete table Function
def deleteTable(conn, table: str):
    """Limpio la tabla table completa, como se haría en el siguiente ejemplo:
    DELETE FROM HL.registros
    DBCC CHECKIDENT ('HL.registros', RESEED, 0)
    """
    cursor = conn.cursor()
    # Limpio la tabla
    cursor.execute( f"DELETE FROM {table}" )
    conn.commit()
    # Resiembro (próximo entra con índice 1)
    cursor.execute( f"DBCC CHECKIDENT ('{table}', RESEED, 0)" )
    conn.commit()
    
#   Connection Function
def connectToDatabase():
    driver_str = _getDriverName()

    ### FORMATEO LOS STRINGS
    driver_line = "Driver={" + driver_str + "};"
    server_line = "Server=" + device_name + ";"
    db_line = "Database=" + db_name + ";"
    trusted_conn_line = "Trusted_Connection=yes;"
    connection_str = driver_line + server_line + db_line + trusted_conn_line

    try:
        conn = pyodbc.connect(connection_str)
    except:
        print("Hubo un problema en la conexión a la base de datos...")
    return conn

ID_MAQ = "idMaquina"
INIT_DT = "fechaHoraEncendido"
LAST_DT = "fechaHoraUltimoRegistroEncendido"
TRND_OFF = "fueApagadaPorOperarioOPorFallaParticular"

#   Private Functions
def _showSelectedRows(c: any):
    print("" + 
        "IDM" + " " +
        "INIT_DT" + "              " +
        "LAST_DT" + "            " + 
        "TRND_OFF" + " " + "Mins_ON")
    for row in c:
        # Mostrar en crudo
        # print(f"row = {row}")
        # Mostrar lindo
        _showRow("", row)
    print()
def _showRow(ini: str, row: any):
    out = ini
    sep = " "
    
    # 4 caracteres para ID_MAQ
    out += "{:<3}".format(str(row[0])) + sep         
    
    # 20 caracteres para INIT_DT
    out += "{:<20}".format(row[1].strftime("%Y-%m-%d %H:%M:%S")) + sep        
    
    # 20 caracteres para LAST_DT (incluso si es NULL)
    if row[2] is None:
        out += "{:<20}".format("NULL") + sep       
    else: 
        out += "{:<20}".format(row[2].strftime("%Y-%m-%d %H:%M:%S")) + sep

    # 6 caracteres para TRND_OFF
    out += "{:<6}".format(str(row[3])) + sep         
    
    # 6 caracteres para MINS_ON (incluso si es NULL)
    if row[4] is None:
        out += "{:<6}".format("NULL") + sep
    else:
        out += "{:<6}".format(str(row[4])) + sep

    print(out)
def _getDriverName() -> str:
    driver_name = ''
    driver_names = [x for x in pyodbc.drivers() if x.endswith(' for SQL Server')]
    if driver_names:
        driver_name = driver_names[0]
    if driver_name:
        # conn_str = 'DRIVER={}; ...'.format(driver_name)
        # then continue with ...
        return f'{format(driver_name)}'
        # pyodbc.connect(conn_str)
        # ... etc.
    else:
        return '(No suitable driver found. Cannot connect.)'



if __name__ == "__main__":

    with connectToDatabase() as conn:

        new_data = {
            ID_MAQ: 1,
            INIT_DT: datetime.now() - timedelta(minutes = 45),
            LAST_DT: datetime.now(),
            TRND_OFF: 0
        }

        sessionStarts(conn, new_data)
        
        new_data2 = {
            ID_MAQ: 1,
            INIT_DT: datetime.now() - timedelta(minutes = 45),
            LAST_DT: datetime.now() + timedelta(hours = 2),
            TRND_OFF: 0
        }

        sessionContinues(conn, new_data2)
        selectLast(conn, 30)

        new_data3 = {
            ID_MAQ: 1,
            INIT_DT: datetime.now() - timedelta(minutes = 45),
            LAST_DT: datetime.now() + timedelta(hours = 2, minutes= 15),
            TRND_OFF: 0
        }

        sessionFinishes(conn, new_data3)

        selectLast(conn, 30)
        print()

        deleteTable(conn, table_name)

    print("Todo OK")
