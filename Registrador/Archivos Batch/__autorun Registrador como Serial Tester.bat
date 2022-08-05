@REM Ejecutado así, el registrador muestra las tramas recibidas, y responde siempre unexpected answer.


@echo off

@REM Buscar el path de python.exe
"C:\Users\Seven 22-01-15\AppData\Local\Programs\Python\Python38\python.exe" "%~dp0\\..\\src_py\\Registrador.py" "-serial_tester"

pause