@REM Ejecutado así, el registrador muestra las tramas recibidas, y responde siempre UNEXPECTED ANSWER.


@echo off

@REM Busco el path de python.exe
FOR /f %%p in ('where python') do SET python_path=%%p
start "%python_path%" "%~dp0/../Registrador.py" "-respuesta_forzada" "unex_ans"

@REM start D:/Programas/Python/python.exe "%~dp0/../Registrador.py" "-respuesta_forzada" "unex_ans"