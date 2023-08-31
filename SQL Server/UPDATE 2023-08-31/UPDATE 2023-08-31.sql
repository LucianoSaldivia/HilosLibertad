USE DB_HILOS_LIBERTAD
GO


--Se vac�a la tabla HL.registros
SELECT * FROM HL.registros
BEGIN TRAN
	DELETE FROM HL.registros
	SELECT * FROM HL.registros
COMMIT
SELECT * FROM HL.registros


--Se vac�a la tabla HL.maquinas
SELECT * FROM HL.maquinas
BEGIN TRAN
	DELETE FROM HL.maquinas
	SELECT * FROM HL.maquinas
COMMIT
SELECT * FROM HL.maquinas


 --Se setea el contador de id a 0
 DBCC CHECKIDENT ('HL.registros', RESEED, 0)
 SELECT * FROM HL.maquinas
 

--Se agregan todas las m�quinas a la tabla HL.maquinas
SELECT * FROM HL.sectores	


--INSERT INTO HL.maquinas VALUES (idMaquina,	idSector,	numeroMaquinaUSUARIO,	nombreMaquinaUSUARIO,	descripcionMaquinaUSUARIO)
--		idSector	1	Telares
--		idSector	2	Cordoneras
--		idSector	3	Terminaci�n
--		idSector	4	Urdidora
--INSERT INTO HL.maquinas VALUES (10,			1,			16,						'URDIDORA',				'')
SELECT * FROM HL.maquinas
BEGIN TRAN 
  INSERT INTO HL.maquinas VALUES (1,	1,	1,		'COSMO 8 Bocas',	'')
  INSERT INTO HL.maquinas VALUES (2,	1,	2,		'KYAN YHE 6/40',	'')
  INSERT INTO HL.maquinas VALUES (3,	1,	3,		'DKY 8/30',	'')
  INSERT INTO HL.maquinas VALUES (4,	1,	4,		'YITAI 8/55',	'')
  INSERT INTO HL.maquinas VALUES (5,	1,	5,		'KYAN YHE viejo 8/20',	'')
  INSERT INTO HL.maquinas VALUES (6,	1,	6,		'BONAS 2/60 (CEBRA)',	'')
  INSERT INTO HL.maquinas VALUES (7,	1,	8,		'TELAR HENG HUI 10/30',	'')
  --idMaquina = 8 NO EXISTE, SIN MÁQUINA ASIGNADA
  INSERT INTO HL.maquinas VALUES (9,	1,	9,		'BONAS 4/25',	'')
  INSERT INTO HL.maquinas VALUES (10,	4,	65,		'URDIDORA',	'')
  INSERT INTO HL.maquinas VALUES (11,	2,	11,		'KYAN YHE Indesmayable',	'')
  INSERT INTO HL.maquinas VALUES (12,	2,	12,		'KYAN YHE Indesmayable',	'')
  INSERT INTO HL.maquinas VALUES (13,	2,	13,		'KYAN YHE Indesmayable',	'')
  INSERT INTO HL.maquinas VALUES (14,	2,	14,		'TEXMAQ Indesmayable',	'')
  INSERT INTO HL.maquinas VALUES (15,	2,	15,		'TEXMAQ Indesmayable',	'')
  INSERT INTO HL.maquinas VALUES (16,	2,	16,		'RIUS 2 Bocas',	'En esta máquina están etiquetadas las máquinas 16 y 17.')
  INSERT INTO HL.maquinas VALUES (17,	2,	10,		'TUBULAR nueva 14 Bocas',	'')
  INSERT INTO HL.maquinas VALUES (18,	2,	18,		'TUBULAR vieja 10 Bocas',	'')
  INSERT INTO HL.maquinas VALUES (19,	3,	20,		'PUNTERA AZUL',	'')
  INSERT INTO HL.maquinas VALUES (20,	3,	121,	'PUNTERA VERDE',	'')
  --idMaquina = 21 NO EXISTE, SIN MÁQUINA ASIGNADA
  INSERT INTO HL.maquinas VALUES (22,	2,	22,		'GREKY',	'')
  INSERT INTO HL.maquinas VALUES (23,	2,	21,		'GREKY',	'')
  INSERT INTO HL.maquinas VALUES (24,	2,	26,		'TRENZADORA 32/2',	'')
  INSERT INTO HL.maquinas VALUES (25,	2,	25,		'TRENZADORA 32/2',	'')
  INSERT INTO HL.maquinas VALUES (26,	2,	27,		'TRENZADORA 24/2',	'')
  INSERT INTO HL.maquinas VALUES (27,	3,	29,		'PUNTERA HENG HUI 160',	'')
  INSERT INTO HL.maquinas VALUES (28,	3,	19,		'PUNTERA KYAN YHE AZUL',	'')
  INSERT INTO HL.maquinas VALUES (29,	3,	28,		'PUNTERA HENG HUI 160',	'')
  INSERT INTO HL.maquinas VALUES (30,	2,	24,		'GREKY',	'')
  INSERT INTO HL.maquinas VALUES (31,	2,	23,		'GREKY',	'')
  SELECT * FROM HL.maquinas
COMMIT




--Se actualiza la función f_getMinsONSinceLastReg: en la fecha se le agrega la letra 'T' por actualización de la versión del SQL SERVER (antes, con la versión 2014 andaba bien... ahora se le agrega esa bendita 'T' para solucionarlo...).
ALTER FUNCTION HL.f_getMinsONSinceLastReg
	(@idMaq NUMERIC)
RETURNS INT
AS BEGIN
	DECLARE @MaqFHURE SMALLDATETIME		--Último registro de encendido de dicha máquina
	DECLARE @mins INT

	-- Dado un idMaq, se calcula la última fechaHora de registro de encendido.
	-- De no encontrarse ningún registro, la fechaHora serán las 00:00:00 del 01/01/2020...
			
	IF (SELECT MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r WHERE r.idMaquina = @idMaq GROUP BY r.idMaquina) > 0
	BEGIN
		SELECT @MaqFHURE = MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r WHERE r.idMaquina = @idMaq GROUP BY r.idMaquina
	END
	ELSE BEGIN
		SELECT @MaqFHURE = '2020-01-01T00:00:00'
	END
			
	-- Se obtiene la cantidad de minutos transcurridos desde dicha fecha hasta el instante actual...
	--SELECT @mins = DATEDIFF(MINUTE, @MaqFHURE, GETDATE())
	SET @mins = (SELECT DATEDIFF(MINUTE, @MaqFHURE, GETDATE()) AS 'mm')

	RETURN @mins
END


SELECT * FROM HL.registros