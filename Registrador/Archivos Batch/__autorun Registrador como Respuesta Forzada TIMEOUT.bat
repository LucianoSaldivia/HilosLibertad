@REM Ejecutado así, el registrador muestra las tramas recibidas, y siempre fuerza un TIMEOUT (no responde)

@REM "%~dp0" resuelve el path completo hasta el directorio donde reside este archivo .bat


@echo off

@REM Con consola (para ver todo mientras funciona)
@REM Busco el path de python.exe
FOR /f %%p in ('where python') do SET python_path=%%p
start "%python_path%" "%~dp0/../Registrador.py" "-respuesta_forzada" "timeout"

@REM start D:/Programas/Python/pythonw.exe "%~dp0/../Registrador.py" "-respuesta_forzada" "timeout"


@REM Sin consola
@REM Busco el path de pythonw.exe
@REM FOR /f %%p in ('where pythonw') do SET pythonw_path=%%p
@REM start "%pythonw_path%" "%~dp0/../Registrador.py" "-respuesta_forzada" "timeout"

@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-respuesta_forzada" "timeout"

pause




@REM Auxiliares:

@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"