@echo off

@REM FOR /f %%p in ('where python') do SET python_path=%%p
@REM echo Python esta en %python_path%
@REM starts "%python_path%" "%~dp0/../Registrador.py" "-respuesta_forzada" "ack"
@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-respuesta_forzada" "ack"

@REM FOR /f %%p in ('where pythonw') do SET pythonw_path=%%p
@REM echo PythonW esta en %pythonw_path%
@REM start "%python_path%" "%~dp0/../Registrador.py" "-respuesta_forzada" "ack"
@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-respuesta_forzada" "ack"


start "C:\Users\PabloDell\AppData\Local\Programs\Python\Python39\pythonw.exe" "%~dp0\..\Registrador.pyw"

@REM pause




@REM Auxiliares:

@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"