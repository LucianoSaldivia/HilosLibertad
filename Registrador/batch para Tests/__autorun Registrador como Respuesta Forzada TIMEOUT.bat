@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"





@REM "%~dp0" resuelve el path completo hasta el directorio donde reside este archivo .bat

@REM Sin consola
@REM start D:/Programas/Python/pythonw.exe "%~dp0/Registrador.py" "-respuesta_forzada" "timeout"

@REM Con consola (para monitorear)
start D:/Programas/Python/python.exe "%~dp0/Registrador.py" "-respuesta_forzada" "timeout"