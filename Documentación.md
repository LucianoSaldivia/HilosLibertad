--------	Embebido    --------
+ STM32_CUBE_IDE Para evitar errores al debuggear/correr un proyecto en la placa:
	1. Abrir opciones de Debug (en la flecha a la derecha del botón "Debug |v|")
	2. Debug Configurations
	3. Pestaña Debugger
	4. Debug probe -> Elegir ST-LINK (OpenOCD)
	5. En la sección "Configuration Script", tocar "Show generator options..."
	6. Reset Mode -> Software System Reset (En la sección Mode Setup, dentro de Generator Options)


+ Driver para conversor USB <-> RS485
Tutorial:
	https://www.youtube.com/watch?v=3Hqu0T8qEy8
Link para el archivo:
	http://descargas.todomicro.com.ar/productos/USB-RS485/drivers.zip


+ Conexión a módulo RS485 (Half-Duplex)
	https://www.luisllamas.es/arduino-rs485-max485/

+ UART por interrupciones:
	https://www.youtube.com/watch?v=R11GONhe5Ks

 * Control de Envío de Datos (Datos o Datos + Información de Debug)
	PA0  -> Data Select (0 -> OnlyData, 1 -> Data+Info)

 * UART
	PB11 -> UART3 - Rx
	PB10 -> UART3 - Tx
	PB1  -> Output - Enable Tx UART3 (0 -> RxOnly, 1 -> TxOnly)


+ Trama enviada ONLY DATA MODE
10 bytes en total:
	- 8 bytes que contienen los estados de las máquinas (en este orden: M63 a M0)
	- 1 byte de CRC, calculado a partir de los anteriores 8 bytes
	- 1 byte de fin de trama
+ Trama enviada INFO DATA MODE
19 bytes en total:
	- 8 bytes que contienen los estados de las máquinas (en este orden: M63 a M0)
	- 1 byte de CRC, calculado a partir de los anteriores 8 bytes
	- 3 bytes de timeouts (TXY), donde T es el caracter 'T', X es la cuenta de datos perdidos por timeouts e Y son los timeouts de ESTA trama
	- 3 bytes de NAKs (NXY), donde N es el caracter 'N', X es la cuenta de datos perdidos por NAKs e Y son los NAKs de ESTA trama
	- 3 bytes de unex_ans (UXY), donde U es el caracter 'U', X es la cuenta de datos perdidos por unex_ans e Y son los unex_ans de ESTA trama
	- 1 byte de fin de trama
	
	* Cuando un contador Y llega a 5, se reinicia y se cuenta un dato perdido por ésta causa.
	* Cuando un contador X llega a 5, queda en 5 como techo, por más que se sigan perdiendo datos.
	* Cuando se recibe un ACK, todos los contadores es reinician.


	+ HilosLibertad_V0: Cada TIME_BETWEEN_READS_MS milisegundos hace una lectura. Ésta se compone de, escribir AB, esperar TIME_BETWEEN_WRITE_AND_READ milisegundos, leer 16 entradas, escribir AB, y así, hasta leer las 64 entradas. Luego se genera la trama y se envía por UART.
	+ HilosLibertad_V1: Hace una lectura cada milisegundo debounceando constantemente todas las entradas. Lectura compuesta por escritura de AB, espera de 1 microsegundo, lectura de 16 entradas, y así hasta obtener las 64 entradas y luego se calcula el debounce. Cada TIME_BETWEEN_READS_MS milisegundos, se toma una lectura completa debounceada, se genera la trama y se envía por UART.
	pinConnections.h ahora detecta la definición de BOARD0, BOARD1, BOARD2 y BOARD3, generando las definiciones de ALL_4_BOARDS y AT_LEAST_ONE_BOARD. Luego el nuevo debouncer, a partir de estas definiciones, lee las entradas de la placa sólo si está definida, de lo contrario, pone un 0 en la placa correspondiente.
	ERROR CORREGIDO en este commit - Lo que se hace ahora: Sólo se dispara una (nueva) alarma, si la alarma estaba apagada, o si era de otro tipo. Si ahora hay condición de alarma NAK, suena esa, y si luego hay una de TIMEOUT, suena la nueva, y así, sin necesidad de que se apague en el medio, sólo cambia de una a la otra.	       - Lo que se hacía antes: Si se dispara una alarma cuando se cumple la condición de disparo, a veces suena raro, porque se re-dispara cada vez, y a veces se dispara justo en el medio de una secuencia. Si se dispara sólo cuando está andando (para evitar el cambio en la secuencia y el re-disparo), entonces NUNCA cambia de una alarma a otra, sólo hay una nueva alarma cuando está apagada, y para cambiar de sonido, debe apagarse nuevamente.
	


--------	Registrador    --------
Paquetes instalados:
    "pip install pyserial" (import serial)
    "pip install crc8" (import crc8)
    "pip install pyodbc" (import pyodbc)

Terminados:
    + EstadosEventosSesiones
* Definiciones para EstadosEventosSesiones.py

Estado de la máquina                    -> States (<STOPPED> o <WORKING>)
Sample o lista de estados               -> Lista [datetime.now(), State1, State2, ..., StateN]
Eventos de la sesión de cada máquina    -> Events (NO_SESSION, SESSION_STARTED, SESSION_CONTINUES y SESSION_FINISHED)
Sesión de la máquina			-> Desde SESSION_STARTED hasta SESSION_FINISHED
Reporte					-> Lista de 3 [id_maquina, ultimo_evento, timestamp_del_evento]
Reportes                       		-> Lista de "Reporte"s (lista de listas)



	+ Si detecta desconexión por timeout del serial_port, guarda los reportes que tenga en la base de datos, resetea samples y reportes, y espera próxima trama sin timeout. Así, la próxima trama será como una primera trama, tomando cada máquina encendida como una SESSION_STARTED.
	+ Si hay un ACK, duerme por un tiempo (menor al tiempo entre sampleados del Embebido, pero mayor al tiempo máximo de peor caso entre la primer y última trama), y limpia el buffer de recepción. De esta forma, si al enviar "ACK" el Embebido recibe "unex_ans" y reenvía el paquete, el Registrador no lo toma como un paquete nuevo, y simplemente lo limpia. NO SE TOMA EN CUENTA EL POSIBLE CASO: aunque muy poco probable, de que el Registrador siga respondiendo "ACK", y el Embebido siga recibiendo "unex_ans", por lo que el Embebido llegaría a un estado de alarma, pero el Registrador, seguiría registrando normalmente.

--------	SQL Server    --------
.gitignore agregado
