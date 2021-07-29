--CONFIGURACIONES INICIALES

--Se usa la base de datos de nombre "pruebaDB"
USE pruebaDB
GO

--Se crea el esquema
CREATE SCHEMA HILOSLIBERTAD
GO

--Se establece el formato de fecha (para que sea YYYY-MM-DD HH:MM:SS)
SET DATEFORMAT YMD
GO





--CREACIÓN DE TABLAS
--Tabla sectores
--DROP TABLE HILOSLIBERTAD.sectores
CREATE TABLE HILOSLIBERTAD.sectores(
	idSector NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
	nombreSector NVARCHAR(255) NOT NULL
)
GO

--Tabla maquinas
--DROP TABLE HILOSLIBERTAD.maquinas
CREATE TABLE HILOSLIBERTAD.maquinas(
	idMaquina NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
	idSector NUMERIC(18,0) REFERENCES HILOSLIBERTAD.sectores,
	numeroMaquinaUsuario SMALLINT,
	nombreMaquinaUsuario NVARCHAR(255),
	descripcion NVARCHAR(255)
)
GO

--Tabla registros
--DROP TABLE HILOSLIBERTAD.registros
CREATE TABLE HILOSLIBERTAD.registros(
	idRegistro NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
	idMaquina NUMERIC(18,0) REFERENCES HILOSLIBERTAD.maquinas,
	fechaHoraEncendida SMALLDATETIME NOT NULL,
	fechaHoraUltimoRegistroEncendida SMALLDATETIME NOT NULL,
	fueApagadaPorOperarioOPorFallaParticular BIT,
	cantidadMinutosEncendida INT
)
GO




--INSERCIÓN DE DATOS INICIALES: sectores y máquinas
INSERT INTO HILOSLIBERTAD.sectores (nombreSector) VALUES ('Telares')
INSERT INTO HILOSLIBERTAD.sectores (nombreSector) VALUES ('Cordoneras')
INSERT INTO HILOSLIBERTAD.sectores (nombreSector) VALUES ('Terminación')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar1')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar2')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar3')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar4')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar5')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar6')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar7')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar8')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Telar9')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (1, 'Urdidora')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera1')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera2')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera3')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera4')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera5')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera6')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera7')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera8')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (2, 'Cordonera9')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (3, 'Terminación1')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (3, 'Terminación2')
INSERT INTO HILOSLIBERTAD.maquinas (idSector, nombreMaquinaUsuario) VALUES (3, 'Terminación3')




--NUEVOS STORED PROCEDURES
		--STORED PROCEDURE "SESSION STARTS": inserta el idMaquina y su fecha/hora de encendido.
		--DROP PROCEDURE insertarSesion
		CREATE OR ALTER PROCEDURE insertarSesion
			@idMaquina NUMERIC(18,0),
			@fechaHoraEncendida SMALLDATETIME
		AS
		BEGIN
			INSERT INTO HILOSLIBERTAD.registros (idMaquina,
												 fechaHoraEncendida,
												 fechaHoraUltimoRegistroEncendida,
												 fueApagadaPorOperarioOPorFallaParticular,
												 cantidadMinutosEncendida)
				VALUES (@idMaquina,
						@fechaHoraEncendida,
						@fechaHoraEncendida,
						0,
						0)
		END
		GO

		--STORED PROCEDURE "SESSION CONTINUES": actualiza la fecha/hora del último registro de encendido de esa máquina.
		--DROP PROCEDURE actualizarSesion
		CREATE OR ALTER PROCEDURE actualizarSesion
			@idMaquina NUMERIC(18, 0),
			@fechaHoraUltimoRegistroEncendida SMALLDATETIME
		AS
		BEGIN
			UPDATE HILOSLIBERTAD.registros
				SET fechaHoraUltimoRegistroEncendida = @fechaHoraUltimoRegistroEncendida
				WHERE idRegistro = (SELECT TOP 1 idRegistro
									FROM HILOSLIBERTAD.registros
									WHERE idMaquina = @idMaquina
									ORDER BY fechaHoraUltimoRegistroEncendida DESC)
		END
		GO

		--STORED PROCEDURE "SESSION FINISHES": actualiza la fecha/hora del último registro de encendido de esa máquina, indicando que ésta fue apagada por operario o por falla particular.
		--DROP PROCEDURE terminarSesion
		CREATE OR ALTER PROCEDURE terminarSesion
			@idmaquina NUMERIC(18, 0),
			@fechaHoraUltimoRegistroEncendida SMALLDATETIME
		AS
		BEGIN
			UPDATE HILOSLIBERTAD.registros
				SET fechaHoraUltimoRegistroEncendida = @fechaHoraUltimoRegistroEncendida,
					fueApagadaPorOperarioOPorFallaParticular = 1
				WHERE idRegistro = (SELECT TOP 1 idRegistro
									FROM HILOSLIBERTAD.registros
									WHERE idMaquina = @idMaquina
									ORDER BY fechaHoraUltimoRegistroEncendida DESC)
		END
		GO
--

