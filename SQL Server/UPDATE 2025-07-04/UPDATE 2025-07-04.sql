
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
INSERT INTO HL.maquinas VALUES (31,	1,	1,	'COSMOS 8 bocas',		'')
INSERT INTO HL.maquinas VALUES (30,	1,	2,	'KYAN YHE 6/40',		'')
INSERT INTO HL.maquinas VALUES (29,	1,	3,	'DKY 8/30',		'')
INSERT INTO HL.maquinas VALUES (28,	1,	4,	'YITAI 8/55',		'')
INSERT INTO HL.maquinas VALUES (27,	1,	5,	'KYAN YHE viejo 8/20',		'')
INSERT INTO HL.maquinas VALUES (26,	1,	6,	'TELAR HENG HUI 10/30',		'')
INSERT INTO HL.maquinas VALUES (25,	1,	7,	'TELAR HENG HUI 10/30',		'')

--URDIDORA
INSERT INTO HL.maquinas VALUES (24,	4,	8,	'URDIDORA',		'')

--CORDONERA
INSERT INTO HL.maquinas VALUES (15,	2,	1,	'GREKY1',		'')
INSERT INTO HL.maquinas VALUES (14,	2,	2,	'GREKY2',		'')
INSERT INTO HL.maquinas VALUES (21,	2,	3,	'GREKY3',		'')
INSERT INTO HL.maquinas VALUES (20,	2,	4,	'GREKY4',		'')
INSERT INTO HL.maquinas VALUES (19,	2,	5,	'KYAN YHE 5',		'')
INSERT INTO HL.maquinas VALUES (18,	2,	6,	'KYAN YHE 6',		'')
INSERT INTO HL.maquinas VALUES (17,	2,	7,	'KYAN YHE 7',		'')
INSERT INTO HL.maquinas VALUES (16,	2,	8,	'RIUS 8 y 9',		'')
INSERT INTO HL.maquinas VALUES (11,	2,	10,	'TUBULAR 10 Bocas VIEJA',		'')
INSERT INTO HL.maquinas VALUES (10,	2,	11,	'TUBULAR 10 Bocas',		'')
INSERT INTO HL.maquinas VALUES (8,	2,	12,	'TRENZADORA 32 H',		'')
INSERT INTO HL.maquinas VALUES (6,	2,	13,	'TRENZADORA 32 H',		'')
INSERT INTO HL.maquinas VALUES (7,	2,	14,	'TRENZADORA 24 H',		'')

--TERMINACIÓN
INSERT INTO HL.maquinas VALUES (12,	3,	1,	'PUNTERA 1',		'')
INSERT INTO HL.maquinas VALUES (13,	3,	2,	'PUNTERA 2',		'')


BEGIN TRAN
SELECT * FROM HL.maquinas ORDER BY idMaquina ASC
COMMIT		SELECT * FROM HL.maquinas ORDER BY idMaquina ASC
ROLLBACK	SELECT * FROM HL.maquinas ORDER BY idMaquina ASC 





ROLLBACK COMMIT
SELECT * FROM HL.maquinas

--DELETE FROM HL.maquinas







