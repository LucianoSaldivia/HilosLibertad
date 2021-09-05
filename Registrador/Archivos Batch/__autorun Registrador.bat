@REM Ejecutado así, el registrador escribe en la base según las tramas que recibe, sin imprimir nada. Todo se ejecuta en el background

@REM "%~dp0" resuelve el path completo hasta el directorio donde reside este archivo .bat

@REM Sin consola
start D:/Programas/Python/pythonw.exe "%~dp0/../Registrador.py" "-registrador" "-print_nothing"

@REM Con consola (para monitorear)
@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-registrador" "-print_nothing"









@REM Auxiliares:

@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"