-- CONFIGURACIONES INICIALES
		--Se usa la base de datos de nombre "pruebaDB"
		--USE DB_HilosLibertad
		USE prueba1
		GO
		--Se crea el esquema
		CREATE SCHEMA HL
		GO
		--Se establece el formato de fecha (para que sea YYYY-MM-DD HH:MM:SS)
		SET DATEFORMAT YMD
		GO



-- CREACIÓN DE TABLAS
		
		--TABLA sectores
		CREATE TABLE HL.sectores(
			idSector NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
			nombreSector NVARCHAR(255) NOT NULL
		)
		GO


		--TABLA maquinas
		CREATE TABLE HL.maquinas(
			idMaquina NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
			idSector NUMERIC(18,0) REFERENCES HL.sectores,
			numeroMaquinaUsuario SMALLINT,
			nombreMaquinaUsuario NVARCHAR(255),
			descripcion NVARCHAR(255)
		)
		GO


		--TABLA registros
		CREATE TABLE HL.registros(
			idRegistro NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
			idMaquina NUMERIC(18,0) REFERENCES HL.maquinas,
			fechaHoraEncendida SMALLDATETIME NOT NULL,
			fechaHoraUltimoRegistroEncendida SMALLDATETIME NOT NULL,
			fueApagadaPorOperarioOPorFallaParticular BIT,
			cantidadMinutosEncendida INT
		)
		GO


		/* Para eliminar todas las tablas se debe respetar un orden (el cual es inverso al que fueron creadas):
				DROP TABLE HL.registros
				DROP TABLE HL.maquinas
				DROP TABLE HL.sectores
		*/
		/* Para resetear el campo ID de una tabla XYZ a 0, primero se vacía la tabla y luego se resetea dicho campo autoincremental: 
				DELETE FROM HL.XYZ
				DBCC CHECKIDENT ('HL.XYZ', RESEED, 0)
		*/





-- INSERCIÓN DE DATOS INICIALES
		
		--TABLA sectores
		INSERT INTO HL.sectores (nombreSector) VALUES ('Telares')
		INSERT INTO HL.sectores (nombreSector) VALUES ('Cordoneras')
		INSERT INTO HL.sectores (nombreSector) VALUES ('Terminación')
		

		--TABLA maquinas
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar1')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar2')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar3')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar4')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar5')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar6')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar7')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar8')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar9')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Urdidora')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera1')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera2')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera3')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera4')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera5')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera6')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera7')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera8')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera9')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (3, 'Terminación1')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (3, 'Terminación2')
		INSERT INTO HL.maquinas (idSector, nombreMaquinaUsuario) VALUES (3, 'Terminación3')
		GO


