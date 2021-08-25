--FUNCIONES

-- LAS FECHAS QUE SE PASEN POR PARÁMETRO DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'.

		
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
		END
		GO


		--FUNCIÓN HL.f_getMinsON_formatoFecha_Nintervalos
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

			-- NUEVA PROPUESTA
			IF (@H_Sfin < @H_Sini) BEGIN 
				-- Incluye/Toca medianoche
				-- PROBABLEMENTE CORREGIDO
				WHILE (@F_CURRENT < @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME)) AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME) --corregir esto, no es tan sencillo ese "+ 1"
					SET @acu = @acu + HL.f_getMinsON_formatoFecha(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			ELSE BEGIN
				-- Día parcial = no incluye ni toca medianoche
				-- PROBABLEMENTE CORREGIDO
				WHILE (@F_CURRENT <= @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME)
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
						GO
						
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
						GO






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
						GO


						----------------
						--para llevar...
						SELECT f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC, SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON', SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON' FROM (SELECT r.idMaquina AS 'MAQ_ID', m.numeroMaquinaUSUARIO AS 'MAQ_NUM', m.nombreMaquinaUSUARIO AS 'MAQ_NOM', s.nombreSectorUSUARIO AS 'MAQ_SEC', r.fechaHoraEncendida AS 'FH_ENC', r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.idMaquina IN (1, 18, 20))) AS f0 GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos('2021-08-25', '2021-08-29', '09:00', '21:00', f0.FH_ENC, f0.FH_URE)) > 0 ORDER BY f0.MAQ_SEC, f0.MAQ_NUM GO
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
						GO
			