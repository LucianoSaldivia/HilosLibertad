SELECT m.idMaquina, m.idSector, s.nombreSectorUSUARIO, m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO
FROM HL.maquinas m JOIN HL.sectores s ON (m.idSector = s.idSector)


-- Se agregan las máquinas 22 y 23 al sector Cordoneras
INSERT INTO HL.maquinas VALUES (22,	2,	22,	'Cordonera22',		'Cord22-Desc')
INSERT INTO HL.maquinas VALUES (23,	2,	23,	'Cordonera23',		'Cord23-Desc')


SELECT m.idMaquina, m.idSector, s.nombreSectorUSUARIO, m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO
FROM HL.maquinas m JOIN HL.sectores s ON (m.idSector = s.idSector)
