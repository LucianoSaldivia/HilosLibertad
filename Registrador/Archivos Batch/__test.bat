@echo off

FOR /f %%p in ('where python') do SET python_path=%%p
echo Python esta en %python_path%

FOR /f %%p in ('where pythonw') do SET pythonw_path=%%p
echo PythonW esta en %pythonw_path%

@REM "%~dp0" resuelve el path completo hasta el directorio donde reside este archivo .bat
echo %~dp0

pause




@REM Auxiliares:

@REM Correr un script de python con cmd
@REM <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python
@REM start <path/to/file/python.exe> "<path/to/file/python_file_to_execute.py>"

@REM Correr un script de python con python, sin dejar abierta la consola ("pythonw.exe" en lugar de "python.exe", sólo para windows)
@REM start <path/to/file/pythonw.exe> "<path/to/file/python_file_to_execute.py>"