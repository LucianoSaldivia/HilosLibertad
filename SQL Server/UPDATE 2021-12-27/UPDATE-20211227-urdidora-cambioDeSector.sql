
-- Inserción del nuevo sector URDIDORA
INSERT INTO HL.sectores VALUES (4, 'Urdidora')
SELECT * FROM HL.sectores

-- Cambio de sector de la máquina URDIDORA --> pasa a ser del sector 4 (Urdidora)
UPDATE HL.maquinas
	SET idSector = 4
	WHERE nombreMaquinaUSUARIO = 'URDIDORA'
SELECT * FROM HL.maquinas

