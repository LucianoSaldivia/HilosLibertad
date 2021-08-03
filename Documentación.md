--------	Embebido    --------

+ Conexión a módulo RS485 (Half-Duplex)
	https://www.luisllamas.es/arduino-rs485-max485/

+ Driver para conversor USB <-> RS485
Tutorial:
	https://www.youtube.com/watch?v=3Hqu0T8qEy8
Link para el archivo:
	http://descargas.todomicro.com.ar/productos/USB-RS485/drivers.zip

+ UART por interrupciones:
	https://www.youtube.com/watch?v=R11GONhe5Ks

+ Pines Blue Pill

 * Entradas de Lectura (0)
PB5  -> W0
PB6  -> X0
PB7  -> Y0
PB8  -> Z0

 * Entradas de Lectura (1)
PA12 -> W1
PA15 -> X1
PB3  -> Y1
PB4  -> Z1

 * Entradas de Lectura (2)
PA8  -> W2
PA9  -> X2
PA10 -> Y2
PA11 -> Z2

 * Entradas de Lectura (3)
PB15 -> W3
PB14 -> X3
PB13 -> Y3
PB12 -> Z3

 * Control de Lecturas (MUX Control)
PB0  -> ~A ( not(A) )
PA7  -> ~B ( not(B) )

 * Buzzer / Beeper
PB9  -> Buzzer (0 -> Off, 1 -> On)

 * Control de Envío de Datos (Datos o Datos + Información de Debug)
PA0  -> Data Select (0 -> OnlyData, 1 -> Data+Info)

 * UART
PB11 -> UART3 - Rx
PB10 -> UART3 - Tx
PB1  -> Output - Enable Tx UART3 (0 -> RxOnly, 1 -> TxOnly)




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

Sample 	-> Lista [datetime.now(), State1, State2, ..., StateN]

Faltan Terminar:
    + Registrador.py
    + SQL_Writer.py

Paquetes instalados:
    "pip install pyserial" (import serial)
    "pip install crc8" (import crc8)

--------	SQL Server    --------
.gitignore agregado

Terminados:

Faltan Terminar:
    + Query de SQL Server
