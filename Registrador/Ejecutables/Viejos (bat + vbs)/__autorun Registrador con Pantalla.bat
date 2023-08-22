@REM Ejecutado así, el registrador escribe en la base, muestra las tramas recibidas y los últimos cambios de la base.


@echo off

@REM Busco el path de python.exe
FOR /f %%p in ('where python') do SET python_path=%%p
"%python_path%" "%~dp0\\..\\src_py\\Registrador.py" "-registrador" "-windowed"

@REM start D:/Programas/Python/python.exe "%~dp0/../src_py/Registrador.py" "-registrador" "-windowed"
pause