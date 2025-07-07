--Pruebas usuario

--	1 intervalo:
--	VIE 04/07/2025 14:30-15:00
	EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-04-07 14:30', '2025-04-07 15:00', '2001', 'GREKY1', 'Cordoneras'

--	1 intervalo:
--	SAB 05/07/2025 14:30-15:00
	EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-05-07 14:30', '2025-05-07 15:00', '2001', 'GREKY1', 'Cordoneras'
	
--	2 intervalos:
--	VIE 14:30-15:00
--	SÁB 14:30-15:00 
	EXECUTE HL.sp_mostrarTiemposPorMaquina_Nintervalos '2025-07-04', '2025-07-05', '14:30', '15:00', '2001', 'GREKY1', 'Cordoneras'



--Otras pruebas
--	Cordoneras
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2001', 'GREKY1', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2002', 'GREKY2', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2003', 'GREKY3', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2004', 'GREKY4', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2005', 'KYAN YHE 5', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2006', 'KYAN YHE 6', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2007', 'KYAN YHE 7', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2008', 'RIUS 8 y 9', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2010', 'TUBULAR 10 Bocas VIEJA', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2011', 'TUBULAR 10 Bocas', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2012', 'TRENZADORA 32 H (12)', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2013', 'TRENZADORA 32 H (13)', 'Cordoneras'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '2014', 'TRENZADORA 24 H', 'Cordoneras'

--	Telares
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1001', 'COSMOS 8 bocas', 'Telares'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1002', 'KYAN YHE 6/40', 'Telares'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1003', 'DKY 8/30', 'Telares'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1004', 'YITAI 8/55', 'Telares'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1005', 'KYAN YHE viejo 8/20', 'Telares'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1006', 'TELAR HENG HUI 10/30 (6)', 'Telares'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '1007', 'TELAR HENG HUI 10/30 (7)', 'Telares'

--	Terminación
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '3001', 'PUNTERA 1', 'Terminación'
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '3002', 'PUNTERA 2', 'Terminación'

--	Urdidora
EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2025-07-07 06:00', '2025-07-07 10:00', '4008', 'URDIDORA', 'Urdidora'


/*
Preguntar a Ariel:
	- si la trenzadora 24 H (número 14) es la que tenía problemas con el cable											-->	SÍ
	- si los Sábados trabajan, en qué horario									--> marca que se trabajó de 0 a 6.		-->	SÍ, OK
	- si Domingos trabajan, en qué horario										--> no marca nada						-->	SÍ, OK
	- ¿estuvo andando hoy el TELAR HENG HUI 10/30 (7)?							--> marca 37 minutos nomás				--> SÍ, OK
*/
