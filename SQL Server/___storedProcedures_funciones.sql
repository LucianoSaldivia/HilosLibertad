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
					   (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida, fueApagadaPorOperarioOPorFallaParticular)
				VALUES (@idMaq,	   @fHEnc,			   @fHEnc,							 0)
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


		--FUNCIÓN
		--Dado un INT en minutos, devuelve un NUMERIC(15,3) en horas
		CREATE OR ALTER FUNCTION HL.f_transformarMinutosEnHoras
			(@minutos INT)
		RETURNS NUMERIC(15,3)
		AS BEGIN
			DECLARE @horas NUMERIC(15,3)
			SET @horas = @minutos / 60.0
			RETURN @horas
		END
		GO

		--DROP FUNCTION HL.f_transformarMinutosEnHoras
		/*
		Ejemplos de uso:
		SELECT 45 AS 'minutos', HL.f_transformarMinutosEnHoras(45) AS 'f_horas'
		SELECT 630 AS 'minutos', HL.f_transformarMinutosEnHoras(630) AS 'f_horas'
		*/
			   

		--FUNCIÓN HL.f_getYYYYMMDDfromDateTime
		--Dado una fecha en SMALLDATETIME, devuelve un NUMERIC(8,0) así: YYYYMMDD
		CREATE OR ALTER FUNCTION HL.f_getYYYYMMDDfromDateTime
			(@DT SMALLDATETIME) --en formato 'YY-DD-MM HH:MM:00', salvo que lo lea de un campo de la base
		RETURNS NUMERIC(8,0)
		AS BEGIN
			DECLARE @YYYYMMDD NUMERIC(8,0)
			SET @YYYYMMDD = DATEPART(YEAR, @DT) * 10000 + DATEPART(MONTH, @DT) * 100 + DATEPART(DAY, @DT)
			RETURN @YYYYMMDD
		END
		GO
		
		SELECT HL.f_getYYYYMMDDfromDateTime ('2021-25-09 00:00:00') --anda
		SELECT HL.f_getYYYYMMDDfromDateTime ('2021-09-25 00:00:00') --no anda, pero...

		SELECT r.fechaHoraEncendida,
			   HL.f_getYYYYMMDDfromDateTime (r.fechaHoraEncendida) --sí anda cuando lo lee de un campo de la base
		FROM HL.registros r



		--FUNCIÓN HL.f_getHHMMfromDateTime
		--Dado una fecha en SMALLDATETIME, devuelve un NUMERIC(4,0) así: HHMM
		CREATE OR ALTER FUNCTION HL.f_getHHMMfromDateTime
			(@DT SMALLDATETIME) --en formato 'YY-DD-MM HH:MM:00', salvo que lo lea de un campo de la base
		RETURNS NUMERIC(4,0)
		AS BEGIN
			DECLARE @HHMM NUMERIC(4,0)
			SET @HHMM = DATEPART(HOUR, @DT) * 100 + DATEPART(MINUTE, @DT)
			RETURN @HHMM
		END
		GO



		--FUNCIÓN HL.f_getMinsON_formatoEntero
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoEntero
			(@FECHAini_R NUMERIC(8, 0),		--YYYYMMDD inicial del registro de la base de datos
			 @HORAini_R NUMERIC(4, 0),		--HHMM inicial del registro de la base de datos
			 @FECHAfin_R NUMERIC(8, 0),		--YYYYMMDD final del registro de la base de datos
			 @HORAfin_R NUMERIC(4, 0),		--HHMM final del registro de la base de datos
			 @FECHAini_S NUMERIC(8, 0),		--YYYYMMDD inicial seleccionado por el usuario
			 @HORAini_S NUMERIC(4, 0),		--HHMM inicial seleccionado por el usuario
			 @FECHAfin_S NUMERIC(8, 0),		--YYYYMMDD final seleccionado por el usuario
			 @HORAfin_S NUMERIC(4, 0))		--HHMM final seleccionado por el usuario
		RETURNS INT
		AS BEGIN
			DECLARE @desde SMALLDATETIME
			DECLARE @hasta SMALLDATETIME
			DECLARE @retorno INT
			
			IF (@FH_Rini > @FH_Sini) BEGIN
				SET @desde = @FH_Rini END
			ELSE BEGIN
				SET @desde = @FH_Sini END

			IF (@FH_Rfin < @FH_Sfin) BEGIN
				SET @hasta = @FH_Rfin END
			ELSE BEGIN
				SET @hasta = @FH_Sfin END

			IF (DATEDIFF(MINUTE, @desde, @hasta) >= 0) SET @retorno = DATEDIFF(MINUTE, @desde, @hasta)
			ELSE SET @retorno = 0
			
			RETURN @retorno
		END
		GO
		
		
		--FUNCIÓN HL.f_getMinsON_formatoFecha
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha
			(@FH_Rini SMALLDATETIME,
			 @FH_Rfin SMALLDATETIME,
			 @FH_Sini SMALLDATETIME,
			 @FH_Sfin SMALLDATETIME)
		RETURNS INT
		AS BEGIN
			DECLARE @desde SMALLDATETIME
			DECLARE @hasta SMALLDATETIME
			DECLARE @retorno INT
			
			IF (@FH_Rini >= @FH_Sini) BEGIN SET @desde = @FH_Rini END
			ELSE BEGIN SET @desde = @FH_Sini END

			IF (@FH_Rfin <= @FH_Sfin) BEGIN SET @hasta = @FH_Rfin END
			ELSE BEGIN SET @hasta = @FH_Sfin END

			IF (DATEDIFF(MINUTE, @desde, @hasta) >= 0) SET @retorno = DATEDIFF(MINUTE, @desde, @hasta)
			ELSE SET @retorno = 0
			
			RETURN @retorno

			--RETURN DATEDIFF(MINUTE, @desde, @hasta)
		END
		GO





		/*
		SELECT DATEPART(YEAR, '2021-09-30 23:45') * 10000 + DATEPART(MONTH, '2021-09-30 23:45') * 100 + DATEPART(DAY, '2021-09-30 23:45') AS 'YYYYMMDD',
	   DATEPART(HOUR, '2021-09-30 23:45') * 100 + DATEPART(MINUTE, '2021-09-30 23:45') AS 'HHMM',
	   '2021-09-30 23:45'
	   */

		
