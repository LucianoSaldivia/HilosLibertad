USE DB_HILOS_LIBERTAD
GO

-- Se cambian de nombre y número las máquinas de id 19 y 20

SELECT * FROM HL.maquinas WHERE idMaquina = 19 OR idMaquina = 20

BEGIN TRAN
	UPDATE HL.maquinas SET nombreMaquinaUSUARIO = 'PUNTERA VERDE'	WHERE idMaquina = 19
	UPDATE HL.maquinas SET nombreMaquinaUSUARIO = 'PUNTERA AZUL'	WHERE idMaquina = 20
	UPDATE HL.maquinas SET numeroMaquinaUSUARIO = 121	WHERE idMaquina = 19
	UPDATE HL.maquinas SET numeroMaquinaUSUARIO = 20	WHERE idMaquina = 20
	
	SELECT * FROM HL.maquinas WHERE idMaquina = 19 OR idMaquina = 20
	
	COMMIT


