import pyodbc
from datetime import datetime, timedelta

# Tutoriales y fuentes:
    #
    # Tutorial: Instalar SQL Server
    # https://www.youtube.com/watch?v=YOaC_TyOrdk&ab_channel=C%C3%B3digosdeProgramaci%C3%B3n-MarcoRobles
    #
    # Tutorial: Enviar Queries de python a SQL Server
    # https://www.youtube.com/watch?v=aF552bMEcO4




def selectLast(conn: any, n: int):
    """Hago un SELECT de los últimos n registros:
    SELECT TOP n * FROM table_name ORDER BY INIT_DT DESC
    """
    print(f"Select last {n} from table")
    cursor = conn.cursor()
    cursor.execute(f"SELECT TOP {n} * FROM {table_name} ORDER BY {INIT_DT} DESC")
    _showSelectedRows(cursor)
def selectAll(conn: any):
    """Hago un SELECT de toda la tabla:
    SELECT * FROM table_name
    """
    print("Select complete table")
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {table_name}")
    _showSelectedRows(cursor)
def _showSelectedRows(c: any):
    for row in c:
        _showRow("fila: ", row)
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

    # 5 caracteres para TRND_OFF
    out += "{:<6}".format(str(row[3])) + sep         
    
    # 4 caracteres para minutes_on (incluso si es NULL)
    if row[4] is None:
        out += "{:<10}".format("NULL") + sep
    else:
        out += "{:<10}".format(str(row[4])) + sep

    print(out)

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

def insertSessionStarts(conn, data: dict):
    """Hago un INSERT de ID_MAQ, INIT_DT y LAST_DT en data, TRND_OFF = 0 porque empieza la sesión:
        INSERT INTO table_name (ID_MAQ, INIT_DT, LAST_DT, TRND_OFF)
            VALUES(
                data[ID_MAQ], 
                CAST( data[INIT_DT] AS SMALLDATETIME ),
                CAST( data[LAST_DT] AS SMALLDATETIME ), 
                0
            )
    """
    print("insertSessionStarts")
    cursor = conn.cursor()

    # Ejemplo similar hecho en SQL:
        #
        # INSERT INTO testTable (idMaquina, fechaHoraEncendido, fueApagadaPorOperarioOPorFallaParticular)
        # 	VALUES(
        # 		1, 
        # 		CAST('2021-06-08T14:00:00' AS SMALLDATETIME),
        # 		0
        # 	)

    cursor.execute(
        f"INSERT INTO {table_name}( "
            f"{ID_MAQ}, "
            f"{INIT_DT}, "
            f"{LAST_DT}, "
            f"{TRND_OFF}) "
        "VALUES(?, CAST(? AS SMALLDATETIME), CAST(? AS SMALLDATETIME), 0)",
            ( data[ID_MAQ], 
                data[INIT_DT], 
                data[LAST_DT] )
    )
    conn.commit()

def updateSessionContinues(conn, data: dict):
    """Hago un INSERT de LAST_DT en data, porque la sesión sólo continúa:
    UPDATE table_name
        SET LAST_DT = CAST( data[LAST_DT] AS SMALLDATETIME )
        WHERE ID_MAQ = data[ID_MAQ]
            AND TRND_OFF = 0
            AND INIT_DT = (SELECT TOP 1 INIT_DT
                            FROM table_name
                            WHERE ID_MAQ = data[ID_MAQ]
                            ORDER BY INIT_DT DESC)
    """
    print("updateSessionContinues")
    cursor = conn.cursor()
  
    # Ejemplo hecho en SQL:
        # 
        # UPDATE testTable
        # 	SET fechaHoraUltimoRegistroEncendido = CAST('2021-06-08T14:10:00' AS SMALLDATETIME)
        # 	WHERE idMaquina = 1
        # 	  AND fueApagadaPorOperarioOPorFallaParticular = 0
        # 	  AND fechaHoraEncendido = (SELECT TOP 1 fechaHoraEncendido
        # 						  FROM testTable
        # 						  WHERE idMaquina = 1
        # 						  ORDER BY fechaHoraEncendido DESC)

    cursor.execute(
        f"UPDATE {table_name} "
            f"SET {LAST_DT} = CAST(? AS SMALLDATETIME) "
            f"WHERE {ID_MAQ} = ? "
              f"AND {TRND_OFF} = 0 "
              f"AND {INIT_DT} = (SELECT TOP 1 {INIT_DT} "
                    f"FROM {table_name} "
                    f"WHERE {ID_MAQ} = ? "
                    f"ORDER BY {INIT_DT} DESC)",
        ( data[LAST_DT], 
            data[ID_MAQ],
            data[ID_MAQ] )
    )
    conn.commit()

