--Ejemplo STORED PROCEDURE HL.sp_1
	CREATE OR ALTER PROCEDURE HL.sp_1
	AS BEGIN
		SELECT * FROM HL.registros
	END
	GO

EXEC HL.sp_1
--DROP PROCEDURE HL.sp_1






CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_1intervalo
	@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
	@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
	@STR_LISTAidMaq NVARCHAR		-- string con la lista de idMaq - ejemplo: '0, 1, 2, 3'
AS BEGIN
	SELECT f0.MAQ_ID, 
		   f0.MAQ_NUM, 
		   f0.MAQ_NOM, 
		   f0.MAQ_SEC, 
		   SUM(HL.f_getMinsON_formatoFecha(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS_ON', 
		   SUM(HL.f_getMinsON_formatoFecha(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60.0 AS 'HRS_ON'
	FROM (
		  SELECT m.idMaquina AS 'MAQ_ID',
				 m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
				 m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
				 s.nombreSectorUSUARIO AS 'MAQ_SEC', 
				 r.fechaHoraEncendida AS 'FH_ENC', 
				 r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
		  FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
							 FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
		  --WHERE (m.idMaquina IN (STRING_LISTA_idMaquina))	--ACÁ ESTÁ EL PROBLEMA PARA LOS STORED PROCEDURES
		  WHERE CAST(NVARCHAR, m.idMaquina) IN @STR_LISTAidMaq
		  ) AS f0
	GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
	HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, @STR_FyH_INI, @STR_FyH_FIN)) > 0
	ORDER BY f0.MAQ_SEC, f0.MAQ_NUM
END
GO

EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00'


select *
from (EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00')



--Intento de solución del WHERE con el r.idMaquina ---> CAST(NVARCHAR, r.idMaquina)
SELECT 45 + 11

SELECT CAST(NVARCHAR, 45) + 11







HL.sp_mostrarTiemposPorMaquina_1intervalo
HL.sp_mostrarTiemposPorMaquina_Nintervalos

HL.sp_mostrarTiemposPorSector_1intervalo
HL.sp_mostrarTiemposPorSector_Nintervalos

HL.sp_mostrarTiemposTotales_1intervalo
HL.sp_mostrarTiemposTotales_Nintervalos








/*



--FUNCIONES PARA CONTAR MINUTOS

-- LAS FECHAS QUE SE PASEN POR PARÁMETRO DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'.

		
		--FUNCIÓN HL.f_getMinsON_formatoFecha
		--Retorna la cantidad de minutos (un único intervalo horario) que una máquina está encendida
		CREATE OR ALTER FUNCTION HL.f_getMinsON_formatoFecha
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
					SET @acu = @acu + HL.f_getMinsON_formatoFecha(@FH_Rini, @FH_Rfin, @DTi, @DTf)
					SET @F_CURRENT = DATEADD(DAY, 1, CAST(@F_CURRENT AS SMALLDATETIME))
				END
			END
			ELSE BEGIN
				-- Día parcial = no incluye ni toca medianoche
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
			 


			*/