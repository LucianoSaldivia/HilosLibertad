
--Último registro de que una máquina andando
SELECT * FROM HL.registros
ORDER BY fechaHoraUltimoRegistroEncendida DESC

--Últ
SELECT * FROM HL.registros
ORDER BY fechaHoraEncendida DESC


SELECT * FROM HL.registros
WHERE DATEDIFF(minute,fechaHoraEncendida,GETDATE()) < 5
ORDER BY fechaHoraEncendida DESC





-- Limpieza de la base
SELECT * FROM HL.sectores

SELECT * FROM HL.maquinas

SELECT * FROM HL.registros
	

--Carga de máquinas: el idMaquina = id de la bornera
--TELARES
INSERT INTO HL.maquinas VALUES (31,	1,	1001,	'COSMOS 8 bocas',		'')
INSERT INTO HL.maquinas VALUES (30,	1,	1002,	'KYAN YHE 6/40',		'')
INSERT INTO HL.maquinas VALUES (29,	1,	1003,	'DKY 8/30',		'')
INSERT INTO HL.maquinas VALUES (28,	1,	1004,	'YITAI 8/55',		'')
INSERT INTO HL.maquinas VALUES (27,	1,	1005,	'KYAN YHE viejo 8/20',		'')
INSERT INTO HL.maquinas VALUES (26,	1,	1006,	'TELAR HENG HUI 10/30',		'')
INSERT INTO HL.maquinas VALUES (25,	1,	1007,	'TELAR HENG HUI 10/30',		'')

--URDIDORA
INSERT INTO HL.maquinas VALUES (24,	4,	4008,	'URDIDORA',		'')

--CORDONERA
INSERT INTO HL.maquinas VALUES (15,	2,	2001,	'GREKY1',		'')
INSERT INTO HL.maquinas VALUES (14,	2,	2002,	'GREKY2',		'')
INSERT INTO HL.maquinas VALUES (21,	2,	2003,	'GREKY3',		'')
INSERT INTO HL.maquinas VALUES (20,	2,	2004,	'GREKY4',		'')
INSERT INTO HL.maquinas VALUES (19,	2,	2005,	'KYAN YHE 5',		'')
INSERT INTO HL.maquinas VALUES (18,	2,	2006,	'KYAN YHE 6',		'')
INSERT INTO HL.maquinas VALUES (17,	2,	2007,	'KYAN YHE 7',		'')
INSERT INTO HL.maquinas VALUES (16,	2,	2008,	'RIUS 8 y 9',		'')
INSERT INTO HL.maquinas VALUES (11,	2,	2010,	'TUBULAR 10 Bocas VIEJA',		'')
INSERT INTO HL.maquinas VALUES (10,	2,	2011,	'TUBULAR 10 Bocas',		'')
INSERT INTO HL.maquinas VALUES (8,	2,	2012,	'TRENZADORA 32 H',		'')
INSERT INTO HL.maquinas VALUES (6,	2,	2013,	'TRENZADORA 32 H',		'')
INSERT INTO HL.maquinas VALUES (7,	2,	2014,	'TRENZADORA 24 H',		'')

--TERMINACIÓN
INSERT INTO HL.maquinas VALUES (12,	3,	3001,	'PUNTERA 1',		'')
INSERT INTO HL.maquinas VALUES (13,	3,	3002,	'PUNTERA 2',		'')





BEGIN TRAN
SELECT * FROM HL.maquinas ORDER BY idMaquina ASC
COMMIT		SELECT * FROM HL.maquinas ORDER BY idMaquina ASC
ROLLBACK	SELECT * FROM HL.maquinas ORDER BY idMaquina ASC 



ROLLBACK COMMIT
SELECT * FROM HL.maquinas

--DELETE FROM HL.maquinas



--
--NO debe repetirse el numeroMaquinaUsuario de la tabla maquinas porque rompe la app escritorio.
--

--CREATE VIEW
SELECT r.idMaquina, m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, DATEDIFF(minute, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) AS 'DIFF_MINS', r.fueApagadaPorOperarioOPorFallaParticular
FROM HL.registros r JOIN HL.maquinas m
	ON r.idMaquina = m.idMaquina
ORDER BY m.nombreMaquinaUSUARIO

SELECT * FROM HL.registros
