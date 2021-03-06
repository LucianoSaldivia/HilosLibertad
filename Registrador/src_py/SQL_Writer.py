# SQL_Writer.py

import pyodbc
import config_SQL_Database
from datetime import datetime, timedelta
import Registrador
import error_logger
import sys


# Tutoriales y fuentes:
    #
    # Tutorial: Instalar SQL Server
    # https://www.youtube.com/watch?v=YOaC_TyOrdk&ab_channel=C%C3%B3digosdeProgramaci%C3%B3n-MarcoRobles
    #
    # Tutorial: Enviar Queries de python a SQL Server
    # https://www.youtube.com/watch?v=aF552bMEcO4



#   Select Functions
def selectLast(conn: any, n: int):
    """Hago un SELECT de los últimos n registros, según la vista VIEW_NAME:
    SELECT TOP n * FROM HL.v_registrador ORDER BY LAST_DT DEST
    """
    print(f"Select last {n} from table")
    cursor = conn.cursor()
    cursor.execute(f"SELECT TOP {n} * FROM {config_SQL_Database.VIEW_NAME} ORDER BY LAST_DT DESC, idMaq ASC")
    
    _showSelectedRows(cursor)
def selectAll(conn: any):
    """Hago un SELECT de toda la tabla, según la vista VIEW_NAME:
    SELECT * FROM HL.v_registrador ORDER BY LAST_DT DESC
    """
    print("Select complete table")
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {config_SQL_Database.VIEW_NAME} ORDER BY LAST_DT DESC, idMaq ASC")
    _showSelectedRows(cursor)


#   Procedures Queries Functions
def sessionStarted(conn, id_maq: int, timestamp: datetime):
    """Llamo al procedimiento PROC_SESSION_STARTED como en el siguiente ejemplo:
    EXEC HL.sp_insertarSesion 1, '2018-30-09 16:00:00'
    donde le paso:
        id_maq
		timestamp como 'YYYY-DD-MM HH:MM:SS'
    """

    # print(f"Maq {id_maq}, sessionStarted")
    try: 
        cursor = conn.cursor()

        formatted_timestamp = timestamp.strftime("%Y-%d-%m %H:%M:%S")
        # Ejecuto el procedimiento
        cursor.execute( f"EXEC {config_SQL_Database.PROC_SESSION_STARTED} {id_maq}, '{formatted_timestamp}'" )
        conn.commit()
    except:
        raise Exception("Falló la llamada al Stored Procedure: " + config_SQL_Database.PROC_SESSION_STARTED + ".")
def sessionContinues(conn, id_maq: int, timestamp: datetime):
    """Llamo al procedimiento PROC_SESSION_CONTINUES como en el siguiente ejemplo:
    EXEC HL.sp_actualizarSesion 1, '2018-30-09 16:05:00'
    donde le paso:
        id_maq
		timestamp como 'YYYY-DD-MM HH:MM:SS'
    """
    # print(f"Maq {id_maq}, sessionContinues")
    try: 
        cursor = conn.cursor()

        formatted_timestamp = timestamp.strftime("%Y-%d-%m %H:%M:%S")
        # Ejecuto el procedimiento  
        cursor.execute( f"EXEC {config_SQL_Database.PROC_SESSION_CONTINUES} {id_maq}, '{formatted_timestamp}'" )
        conn.commit()
    except:
        raise Exception("Falló la llamada al Stored Procedure: " + config_SQL_Database.PROC_SESSION_CONTINUES + ".")
def sessionFinished(conn, id_maq: int, timestamp: datetime):
    """Llamo al procedimiento PROC_SESSION_FINISHED como en el siguiente ejemplo:
    EXEC HL.sp_terminarSesion 1, '2018-30-09 16:45:00'
    donde le paso:
        id_maq
		timestamp como 'YYYY-DD-MM HH:MM:SS'
    """
    # print(f"Maq {id_maq}, sessionFinishes")
    try: 
        cursor = conn.cursor()

        formatted_timestamp = timestamp.strftime("%Y-%d-%m %H:%M:%S")
        # Ejecuto el procedimiento
        cursor.execute( f"EXEC {config_SQL_Database.PROC_SESSION_FINISHED} {id_maq}, '{formatted_timestamp}'" )
        conn.commit()
    except:
        raise Exception("Falló la llamada al Stored Procedure: " + config_SQL_Database.PROC_SESSION_FINISHED + ".")
        

