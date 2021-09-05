@echo off

FOR /f %%p in ('where python') do SET python_path=%%p
echo Python esta en %python_path%
start "%python_path%" "%~dp0/../Registrador.py" "-respuesta_forzada" "ack"
@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-respuesta_forzada" "ack"

pause




@REM Auxiliares:

@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"