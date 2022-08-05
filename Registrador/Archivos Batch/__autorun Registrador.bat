@REM Ejecutado así, el registrador escribe en la base según las tramas que recibe, sin imprimir nada. Todo se ejecuta en el background.


@echo off

@REM Buscar el path de python.exe
"C:\Users\Seven 22-01-15\AppData\Local\Programs\Python\Python38\python.exe" "%~dp0\\..\\src_py\\Registrador.py" "-registrador" "-windowless"