#   Clear Table Function
def clearTable(conn, table: str):
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
    server_line = "Server=" + config_SQL_Database.device_name + ";"
    db_line = "Database=" + config_SQL_Database.db_name + ";"
    trusted_conn_line = "Trusted_Connection=yes;"
    connection_str = driver_line + server_line + db_line + trusted_conn_line

    try:
        conn = pyodbc.connect(connection_str)
        return conn 
    except:
        raise Exception("Datos de la base, mal cargados. config_SQL_Database -> device_name o db_name")



#   Private Functions
def _showSelectedRows(c: any):
    print(  "IdReg" + "  " +
            "IdMaq" + "  " +
            "INIT_DT" + "              " +
            "LAST_DT" + "              " + 
            "TRND_OFF" + "  " + 
            "Mins_DIFF"
            )
    for row in c:
        # Mostrar en crudo
        # print(f"row = {row}")
        # Mostrar lindo
        _showRow("", row)
    print()
def _showRow(ini: str, row: any):
    out = ini
    sep = " "
    
    # 6 caracteres para IdReg
    out += "{:<6}".format(str(row[0])) + sep

    # 6 caracteres para IdMaq
    out += "{:<6}".format(str(row[1])) + sep         
    
    # 20 caracteres para INIT_DT
    out += "{:<20}".format(row[2].strftime("%Y-%m-%d %H:%M:%S")) + sep        
    
    # 20 caracteres para LAST_DT (incluso si es NULL)
    if row[3] is None:
        out += "{:<20}".format("NULL") + sep       
    else: 
        out += "{:<20}".format(row[3].strftime("%Y-%m-%d %H:%M:%S")) + sep

    # 9 caracteres para TRND_OFF
    out += "{:<9}".format(str(row[4])) + sep         
    
    # 9 caracteres para MINS_ON (incluso si es NULL)
    if row[5] is None:
        out += "{:<9}".format("NULL") + sep
    else:
        out += "{:<9}".format(str(row[5])) + sep

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



def test1(conn):
    """Prueba simple de inicio, continuación y terminación de sesión
    """
    new_data = [
            1, 
            Registrador.Event.SESSION_STARTED, 
            datetime.now() - timedelta(minutes = 45)
        ]

    sessionStarted(conn, new_data[0], new_data[2])
    selectLast(conn, 30)
    
    new_data = [
        1, 
        Registrador.Event.SESSION_CONTINUES, 
        datetime.now() + timedelta(hours = 2)
    ]

    sessionContinues(conn, new_data[0], new_data[2])
    selectLast(conn, 30)

    new_data = [
        1, 
        Registrador.Event.SESSION_FINISHED, 
        datetime.now() + timedelta(hours = 2, minutes= 15)
    ]

    sessionFinished(conn, new_data[0], new_data[2])

    selectLast(conn, 30)
    print()

    clearTable(conn, config_SQL_Database.table_name)
    print("Table cleared OK")
def test2(conn):
    """Prueba de bug encontrado:
    El update ordena por última HoraFecha, pero si hay dos máquinas que terminan en la misma HoraFecha
    puede actualizar mal.
    Este ejemplo, NO anda mal, porque usa sólo UNA máquina."""
    

    # Muestro la tabla completa
    selectAll(conn)

    # Inicio de sesión
    sessionStarted(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=00, minute=58, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)

    # Último update de la sesión
    sessionContinues(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=1, minute=9, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)

    # Inicio de sesión
    sessionStarted(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=1, minute=9, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)

    # Último update de la sesión
    sessionContinues(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=1, minute=10, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)


    pass
