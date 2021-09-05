--FUNCIONES PARA CONTAR MINUTOS

-- LAS FECHAS QUE SE PASEN POR PARÁMETRO DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'.

		
		--FUNCIÓN HL.f_getMinsON_formatoFecha_1intervalo
		--Retorna la cantidad de minutos (un único intervalo horario) que una máquina está encendida
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha_1intervalo
			(@FH_Rini SMALLDATETIME,		-- DATETIME inicial registrado en la DB
			 @FH_Rfin SMALLDATETIME,		-- DATETIME final registrado en la DB
			 @FH_Sini SMALLDATETIME,		-- DATETIME inicial seleccionado por el usuario en la aplicación
			 @FH_Sfin SMALLDATETIME)		-- DATETIME final seleccionado por el usuario en la aplicación
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
		--Retorna la cantidad de minutos (para 2 o más intervalos horarios) que una máquina está encendida
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha_Nintervalos
			(@F_Sini DATE,					-- DATE inicial seleccionado por el usuario en la aplicación 
			 @F_Sfin DATE,					-- DATE final seleccionado por el usuario en la aplicación
			 @H_Sini TIME,					-- TIME inicial seleccionado por el usuario en la aplicación
			 @H_Sfin TIME,					-- TIME final seleccionado por el usuario en la aplicación
			 @FH_Rini SMALLDATETIME,		-- DATETIME inicial registrado en la DB
			 @FH_Rfin SMALLDATETIME)		-- DATETIME final registrado en la DB
		RETURNS INT
		AS BEGIN
			DECLARE @acu INT				--acumulador de minutos
			DECLARE @F_CURRENT DATE			--fecha que va a ir aumentándose de a un día hasta alcanzar la fecha final
			DECLARE @DTi SMALLDATETIME		--DateTimeInicial registrado
			DECLARE @DTf SMALLDATETIME		--DateTimeFinal registrado
			SET @acu = 0
			SET @F_CURRENT = @F_Sini

			IF (@H_Sfin < @H_Sini) BEGIN 
				-- Incluye/Toca medianoche
				WHILE (@F_CURRENT < @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME)) AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME) --corregir esto, no es tan sencillo ese "+ 1"
					SET @acu = @acu + HL.f_getMinsON_formatoFecha_1intervalo(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			ELSE BEGIN
				-- Día parcial = no incluye ni toca medianoche
				WHILE (@F_CURRENT <= @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME)
					SET @acu = @acu + HL.f_getMinsON_formatoFecha_1intervalo(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			RETURN @acu
		END
		GO
			 




			
		--FUNCIÓN HL.f_getMinsBetween_formatoFecha_1intervalo
		--Retorna la cantidad de minutos entre una FECHAyHORARIO y otra FECHAyHORARIO (un único intervalo horario) 
		CREATE OR ALTER FUNCTION HL.f_getMinsBetween_formatoFecha_1intervalo
			(@FH_S_ini SMALLDATETIME,		-- DATETIME inicial seleccionado por el usuario en la aplicación, en formato 'YYYY-DD-MM HH:MM:00'
			 @FH_S_fin SMALLDATETIME)		-- DATETIME final seleccionado por el usuario en la aplicación, en formato 'YYYY-DD-MM HH:MM:00'
		RETURNS INT
		AS BEGIN
			DECLARE @retorno INT			
			SET @retorno = DATEDIFF(MINUTE, @FH_S_ini, @FH_S_fin)		--El DATEDIFF cambia las fechas de formato automáticamente
			RETURN @retorno
		END
		GO

		
					/* EL TEMA DE LOS FORMATOS DE LAS FECHAS:
					SELECT DATEDIFF(MINUTE, '2021-08-28 21:00:00', '2021-08-29 06:00:00')								-- anda: formato correcto para DATEDIFF
					SELECT DATEDIFF(MINUTE, '2021-28-08 21:00:00', '2021-29-08 06:00:00')
		
					SELECT HL.f_getMinsBetween_formatoFecha_1intervalo ('2021-08-28 21:00:00', '2021-08-29 06:00:00')
					SELECT HL.f_getMinsBetween_formatoFecha_1intervalo ('2021-28-08 21:00:00', '2021-29-08 06:00:00')	-- anda: formato correcto para la función
					*/

														   
		--FUNCIÓN HL.f_getMinsBetween_formatoFecha_Nintervalos
		--Retorna la cantidad de minutos entre una FECHA y otra FECHA, dentro de las franjas horarias correspondientes (un único intervalo horario) 
		CREATE OR ALTER FUNCTION HL.f_getMinsBetween_formatoFecha_Nintervalos
			(@F_S_ini DATE,					-- DATE inicial seleccionado por el usuario en la aplicación 
			 @F_S_fin DATE,					-- DATE final seleccionado por el usuario en la aplicación
			 @H_S_ini TIME,					-- TIME inicial seleccionado por el usuario en la aplicación
			 @H_S_fin TIME)					-- TIME final seleccionado por el usuario en la aplicación
		RETURNS INT
		AS BEGIN
			DECLARE @mins_por_intervalo INT
			DECLARE @cant_intervalos INT
			DECLARE @minutos_totales INT
			IF (@H_S_fin < @H_S_ini) BEGIN		-- Incluye/Toca medianoche
				SET @mins_por_intervalo = (60 * 24) - ABS(DATEDIFF(MINUTE, '06:00:00', '21:00:00'))
				SET @cant_intervalos = DATEDIFF(DAY, @F_S_ini, @F_S_fin)
			END
			ELSE BEGIN							-- Día parcial = no incluye medianoche
				SET @mins_por_intervalo = DATEDIFF(MINUTE, @H_S_ini, @H_S_fin)
				SET @cant_intervalos = DATEDIFF(DAY, @F_S_ini, @F_S_fin) + 1
			END
			SET @minutos_totales = @mins_por_intervalo * @cant_intervalos
			RETURN @minutos_totales
		END
		GO


		SELECT HL.f_getMinsBetween_formatoFecha_Nintervalos ('2021-08-29', '2021-09-03', '06:00:00', '15:00:00')
		SELECT HL.f_getMinsBetween_formatoFecha_Nintervalos ('2021-08-29', '2021-09-03', '12:00:00', '21:00:00')
		SELECT HL.f_getMinsBetween_formatoFecha_Nintervalos ('2021-08-28', '2021-09-04', '21:00:00', '06:00:00') --
		SELECT HL.f_getMinsBetween_formatoFecha_Nintervalos ('2021-08-28', '2021-08-29', '21:00:00', '06:00:00')

