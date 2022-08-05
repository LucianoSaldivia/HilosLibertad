@REM Ejecutado así, el registrador escribe en la base, muestra las tramas recibidas y los últimos cambios de la base.


@echo off

@REM Buscar el path de python.exe
"C:\Users\Seven 22-01-15\AppData\Local\Programs\Python\Python38\python.exe" "%~dp0\\..\\src_py\\Registrador.py" "-registrador" "-windowed"

pause