def updateSessionFinishes(conn, data: dict):
    """Hago un INSERT de LAST_DT en data, (TRND_OFF = 1) porque la sesión terminó:
    UPDATE table_name
        SET LAST_DT = CAST( data[LAST_DT] AS SMALLDATETIME ),
            TRND_OFF = 1
        WHERE ID_MAQ = data[ID_MAQ]
            AND TRND_OFF = 0
            AND INIT_DT = (SELECT TOP 1 INIT_DT
                            FROM table_name
                            WHERE ID_MAQ = data[ID_MAQ]
                            ORDER BY INIT_DT DESC)
    """
    print("updateSessionFinishes")
    cursor = conn.cursor()
  
    # Ejemplo hecho en SQL:
        # 
        # UPDATE testTable
        # 	SET fechaHoraUltimoRegistroEncendido = CAST('2021-06-08T14:10:00' AS SMALLDATETIME),
        #       fueApagadaPorOperarioOPorFallaParticular = 1
        # 	WHERE idMaquina = 1
        # 	  AND fueApagadaPorOperarioOPorFallaParticular = 0
        # 	  AND fechaHoraEncendido = (SELECT TOP 1 fechaHoraEncendido
        # 						  FROM testTable
        # 						  WHERE idMaquina = 1
        # 						  ORDER BY fechaHoraEncendido DESC)

    cursor.execute(
        f"UPDATE {table_name} "
            f"SET {LAST_DT} = CAST(? AS SMALLDATETIME), "
                f"{TRND_OFF} = 1"
            f"WHERE {ID_MAQ} = ? "
              f"AND {TRND_OFF} = 0 "
              f"AND {INIT_DT} = (SELECT TOP 1 {INIT_DT} "
                    f"FROM {table_name} "
                    f"WHERE {ID_MAQ} = ? "
                    f"ORDER BY {INIT_DT} DESC)",
        ( data[LAST_DT], 
            data[ID_MAQ],
            data[ID_MAQ] )
    )
    conn.commit()


ID_MAQ = "idMaquina"
INIT_DT = "fechaHoraEncendido"
LAST_DT = "fechaHoraUltimoRegistroEncendido"
TRND_OFF = "fueApagadaPorOperarioOPorFallaParticular"

device_name = "LUCIANO-PC"
db_name = "master"
table_name = "testTable"

if __name__ == "__main__":

    with connectToDatabase() as conn:

        new_data = {
            ID_MAQ: 1,
            INIT_DT: datetime.now() - timedelta(minutes = 45),
            LAST_DT: datetime.now(),
            TRND_OFF: 0
        }

        insertSessionStarts(conn, new_data)
        
        new_data2 = {
            ID_MAQ: 1,
            INIT_DT: datetime.now() - timedelta(minutes = 45),
            LAST_DT: datetime.now() + timedelta(hours = 2),
            TRND_OFF: 0
        }

        updateSessionContinues(conn, new_data2)
        selectLast(conn, 30)

        new_data3 = {
            ID_MAQ: 1,
            INIT_DT: datetime.now() - timedelta(minutes = 45),
            LAST_DT: datetime.now() + timedelta(hours = 2, minutes= 15),
            TRND_OFF: 0
        }

        updateSessionFinishes(conn, new_data3)

        selectLast(conn, 30)
        print()



        # update(conn, table_name)
        # delete(conn, table_name)

    print("Todo OK")
