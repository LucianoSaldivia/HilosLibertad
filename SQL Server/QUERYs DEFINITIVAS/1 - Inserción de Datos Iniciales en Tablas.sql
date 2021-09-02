-- INSERCIÓN DE DATOS INICIALES EN TABLAS
		
		--TABLA sectores
		INSERT INTO HL.sectores VALUES (1, 'Telares')
		INSERT INTO HL.sectores VALUES (2, 'Cordoneras')
		INSERT INTO HL.sectores VALUES (3, 'Terminación')
		GO


		--TABLA maquinas
		INSERT INTO HL.maquinas VALUES (1,	1,	101,	'Telar1',		'Telar1-descripcion')
		INSERT INTO HL.maquinas VALUES (2,	1,	102,	'Telar2',		'Telar2-descripcion')
		INSERT INTO HL.maquinas VALUES (3,	1,	103,	'Telar3',		'Telar3-descripcion')
		INSERT INTO HL.maquinas VALUES (4,	1,	104,	'Telar4',		'Telar4-descripcion')
		INSERT INTO HL.maquinas VALUES (5,	1,	105,	'Telar5',		'Telar5-descripcion')
		INSERT INTO HL.maquinas VALUES (6,	1,	106,	'Telar6',		'Telar6-descripcion')
		INSERT INTO HL.maquinas VALUES (7,	1,	107,	'Telar7',		'Telar7-descripcion')
		INSERT INTO HL.maquinas VALUES (8,	1,	108,	'Telar8',		'Telar8-descripcion')
		INSERT INTO HL.maquinas VALUES (9,	1,	109,	'Telar9',		'Telar9-descripcion')
		INSERT INTO HL.maquinas VALUES (10,	1,	110,	'Urdidora',		'Urdidora-descripcion')
		INSERT INTO HL.maquinas VALUES (11,	2,	201,	'Cordonera1',	'Cordonera1-descripcion')
		INSERT INTO HL.maquinas VALUES (12,	2,	202,	'Cordonera2',	'Cordonera2-descripcion')
		INSERT INTO HL.maquinas VALUES (13,	2,	203,	'Cordonera3',	'Cordonera3-descripcion')
		INSERT INTO HL.maquinas VALUES (14,	2,	204,	'Cordonera4',	'Cordonera4-descripcion')
		INSERT INTO HL.maquinas VALUES (15,	2,	205,	'Cordonera5',	'Cordonera5-descripcion')
		INSERT INTO HL.maquinas VALUES (16,	2,	206,	'Cordonera6',	'Cordonera6-descripcion')
		INSERT INTO HL.maquinas VALUES (17,	2,	207,	'Cordonera7',	'Cordonera7-descripcion')
		INSERT INTO HL.maquinas VALUES (18,	2,	208,	'Cordonera8',	'Cordonera8-descripcion')
		INSERT INTO HL.maquinas VALUES (19,	2,	209,	'Cordonera9',	'Cordonera9-descripcion')
		INSERT INTO HL.maquinas VALUES (20,	3,	301,	'Terminación1',	'Terminación1-descripcion')
		INSERT INTO HL.maquinas VALUES (21,	3,	302,	'Terminación2',	'Terminación2-descripcion')
		INSERT INTO HL.maquinas VALUES (22,	3,	303,	'Terminación3',	'Terminación3-descripcion')
		GO
		
		SELECT * FROM HL.maquinas
		

