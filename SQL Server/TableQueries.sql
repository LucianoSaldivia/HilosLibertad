-- Creo tabla "tablaEjemplo" en base "ejemplo"
/*
--create database testDatabase
*/

DROP TABLE testTable

GO

CREATE TABLE testTable (
	idMaquina TINYINT NOT NULL,
	fechaHoraEncendido SMALLDATETIME NOT NULL,
	fechaHoraUltimoRegistroEncendido SMALLDATETIME,
	fueApagadaPorOperarioOPorFallaParticular BIT NOT NULL,
	minutosEncendida BIGINT
)

GO

-- Maq1 sesión completa
INSERT INTO testTable (idMaquina, fechaHoraEncendido, fechaHoraUltimoRegistroEncendido, fueApagadaPorOperarioOPorFallaParticular)
	VALUES(
		1, 
		CAST('2021-06-05T14:00:00' AS SMALLDATETIME),
		CAST('2021-06-05T14:15:00' AS SMALLDATETIME),
		1
	)

-- Maq2 sesión completa
INSERT INTO testTable (idMaquina, fechaHoraEncendido, fechaHoraUltimoRegistroEncendido, fueApagadaPorOperarioOPorFallaParticular)
	VALUES(
		2, 
		CAST('2021-06-01T17:00:00' AS SMALLDATETIME),
		CAST('2021-06-01T17:15:00' AS SMALLDATETIME),
		1
	)

-- Maq1 sesión incompleta
INSERT INTO testTable (idMaquina, fechaHoraEncendido, fechaHoraUltimoRegistroEncendido, fueApagadaPorOperarioOPorFallaParticular)
	VALUES(
		1, 
		CAST('2021-06-02T14:00:00' AS SMALLDATETIME),
		CAST('2021-06-02T14:05:00' AS SMALLDATETIME),
		0
	)
-- Se corta la luz

-- Maq1 empieza
INSERT INTO testTable (idMaquina, fechaHoraEncendido, fueApagadaPorOperarioOPorFallaParticular)
	VALUES(
		1, 
		CAST('2021-06-03T14:00:00' AS SMALLDATETIME),
		0
	)
	

UPDATE testTable
	SET fechaHoraUltimoRegistroEncendido = CAST('2021-06-03T14:05:00' AS SMALLDATETIME)
	WHERE idMaquina = 1
	  AND fueApagadaPorOperarioOPorFallaParticular = 0
	  AND fechaHoraEncendido = (SELECT TOP 1 fechaHoraEncendido
						  FROM testTable
						  WHERE idMaquina = 1
						  ORDER BY fechaHoraEncendido DESC)

UPDATE testTable
	SET fechaHoraUltimoRegistroEncendido = CAST('2021-06-03T14:10:00' AS SMALLDATETIME)
	WHERE idMaquina = 1
	  AND fueApagadaPorOperarioOPorFallaParticular = 0
	  AND fechaHoraEncendido = (SELECT TOP 1 fechaHoraEncendido
						  FROM testTable
						  WHERE idMaquina = 1
						  ORDER BY fechaHoraEncendido DESC)

-- SELECT * FROM testTable

UPDATE testTable
	SET fechaHoraUltimoRegistroEncendido = CAST('2021-06-03T14:15:00' AS SMALLDATETIME),
		fueApagadaPorOperarioOPorFallaParticular = 1

	WHERE idMaquina = 1
	  AND fueApagadaPorOperarioOPorFallaParticular = 0
	  AND fechaHoraEncendido = (SELECT TOP 1 fechaHoraEncendido
						  FROM testTable
						  WHERE idMaquina = 1
						  ORDER BY fechaHoraEncendido DESC)

-- Maq3 empieza
INSERT INTO testTable (idMaquina, fechaHoraEncendido, fueApagadaPorOperarioOPorFallaParticular)
	VALUES(
		3, 
		CAST('2021-06-04T14:00:00' AS SMALLDATETIME),
		0
	)





UPDATE testTable
	SET minutosEncendida = DATEDIFF(MINUTE, fechaHoraEncendido, fechaHoraUltimoRegistroEncendido)


SELECT * FROM testTable ORDER BY fechaHoraEncendido DESC
-- SELECT TOP 30 * FROM testTable ORDER BY fecha_inicio DESC
