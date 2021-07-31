-- 0. CONFIGURACIONES INICIALES

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





-- 1. CREACIÓN DE TABLAS
		
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


		--Para eliminar todas las tablas se debe respetar un orden (el cual es inverso al que fueron creadas):
		--DROP TABLE HL.registros
		--DROP TABLE HL.maquinas
		--DROP TABLE HL.sectores
		
		--Para resetear el campo ID de una tabla XYZ a 0, primero se vacía la tabla y luego se resetea dicho campo autoincremental: 
		--DELETE FROM HL.XYZ
		--DBCC CHECKIDENT ('HL.XYZ', RESEED, 0)




-- 2. INSERCIÓN DE DATOS INICIALES
		
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





		



-- STORED PROCEDUREs

		--STORED PROCEDURE insertarSesion --> "SESSION STARTS"
		--Sirve para insertar el idMaquina y su fecha/hora de encendido.
		CREATE OR ALTER PROCEDURE HL.sp_insertarSesion
			@idMaq NUMERIC(18,0),
			@fHEnc SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			INSERT INTO HL.registros
					   (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida, fueApagadaPorOperarioOPorFallaParticular, cantidadMinutosEncendida)
				VALUES (@idMaq,	   @fHEnc,			   @fHEnc,							 0,										   0)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_insertarSesion
		
		--STORED PROCEDURE actualizarSesion --> "SESSION CONTINUES"
		--Sirve para actualizar la fecha/hora del último registro de encendido de cierta máquina (cuyo ID se pasa por parámetro).
		CREATE OR ALTER PROCEDURE HL.sp_actualizarSesion
			@idMaq NUMERIC(18, 0),
			@fHUltRegEnc SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			UPDATE HL.registros
				SET fechaHoraUltimoRegistroEncendida = @fHUltRegEnc
				WHERE idRegistro = (SELECT TOP 1 idRegistro
									FROM HL.registros
									WHERE idMaquina = @idMaq
									ORDER BY fechaHoraUltimoRegistroEncendida DESC)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_actualizarSesion

		--STORED PROCEDURE terminarSesion --> "SESSION FINISHES"
		--Sirve para actualizar la fecha/hora del último registro de encendido de cierta máquina (cuyo ID se pasa por parámetro), indicando que fue apagada por un operario o por una falla particular.
		CREATE OR ALTER PROCEDURE HL.sp_terminarSesion
			@idMaq NUMERIC(18, 0),
			@fHUltRegEnc SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			UPDATE HL.registros
				SET fechaHoraUltimoRegistroEncendida = @fHUltRegEnc,
					fueApagadaPorOperarioOPorFallaParticular = 1
				WHERE idRegistro = (SELECT TOP 1 idRegistro
									FROM HL.registros
									WHERE idMaquina = @idMaq
									ORDER BY fechaHoraUltimoRegistroEncendida DESC)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_terminarSesion








-- TRIGGERs
		
		--TRIGGER actualizarCantidadMinutosEncendida
		--Al actualizarse la TABLA registros, se actualiza (automáticamente) la cantidad de minutos que estuvo la máquina encendida.
		CREATE OR ALTER TRIGGER HL.t_actualizarCantidadMinutosEncendida
		ON HL.registros
		AFTER UPDATE
		AS BEGIN
			DECLARE @idReg NUMERIC(18,0),
					@idMaq NUMERIC(18,0),
					@fhEnc SMALLDATETIME,
					@fhUltRegEnc SMALLDATETIME,
					@cantMinEnc INT
			DECLARE cursor1 CURSOR FOR
				SELECT d.idRegistro,
					   d.idMaquina,
					   d.fechaHoraEncendida,
					   i.fechaHoraUltimoRegistroEncendida
				FROM inserted i JOIN deleted d ON (i.idRegistro = d.idRegistro)
			OPEN cursor1
			FETCH NEXT FROM cursor1 INTO @idReg, @idMaq, @fhEnc, @fhUltRegEnc
			WHILE @@FETCH_STATUS = 0 BEGIN
				SET @cantMinEnc = DATEDIFF(MINUTE, @fhEnc, @fhUltRegEnc)
				UPDATE HL.registros
					SET cantidadMinutosEncendida = @cantMinEnc
					WHERE idRegistro = (SELECT TOP 1 idRegistro
										FROM HL.registros
										WHERE idMaquina = @idMaq
										ORDER BY fechaHoraUltimoRegistroEncendida DESC)
				FETCH NEXT FROM cursor1 INTO @idReg, @idMaq, @fhEnc, @fhUltRegEnc
			END
			CLOSE cursor1
			DEALLOCATE cursor1
		END
		--Para eliminar el TRIGGER: DROP TRIGGER HL.t_actualizarCantidadMinutosEncendida
		


-- SE PUEDEN CREAR STORED PROCEDURES SOBRE CONSULTAS SELECT






-- VISTAS

		--VISTA vista_registrador
		--Usada para pruebas en el Registrador
		CREATE OR ALTER VIEW HL.v_registrador AS (
			SELECT r.idMaquina AS 'idMaq',
				   r.fechaHoraEncendida AS 'INIT_DT',
				   r.fechaHoraUltimoRegistroEncendida AS 'LAST_DT',
				   r.fueApagadaPorOperarioOPorFallaParticular AS 'TRND_OFF',
				   r.cantidadMinutosEncendida AS 'MINS_ON'
			FROM HL.registros r
		)
		GO
		--Ejemplo de uso: SELECT TOP 1 * FROM vista_registrador ORDER BY LAST_DT DESC
		--Para borrar la vista: DROP VIEW HL.v_registrador
		--TENER EN CUENTA QUE, AL BORRAR LA VISTA, TAMBIÉN SE BORRAN LOS DATOS DE LA TABLA ASOCIADA --> DELETE HL.v_registrador 
		

		SELECT * FROM HL.v_registrador





--Líneas de prueba de STORED PROCEDURES

SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2018-12-09 16:00:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2018-12-09 16:05:00'
SELECT * FROM HL.registros
EXEC HL.sp_terminarSesion 1, '2018-12-09 16:45:00'
SELECT * FROM HL.registros

SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2019-04-04 04:00:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2019-04-04 04:01:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2019-04-04 04:02:00'
SELECT * FROM HL.registros
EXEC HL.sp_actualizarSesion 1, '2019-04-04 04:10:00'
SELECT * FROM HL.registros
EXEC HL.sp_terminarSesion 1, '2019-04-05 04:15:00'
SELECT * FROM HL.registros


