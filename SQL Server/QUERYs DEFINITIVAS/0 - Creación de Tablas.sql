-- CONFIGURACIONES INICIALES
		--Se usa la base de datos de nombre "pruebaDB"
		--USE DB_HilosLibertad
		USE prueba3
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
			nombreSectorUSUARIO NVARCHAR(255) NOT NULL
		)
		GO


		--TABLA maquinas
		CREATE TABLE HL.maquinas(
			idMaquina NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY, 		-- NO DEBE SER AUTOINCREMENTAL ---> HAY QUE ELIMINAR EL IDENTITY(1,1) 
			idSector NUMERIC(18,0) REFERENCES HL.sectores,
			numeroMaquinaUSUARIO SMALLINT,
			nombreMaquinaUSUARIO NVARCHAR(255),
			descripcionMaquinaUSUARIO NVARCHAR(255)
		)
		GO


		--TABLA registros
		CREATE TABLE HL.registros(
			idRegistro NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
			idMaquina NUMERIC(18,0) REFERENCES HL.maquinas,
			fechaHoraEncendida SMALLDATETIME NOT NULL,
			fechaHoraUltimoRegistroEncendida SMALLDATETIME NOT NULL,
			fueApagadaPorOperarioOPorFallaParticular BIT
		)
		GO


		SELECT * FROM HL.sectores
		SELECT * FROM HL.maquinas
		SELECT * FROM HL.registros


		/* 
		Para eliminar todas las tablas se debe respetar un orden (el cual es inverso al que fueron creadas):
				DROP TABLE HL.registros
				DROP TABLE HL.maquinas
				DROP TABLE HL.sectores
		*/
		/* 
		Para resetear el campo ID de una tabla HL.XXXXXXXXXXXXXX a 0, primero debe vaciarse y luego se resetea dicho campo autoincremental: 
				DELETE FROM HL.XXXXXXXXXXXXXX
				DBCC CHECKIDENT ('HL.XXXXXXXXXXXXXX', RESEED, 0)
		*/


