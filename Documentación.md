--------	Embebido    --------

+ Driver para conversor USB <-> RS485
Tutorial:
https://www.youtube.com/watch?v=3Hqu0T8qEy8
Link para el archivo:
http://descargas.todomicro.com.ar/productos/USB-RS485/drivers.zip


--------	Registrador    --------
.gitignore agregado

Terminados:
    + EstadosEventosSesiones
* Definiciones para EstadosEventosSesiones.py

Estado de la máquina                    -> States (<STOPPED> o <WORKING>)
Lista de estados                        -> Sample
Eventos de la sesión de cada máquina    -> Events (<NO_SESSION>, <SESSION_STARTED>, <SESSION_CONTINUES> o <SESSION_FINISHED>. Los últimos 3 indican Sesiones Activas)
Lista de eventos de cada sesión         -> SampleEvents
Lista de Sesiones Activas               -> ActiveSessionEvents
Estado de Sesión                        -> Reports
Lista de Reportes                       -> Reports List

Faltan Terminar:
    + Registrador.py
    + SQL_Writer.py


--------	SQL Server    --------
.gitignore agregado

Terminados:

Faltan Terminar:
    + Query de SQL Server
