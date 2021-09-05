# config_SQL_Database.py

device_name = "(local)"
db_name = "DB_EJEMPLO"
table_name = "HL.registros"


VIEW_NAME = "HL.v_registrador"
PROC_SESSION_STARTED    = "HL.sp_insertarSesion"
PROC_SESSION_CONTINUES  = "HL.sp_actualizarSesion"
PROC_SESSION_FINISHED   = "HL.sp_terminarSesion"

LAST_N_TO_SELECT = 50