--NUEVO TRIGGER

		--DROP TRIGGER HILOSLIBERTAD.trigger1
		CREATE OR ALTER TRIGGER trigger1
		ON HILOSLIBERTAD.registros
		AFTER UPDATE
		AS
		BEGIN
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
			FETCH NEXT FROM cursor1
				INTO @idReg, @idMaq, @fhEnc, @fhUltRegEnc

			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @cantMinEnc = DATEDIFF(MINUTE, @fhEnc, @fhUltRegEnc)

				UPDATE HILOSLIBERTAD.registros
					SET cantidadMinutosEncendida = @cantMinEnc
					WHERE idRegistro = (SELECT TOP 1 idRegistro
										FROM HILOSLIBERTAD.registros
										WHERE idMaquina = @idMaq
										ORDER BY fechaHoraUltimoRegistroEncendida DESC)

				FETCH NEXT FROM cursor1
					INTO @idReg, @idMaq, @fhEnc, @fhUltRegEnc
			END
			
			CLOSE cursor1
			DEALLOCATE cursor1
		END

--
























/*


--CREACIÓN DE TRIGGERS
--DROP TRIGGER HILOSLIBERTAD.trigger_actualizarCantidadMinutosEncendida
CREATE TRIGGER trigger_actualizarCantidadMinutosEncendida
ON HILOSLIBERTAD.registros
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	DECLARE @idRegistro NUMERIC(18,0)
	DECLARE @idMaquina NUMERIC(18,0)
	DECLARE @fechaHoraEncendida SMALLDATETIME
	DECLARE @fechaHoraUltimoRegistroEncendida SMALLDATETIME
	DECLARE @fueApagadaPorOperarioOPorFallaParticular BIT
	DECLARE @cantidadMinutosEncendida INT

	DECLARE cursor1 CURSOR FOR
		SELECT idRegistro, idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida, fueApagadaPorOperarioOPorFallaParticular, cantidadMinutosEncendida
		FROM inserted
	OPEN cursor1
	FETCH NEXT FROM cursor1
		INTO @idRegistro, @idMaquina, @fechaHoraEncendida, @fechaHoraUltimoRegistroEncendida, @fueApagadaPorOperarioOPorFallaParticular, @cantidadMinutosEncendida
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				IF NOT EXISTS (SELECT TOP 1 NULL FROM deleted) BEGIN -- Si es un INSERT...
					INSERT INTO HILOSLIBERTAD.registros (idMaquina,
														 fechaHoraEncendida,
														 fechaHoraUltimoRegistroEncendida,
														 fueApagadaPorOperarioOPorFallaParticular,
														 cantidadMinutosEncendida)
						VALUES (@idMaquina,
								@fechaHoraEncendida,
								@fechaHoraUltimoRegistroEncendida,
								@fueApagadaPorOperarioOPorFallaParticular,
								DATEDIFF(MINUTE, @fechaHoraEncendida, @fechaHoraUltimoRegistroEncendida))
				END
				ELSE BEGIN -- Si es un UPDATE...
					SET @cantidadMinutosEncendida = DATEDIFF(MINUTE, @fechaHoraEncendida, @fechaHoraUltimoRegistroEncendida)
					UPDATE HILOSLIBERTAD.registros
						SET cantidadMinutosEncendida = @cantidadMinutosEncendida
						WHERE idRegistro = @idRegistro
					UPDATE HILOSLIBERTAD.registros
						SET fechaHoraUltimoRegistroEncendida = @fechaHoraUltimoRegistroEncendida
						WHERE idRegistro = @idRegistro				
				END
			COMMIT TRANSACTION
		END TRY
		
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
		
		FETCH NEXT FROM cursor1
		INTO @idRegistro, @idMaquina, @fechaHoraEncendida, @fechaHoraUltimoRegistroEncendida, @fueApagadaPorOperarioOPorFallaParticular, @cantidadMinutosEncendida
	END
	CLOSE cursor1
	DEALLOCATE cursor1
END
GO




--CREACIÓN DE STORED PROCEDURES
--STORED PROCEDURE para insertar dos fechas/horas (útil para cargar datos de prueba solamente)
--DROP PROCEDURE insertar2fechas
CREATE OR ALTER PROCEDURE insertar2fechas
	@idMaquina NUMERIC(18,0),
	@fechaHoraEncendida SMALLDATETIME,
	@fechaHoraUltimoRegistroEncendida SMALLDATETIME
AS
BEGIN
	INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
		VALUES (@idMaquina, @fechaHoraEncendida, @fechaHoraUltimoRegistroEncendida)
END
GO

--STORED PROCEDURE "SESSION STARTS": inserta el idMaquina y su fecha/hora de encendido.
--DROP PROCEDURE insertarSesion
CREATE OR ALTER PROCEDURE insertarSesion
	@idMaquina NUMERIC(18,0),
	@fechaHoraEncendida SMALLDATETIME
AS
BEGIN
	INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida, fueApagadaPorOperarioOPorFallaParticular)
		VALUES (@idMaquina, @fechaHoraEncendida, @fechaHoraEncendida, 0)
END
GO

--STORED PROCEDURE "SESSION CONTINUES": actualiza la fecha/hora del último registro de encendido de esa máquina.
--DROP PROCEDURE actualizarSesion
CREATE OR ALTER PROCEDURE actualizarSesion
	@idMaquina NUMERIC(18, 0),
	@fechaHoraUltimoRegistroEncendida SMALLDATETIME
AS
BEGIN
	UPDATE HILOSLIBERTAD.registros
		SET fechaHoraUltimoRegistroEncendida = @fechaHoraUltimoRegistroEncendida
		WHERE idRegistro = (SELECT TOP 1 idRegistro
							FROM HILOSLIBERTAD.registros
							WHERE idMaquina = @idMaquina
							ORDER BY fechaHoraUltimoRegistroEncendida DESC)
END
GO

--STORED PROCEDURE "SESSION FINISHES": actualiza la fecha/hora del último registro de encendido de esa máquina, indicando que ésta fue apagada por operario o por falla particular.
--DROP PROCEDURE terminarSesion
CREATE OR ALTER PROCEDURE terminarSesion
	@idmaquina NUMERIC(18, 0),
	@fechaHoraUltimoRegistroEncendida SMALLDATETIME
AS
BEGIN
	UPDATE HILOSLIBERTAD.registros
		SET fechaHoraUltimoRegistroEncendida = @fechaHoraUltimoRegistroEncendida
		WHERE idRegistro = (SELECT TOP 1 idRegistro
							FROM HILOSLIBERTAD.registros
							WHERE idMaquina = @idMaquina
							ORDER BY fechaHoraUltimoRegistroEncendida DESC)
	UPDATE HILOSLIBERTAD.registros
		SET fueApagadaPorOperarioOPorFallaParticular = 1
		WHERE idRegistro = (SELECT TOP 1 idRegistro
							FROM HILOSLIBERTAD.registros
							WHERE idMaquina = @idMaquina
							ORDER BY fechaHoraUltimoRegistroEncendida DESC)
END
GO



*/










