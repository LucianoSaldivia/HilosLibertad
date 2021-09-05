@REM Ejecutado así, el registrador escribe en la base según las tramas que recibe, sin imprimir nada. Todo se ejecuta en el background

@REM "%~dp0" resuelve el path completo hasta el directorio donde reside este archivo .bat


@echo off

@REM Con consola (para ver todo mientras funciona)
@REM Busco el path de python.exe
@REM FOR /f %%p in ('where python') do SET python_path=%%p
@REM start "%python_path%" "%~dp0/../Registrador.py" "-registrador" "-print_nothing"

@REM start D:/Programas/Python/pythonw.exe "%~dp0/../Registrador.py" "-registrador" "-print_nothing"


@REM Sin consola
@REM Busco el path de pythonw.exe
FOR /f %%p in ('where pythonw') do SET pythonw_path=%%p
start "%pythonw_path%" "%~dp0/../Registrador.py" "-registrador" "-print_nothing"

@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-registrador" "-print_nothing"

pause




@REM Auxiliares:

@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"