@REM Ejecutado así, el registrador escribe en la base según las tramas que recibe, sin imprimir nada. Todo se ejecuta en el background.


@echo off

@REM Busco el path de pythonw.exe
FOR /f %%p in ('where pythonw') do SET pythonw_path=%%p
start "%pythonw_path%" "%~dp0/../Registrador.py" "-registrador" "-windowless"

@REM start D:/Programas/Python/pythonw.exe "%~dp0/../Registrador.py" "-registrador" "-windowless"