Dim WinScriptHost
' Creo una consola
Set WinScriptHost = CreateObject("WScript.Shell")

' Ejecuto el .bat - 0 -> Sin Ventana
WinScriptHost.Run Chr(34) & "D:\HilosLibertad\Registrador\Archivos Batch\__autorun Registrador.bat" & Chr(34), 0

' Ejecuto el .bat - 1 -> Con Ventana
' WinScriptHost.Run Chr(34) & "D:\HilosLibertad\Registrador\Archivos Batch\__autorun Registrador con Pantalla.bat" & Chr(34), 1

Set WinScriptHost = Nothing