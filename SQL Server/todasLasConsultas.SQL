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




--CREACIÓN DE TRIGGERS
--DROP TRIGGER HILOSLIBERTAD.registros_actualizarCantidadMinutosEncendida
CREATE TRIGGER registros_actualizarCantidadMinutosEncendida
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

--STORED PROCEDURE "SESSION STARTS", para insertar una fecha/hora de máquina encendida
--DROP PROCEDURE insertarUnaFecha
CREATE OR ALTER PROCEDURE insertarFechaHoraEncendida
	@idMaquina NUMERIC(18,0),
	@fechaHoraEncendida SMALLDATETIME
AS
BEGIN
	INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida, fueApagadaPorOperarioOPorFallaParticular)
		VALUES (@idMaquina, @fechaHoraEncendida, @fechaHoraEncendida, 0)
END
GO

--STORED PROCEDURE "SESSION CONTINUES", para insertar una fecha/hora de último registro de máquina encendida
--DROP PROCEDURE actualizarFechaHoraUltimoRegistroEncendida
CREATE OR ALTER PROCEDURE actualizarFechaHoraUltimoRegistroEncendida
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


--STORED PROCEDURE "SESSION FINISHES", para
--DROP PROCEDURE procedureOtro
CREATE OR ALTER PROCEDURE procedureOtro
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

--poner nombres pertinentes a los STORED PROCEDURES












DELETE FROM HILOSLIBERTAD.registros

EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2022-07-24 23:59:00'
SELECT * FROM HILOSLIBERTAD.registros

EXEC insertarFechaHoraEncendida 1, '2018-12-09 16:00:00'
SELECT * FROM HILOSLIBERTAD.registros

EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2018-12-09 16:00:01'
EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2018-12-09 16:01:00'
EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2018-12-09 17:00:00'
EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2018-12-09 16:00:00'
EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2018-12-10 16:00:00'
EXEC insertar2fechas 1, '2018-12-09 16:00:00', '2019-01-09 16:00:00'


SELECT * FROM HILOSLIBERTAD.registros

INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, CONVERT(SMALLDATETIME, '2018-12-09 16:00:00', 120), CONVERT(SMALLDATETIME, '2018-12-09 16:00:00', 120))
SELECT * FROM HILOSLIBERTAD.registros

INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, '2018-12-09 16:00:00', '2018-12-09 16:01:00')
INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, '2018-12-09 16:00:00', '2018-12-09 17:00:00')
INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, '2018-12-09 16:00:00', '2018-12-10 16:00:00')
INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, '2018-12-09 16:00:00', '2018-01-09 16:00:00')
INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, '2018-12-09 16:00:00', '2019-12-09 16:00:00')

INSERT INTO HILOSLIBERTAD.registros (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)
	VALUES (1, CONVERT(SMALLDATETIME, '2018-12-09 16:00:00', 20), CONVERT(SMALLDATETIME, '2019-12-09 16:00:00', 20))

SELECT * FROM HILOSLIBERTAD.registros



SELECT CONVERT(SMALLDATETIME, GETDATE(), 20)	
SELECT '2018-12-09 16:00:00'








