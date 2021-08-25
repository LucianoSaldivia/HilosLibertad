-- INSERCIÓN DE DATOS INICIALES EN TABLAS
		
		--TABLA sectores
		INSERT INTO HL.sectores (nombreSectorUSUARIO) VALUES ('Telares')
		INSERT INTO HL.sectores (nombreSectorUSUARIO) VALUES ('Cordoneras')
		INSERT INTO HL.sectores (nombreSectorUSUARIO) VALUES ('Terminación')
		GO


		--TABLA maquinas
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   1,					 'Telar1',			   'Telar1-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   2,					 'Telar2',			   'Telar2-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   3,					 'Telar3',			   'Telar3-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   4,					 'Telar4',			   'Telar4-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   5,					 'Telar5',			   'Telar5-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   6,					 'Telar6',			   'Telar6-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   7,					 'Telar7',			   'Telar7-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   8,					 'Telar8',			   'Telar8-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   9,					 'Telar9',			   'Telar9-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (1,		   10,					 'Urdidora',		   'Urdidora-descripcion')

		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   11,					 'Cordonera1',		   'Cordonera1-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   12,					 'Cordonera2',		   'Cordonera2-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   13,					 'Cordonera3',		   'Cordonera3-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   14,					 'Cordonera4',		   'Cordonera4-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   15,					 'Cordonera5',		   'Cordonera5-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   16,					 'Cordonera6',		   'Cordonera6-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   17,					 'Cordonera7',		   'Cordonera7-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   18,					 'Cordonera8',		   'Cordonera8-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (2,		   19,					 'Cordonera9',		   'Cordonera9-descripcion')

		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (3,		   20,					 'Terminación1',	   'Terminación1-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (3,		   21,					 'Terminación2',	   'Terminación2-descripcion')
		INSERT INTO HL.maquinas (idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
						 VALUES (3,		   22,					 'Terminación3',	   'Terminación3-descripcion')
		GO
		
		SELECT * FROM HL.maquinas
		

