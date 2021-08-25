--FUNCIONES PARA CONTAR MINUTOS

-- LAS FECHAS QUE SE PASEN POR PAR�METRO DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'.

		
		--FUNCI�N HL.f_getMinsON_formatoFecha
		--Retorna la cantidad de minutos (un �nico intervalo horario) que una m�quina est� encendida
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha
			(@FH_Rini SMALLDATETIME,		-- DATETIME inicial registrado en la DB
			 @FH_Rfin SMALLDATETIME,		-- DATETIME final registrado en la DB
			 @FH_Sini SMALLDATETIME,		-- DATETIME inicial seleccionado por el usuario en la aplicaci�n
			 @FH_Sfin SMALLDATETIME)		-- DATETIME final seleccionado por el usuario en la aplicaci�n
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


		--FUNCI�N HL.f_getMinsON_formatoFecha_Nintervalos
		--Retorna la cantidad de minutos (para 2 o m�s intervalos horarios) que una m�quina est� encendida
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha_Nintervalos
			(@F_Sini DATE,					-- DATE inicial seleccionado por el usuario en la aplicaci�n 
			 @F_Sfin DATE,					-- DATE final seleccionado por el usuario en la aplicaci�n
			 @H_Sini TIME,					-- TIME inicial seleccionado por el usuario en la aplicaci�n
			 @H_Sfin TIME,					-- TIME final seleccionado por el usuario en la aplicaci�n
			 @FH_Rini SMALLDATETIME,		-- DATETIME inicial registrado en la DB
			 @FH_Rfin SMALLDATETIME)		-- DATETIME final registrado en la DB
		RETURNS INT
		AS BEGIN
			DECLARE @acu INT				--acumulador de minutos
			DECLARE @F_CURRENT DATE			--fecha que va a ir aument�ndose de a un d�a hasta alcanzar la fecha final
			DECLARE @DTi SMALLDATETIME		--DateTimeInicial registrado
			DECLARE @DTf SMALLDATETIME		--DateTimeFinal registrado
			SET @acu = 0
			SET @F_CURRENT = @F_Sini

			IF (@H_Sfin < @H_Sini) BEGIN 
				-- Incluye/Toca medianoche
				WHILE (@F_CURRENT < @F_Sfin) BEGIN
					SET @DTi = CAST(@F_CURRENT AS SMALLDATETIME) + CAST(@H_Sini AS SMALLDATETIME)
					SET @DTf = CAST(DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME)) AS SMALLDATETIME) + CAST(@H_Sfin AS SMALLDATETIME) --corregir esto, no es tan sencillo ese "+ 1"
					SET @acu = @acu + HL.f_getMinsON_formatoFecha(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			ELSE BEGIN
				-- D�a parcial = no incluye ni toca medianoche
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
			 


			