def test3(conn):
    """Prueba de bug encontrado:
    El update ordena por última HoraFecha, pero si hay dos máquinas que terminan en la misma HoraFecha
    puede actualizar mal.
    Este ejemplo, SI anda mal, porque usa MÁS de una máquina."""

    # Muestro la tabla completa
    selectAll(conn)

    # Inicio de sesión
    sessionStarted(
        conn,
        1,
        datetime(year=2021, month=8, day=6, hour=00, minute=58, second=00)
    )
    sessionStarted(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=00, minute=58, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)

    # Último update de la sesión
    sessionContinues(
        conn,
        1,
        datetime(year=2021, month=8, day=6, hour=1, minute=9, second=00)
    )
    sessionContinues(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=1, minute=9, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)

    # Inicio de sesión
    sessionStarted(
        conn,
        1,
        datetime(year=2021, month=8, day=6, hour=1, minute=9, second=00)
    )
    sessionStarted(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=1, minute=9, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)

    # Último update de la sesión
    sessionContinues(
        conn,
        1,
        datetime(year=2021, month=8, day=6, hour=1, minute=10, second=00)
    )
    sessionContinues(
        conn,
        4,
        datetime(year=2021, month=8, day=6, hour=1, minute=10, second=00)
    )

    # Muestro la tabla completa
    selectAll(conn)


    pass
def test4(conn):
    """Creo sesiones (como están en el docs.sheet de drive) para testear
    la función que obtiene minutos activos de una máquina."""
    
    # Primera sesión (8:22 a 10:58)
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=8, day=7, hour=8, minute=22, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=8, day=7, hour=10, minute=58, second=0)
    )

    # Segunda sesión (13:12 a 17:33)
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=8, day=7, hour=13, minute=12, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=8, day=7, hour=17, minute=33, second=0)
    )

    # Tercera sesión (20:38 a 21:43)
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=8, day=7, hour=20, minute=38, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=8, day=7, hour=21, minute=43, second=0)
    )

    # Muestro todo para chequear los registros y los horarios
    selectLast(
        conn=conn, 
        n=5
    )
def test5(conn):
    """Creo sesiones (como están en el NUEVO docs.sheet de drive) para testear
    la función que obtiene minutos activos de las máquinas."""
    
    # M1 - Sesión 1
    sessionStarted(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=25, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=25, hour=23, minute=59, second=0)
    )
    # M1 - Sesión 2
    sessionStarted(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=26, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=26, hour=23, minute=59, second=0)
    )
    # M1 - Sesión 3
    sessionStarted(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=27, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=27, hour=23, minute=59, second=0)
    )
    # M1 - Sesión 4
    sessionStarted(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=28, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=28, hour=23, minute=59, second=0)
    )
    # M1 - Sesión 5
    sessionStarted(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=29, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=1,
        timestamp=datetime(year=2021, month=9, day=29, hour=23, minute=59, second=0)
    )
    

    # M7 - Sesión 1
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=25, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=25, hour=12, minute=0, second=0)
    )
    # M7 - Sesión 2
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=25, hour=18, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=25, hour=23, minute=59, second=0)
    )
    # M7 - Sesión 3
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=26, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=26, hour=12, minute=0, second=0)
    )
    # M7 - Sesión 4
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=26, hour=18, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=26, hour=23, minute=59, second=0)
    )
    # M7 - Sesión 5
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=27, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=27, hour=12, minute=0, second=0)
    )
    # M7 - Sesión 6
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=27, hour=18, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=27, hour=23, minute=59, second=0)
    )
    # M7 - Sesión 7
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=28, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=28, hour=12, minute=0, second=0)
    )
    # M7 - Sesión 8
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=28, hour=18, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=28, hour=23, minute=59, second=0)
    )
    # M7 - Sesión 9
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=29, hour=0, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=29, hour=12, minute=0, second=0)
    )
    # M7 - Sesión 10
    sessionStarted(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=29, hour=18, minute=0, second=0)
    )
    sessionFinished(
        conn=conn,
        id_maq=7,
        timestamp=datetime(year=2021, month=9, day=29, hour=23, minute=59, second=0)
    )


    # Muestro todo para chequear los registros y los horarios
    selectAll(conn)



if __name__ == "__main__":

    with connectToDatabase() as conn:

        # selectAll(conn)

        # selectAll(conn)
        # test5(conn)
        # selectAll(conn)

        selectAll(conn)
        # clearTable(conn, config_SQL_Database.table_name)
        # selectAll(conn)

    print("Todo OK")
    