DELETE FROM HILOSLIBERTAD.registros
DBCC CHECKIDENT ('HILOSLIBERTAD.registros', RESEED, 0)

--Líneas de prueba de STORED PROCEDURES

SELECT * FROM HILOSLIBERTAD.registros
EXEC insertarSesion 1, '2018-12-09 16:00:00'
SELECT * FROM HILOSLIBERTAD.registros
EXEC actualizarSesion 1, '2018-12-09 16:05:00'
SELECT * FROM HILOSLIBERTAD.registros
EXEC terminarSesion 1, '2018-12-09 16:45:00'
SELECT * FROM HILOSLIBERTAD.registros

SELECT * FROM HILOSLIBERTAD.registros
EXEC insertarSesion 1, '2019-04-04 04:00:00'
SELECT * FROM HILOSLIBERTAD.registros
EXEC actualizarSesion 1, '2019-04-04 04:01:00'
SELECT * FROM HILOSLIBERTAD.registros
EXEC actualizarSesion 1, '2019-04-04 04:02:00'
SELECT * FROM HILOSLIBERTAD.registros
EXEC actualizarSesion 1, '2019-04-04 04:10:00'
SELECT * FROM HILOSLIBERTAD.registros
EXEC terminarSesion 1, '2019-04-05 04:15:00'
SELECT * FROM HILOSLIBERTAD.registros







--Query de muestra (bruto)
SELECT *
	FROM HILOSLIBERTAD.sectores s
	JOIN HILOSLIBERTAD.maquinas m ON (s.idSector = m.idSector)
	JOIN HILOSLIBERTAD.registros r ON (m.idMaquina = r.idMaquina)

--Query de muestra (simpático)
SELECT m.numeroMaquinaUsuario AS 'Número de Máquina',
	   m.nombreMaquinaUsuario AS 'Máquina',
	   s.nombreSector AS 'Sector',
	   r.cantidadMinutosEncendida AS 'Minutos Encendida'
	FROM HILOSLIBERTAD.sectores s
	JOIN HILOSLIBERTAD.maquinas m ON (s.idSector = m.idSector)
	JOIN HILOSLIBERTAD.registros r ON (m.idMaquina = r.idMaquina)





--Vista para pruebas del Registrador
--AL BORRAR LA VISTA, TAMBIÉN SE BORRAN/VACÍAN LOS DATOS DE LA TABLA ASOCIADA --> DELETE vista_registrador 
--DROP VIEW vista_registrador 
CREATE OR ALTER VIEW vista_registrador AS (
	SELECT r.idMaquina AS 'idMaq',
		   r.fechaHoraEncendida AS 'INIT_DT',
		   r.fechaHoraUltimoRegistroEncendida AS 'LAST_DT',
		   r.fueApagadaPorOperarioOPorFallaParticular AS 'TRND_OFF'
	FROM HILOSLIBERTAD.registros r
)
GO

SELECT * FROM vista_registrador
SELECT TOP 1 * FROM vista_registrador
SELECT TOP 1 * FROM vista_registrador ORDER BY LAST_DT DESC


--Tener en cuenta que las fechas son siempre crecientes.
--A la hora de actualizar una fecha, siempre se actualizará la más reciente

--Considerar todo tipo de casos de prueba: 2 INSERTs seguidos con el mismo idMaquina













