Dim WinScriptHost
' Creo una consola
Set WinScriptHost = CreateObject("WScript.Shell")

' Ejecuto el .bat - 0 -> Sin Ventana
WinScriptHost.Run Chr(34) & "C:\Saldivia HilosLibertad\Registrador - Hilos Libertad\Archivos Batch\__autorun Old Backups Deleter.bat" & Chr(34), 0

' Ejecuto el .bat - 1 -> Con Ventana
' WinScriptHost.Run Chr(34) & "C:\Saldivia HilosLibertad\Registrador - Hilos Libertad\Archivos Batch\__autorun Old Backups Deleter.bat" & Chr(34), 1

Set WinScriptHost = Nothing