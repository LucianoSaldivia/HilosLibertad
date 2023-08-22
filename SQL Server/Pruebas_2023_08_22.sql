

USE DB_HILOS_LIBERTAD
GO


SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida DESC

-- INSERT INTO HL.registros (idMaquina,	fechaHoraEncendida,	fechaHoraUltimoRegistroEncendida,	fueApagadaPorOperarioOPorFallaParticular)
BEGIN TRAN
INSERT INTO HL.registros
	VALUES (15,	'2023-08-22 12:06:45.38',	'2023-08-22 12:06:45.38',	0)
SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida DESC
COMMIT


EXEC HL.sp_insertarSesion 16, '2023-08-22 12:06:45.38'
SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida DESC

EXEC HL.sp_insertarSesion 1, '2023-08-22 11:51:03'
SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida DESC

SET DATEFORMAT YMD
SELECT GETDATE()
/*
2023-08-22 12:06:45.387
*/


SELECT GETDATE()
/*
2023-08-22 12:06:45.387
*/
