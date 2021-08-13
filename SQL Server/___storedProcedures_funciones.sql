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



		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha_Nintervalos
			(@F_Sini DATE,
			 @F_Sfin DATE,
			 @H_Sini TIME,
			 @H_Sfin TIME,
			 @FH_Rini SMALLDATETIME,
			 @FH_Rfin SMALLDATETIME)
		RETURNS INT
		AS BEGIN
			DECLARE @acu INT			--acumulador de minutos
			DECLARE @F_CURRENT DATE		--fecha que va a ir aumentándose de a un día hasta alcanzar la fecha final
			DECLARE @DTi SMALLDATETIME	--DateTimeInicial registrado
			DECLARE @DTf SMALLDATETIME	--DateTimeFinal registrado
			SET @acu = 0
			SET @F_CURRENT = @F_Sini

			IF (NOT (@H_Sini < CAST('00:00' AS TIME) AND (CAST('00:00' AS TIME) < @H_Sfin))) BEGIN	--CASO FRANJA HORARIA DÍA PARCIAL
				WHILE (@F_CURRENT <= @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME)
					SET @acu = @acu + HL.f_getMinsON_formatoFecha(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			ELSE BEGIN																				--CASO FRANJA HORARIA TRASNOCHE
				WHILE (@F_CURRENT <= @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME)) AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME) --corregir esto, no es tan sencillo ese "+ 1"
					SET @acu = @acu + HL.f_getMinsON_formatoFecha(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			RETURN @acu
		END
		GO
			 


						-- prueba de esta función, para AZUL
						-- ANDA, CARAJO
						SELECT f0.MAQ_ID,
							   f0.MAQ_NUM,
							   f0.MAQ_NOM,
							   f0.MAQ_SEC,
							   SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-26', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON',
							   SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-26', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON'
                        FROM (
							  SELECT r.idMaquina AS 'MAQ_ID',
									 m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
									 m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
									 s.nombreSectorUSUARIO AS 'MAQ_SEC',
									 r.fechaHoraEncendida AS 'FH_ENC',
									 r.fechaHoraUltimoRegistroEncendida AS 'FH_URE'
							  FROM HL.sectores s
							  JOIN HL.maquinas m ON (s.idSector = m.idSector)
							  JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
							  ) AS f0
						GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
						HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) > 0
						ORDER BY f0.MAQ_SEC, f0.MAQ_NUM
						
						-- otra prueba de esta función, para AZUL
						-- ANDA, CARAJO
						SELECT f0.MAQ_ID,
							   f0.MAQ_NUM,
							   f0.MAQ_NOM,
							   f0.MAQ_SEC,
							   SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-27', '2021-08-28', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON',
							   SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-27', '2021-08-28', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON'
                        FROM (
							  SELECT r.idMaquina AS 'MAQ_ID',
									 m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
									 m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
									 s.nombreSectorUSUARIO AS 'MAQ_SEC',
									 r.fechaHoraEncendida AS 'FH_ENC',
									 r.fechaHoraUltimoRegistroEncendida AS 'FH_URE'
							  FROM HL.sectores s
							  JOIN HL.maquinas m ON (s.idSector = m.idSector)
							  JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
							  ) AS f0
						GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
						HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-27', '2021-08-28', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) > 0
						ORDER BY f0.MAQ_SEC, f0.MAQ_NUM
						



						SELECT f0.MAQ_ID,
							   f0.MAQ_NUM,
							   f0.MAQ_NOM,
							   f0.MAQ_SEC,
							   SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON',
							   SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON'
						FROM (
							  SELECT r.idMaquina AS 'MAQ_ID',
									 m.numeroMaquinaUSUARIO AS 'MAQ_NUM', 
									 m.nombreMaquinaUSUARIO AS 'MAQ_NOM', 
									 s.nombreSectorUSUARIO AS 'MAQ_SEC', 
									 r.fechaHoraEncendida AS 'FH_ENC', 
									 r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
							  FROM HL.sectores s 
							  JOIN HL.maquinas m ON (s.idSector = m.idSector) 
							  JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
							  WHERE (r.idMaquina IN (1, 18, 20))
							  ) AS f0 
						GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC 
						HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) > 0 
						ORDER BY f0.MAQ_SEC, f0.MAQ_NUM
						----------------
						--para llevar...
						SELECT f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC, SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON', SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON' FROM (SELECT r.idMaquina AS 'MAQ_ID', m.numeroMaquinaUSUARIO AS 'MAQ_NUM', m.nombreMaquinaUSUARIO AS 'MAQ_NOM', s.nombreSectorUSUARIO AS 'MAQ_SEC', r.fechaHoraEncendida AS 'FH_ENC', r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.idMaquina IN (1, 18, 20))) AS f0 GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) > 0 ORDER BY f0.MAQ_SEC, f0.MAQ_NUM
						----------------
						
						
						
						

















						
						-- casoUnicoIntervalo_mostrarCantidadDeHorasPorMaquina
						-- ANDA
						SELECT f0.MAQ_ID,
							   f0.MAQ_NUM,
							   f0.MAQ_NOM,
							   f0.MAQ_SEC,
							   SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-08 09:00', '2021-26-08 21:00')) AS 'MINS_ON',
							   SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-08 09:00', '2021-26-08 21:00')) / 60.0 AS 'HRS_ON'
                        FROM (
							  SELECT r.idMaquina AS 'MAQ_ID',
									 m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
									 m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
									 s.nombreSectorUSUARIO AS 'MAQ_SEC',
									 r.fechaHoraEncendida AS 'FH_ENC',
									 r.fechaHoraUltimoRegistroEncendida AS 'FH_URE'
							  FROM HL.sectores s
							  JOIN HL.maquinas m ON (s.idSector = m.idSector)
							  JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
							  ) AS f0
						GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
						HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-2-08 09:00', '2021-26-08 21:00')) > 0
						ORDER BY f0.MAQ_SEC, f0.MAQ_NUM












			 select DATEADD(DAY, 10, CAST('2021-23-08' AS SMALLDATETIME))



					IF (CAST('23:45' AS TIME) < CAST('00:00' AS TIME))
					BEGIN
						SELECT CAST('23:45' AS TIME)
					END
					ELSE
					BEGIN
						SELECT CAST('00:00' AS TIME)
					END

					IF (CAST('23:45' AS TIME) < '00:00')
					BEGIN
						SELECT CAST('23:45' AS TIME)
					END
					ELSE
					BEGIN
						SELECT '00:00'
					END





		/*
		SELECT DATEPART(YEAR, '2021-09-30 23:45') * 10000 + DATEPART(MONTH, '2021-09-30 23:45') * 100 + DATEPART(DAY, '2021-09-30 23:45') AS 'YYYYMMDD',
	   DATEPART(HOUR, '2021-09-30 23:45') * 100 + DATEPART(MINUTE, '2021-09-30 23:45') AS 'HHMM',
	   '2021-09-30 23:45'
	   */

		
