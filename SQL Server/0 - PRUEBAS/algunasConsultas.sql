--Líneas de prueba de STORED PROCEDURES

SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2018-12-09 16:00:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2018-12-09 16:05:00'
SELECT * FROM HL.registros
EXEC HL.sp_terminarSesion 1, '2018-12-09 16:45:00'
SELECT * FROM HL.registros

SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2019-04-04 04:00:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2019-04-04 04:01:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2019-04-04 04:02:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2019-04-04 04:10:00'
SELECT * FROM HL.registros
EXEC HL.sp_terminarSesion 1, '2019-04-05 04:15:00'
SELECT * FROM HL.registros



-- LAS FECHAS DE LOS STORED PROCEDURES DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'
--Prueba SPs de UPDATEs:
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-06-08 00:58:00'
EXEC HL.sp_insertarSesion 4, '2021-06-08 00:58:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2021-06-08 01:09:00'	--11 minutos de diferencia
EXEC HL.sp_actualizarSesion 4, '2021-06-08 01:09:00'	--11 minutos de diferencia
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-06-08 01:09:00'
EXEC HL.sp_insertarSesion 4, '2021-06-08 01:09:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2021-06-08 01:10:00'	--1 minutos de diferencia
EXEC HL.sp_actualizarSesion 4, '2021-06-08 01:10:00'	--1 minutos de diferencia
SELECT * FROM HL.registros






SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-06-08 00:58:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2021-06-08 01:09:00'	--11 minutos de diferencia
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-06-08 01:09:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2021-06-08 01:10:00'	--1 minutos de diferencia
SELECT * FROM HL.registros




/*
DELETE FROM HL.registros
DBCC CHECKIDENT ('HL.registros', RESEED, 0)
*/







select *
from HL.maquinas m
where m.idMaquina IN (0, 1, 00)

