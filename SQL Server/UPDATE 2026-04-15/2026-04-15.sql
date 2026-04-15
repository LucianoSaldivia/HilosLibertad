USE DB_HILOS_LIBERTAD

SELECT * FROM HL.maquinas ORDER BY idSector

INSERT INTO HL.maquinas VALUES (0,  3, 3101, 'Encarreteladora 1', 'Encarreteladora 1', 1)
INSERT INTO HL.maquinas VALUES (1,  3, 3102, 'Encarreteladora 2', 'Encarreteladora 2', 1)
INSERT INTO HL.maquinas VALUES (2,  2, 2105, 'Trenzadora 5', 'Trenzadora 5', 1)
INSERT INTO HL.maquinas VALUES (10, 2, 2106, 'Trenzadora 6', 'Trenzadora 6', 1)
INSERT INTO HL.maquinas VALUES (3,  2, 2005, 'Cordonera 5', 'Cordonera 5', 1)



SELECT * FROM HL.maquinas ORDER BY idSector


COMMIT

SELECT TOP 20 * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida DESC

SELECT TOP 20 * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida DESC
SELECT TOP 20 * FROM HL.registros ORDER BY fechaHoraEncendida DESC


BEGIN TRAN
EXEC HL.sp_insertarSesion 15, '2026-04-15T20:00:00'
SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida, idMaquina DESC
ROLLBACK



SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida  DESC

EXEC HL.sp_insertarSesion 3, '2026-04-15T12:06:43'






BEGIN TRAN
EXEC HL.sp_insertarSesion 3, '2026-04-15T12:06:43'
SELECT * FROM HL.registros ORDER BY fechaHoraUltimoRegistroEncendida, idMaquina DESC

ROLLBACK

SELECT * FROM HL.maquinas



SELECT * FROM HL.registros



