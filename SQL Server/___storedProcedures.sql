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


-- DATO: SE PUEDEN CREAR STORED PROCEDURES SOBRE CONSULTAS SELECT
-- DATO: LAS FECHAS QUE SE PASAN POR PARÁMETRO A LOS STORED PROCEDURES DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'
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
									ORDER BY fechaHoraUltimoRegistroEncendida DESC, idRegistro DESC)
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
									ORDER BY fechaHoraUltimoRegistroEncendida DESC, idRegistro DESC)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_terminarSesion



