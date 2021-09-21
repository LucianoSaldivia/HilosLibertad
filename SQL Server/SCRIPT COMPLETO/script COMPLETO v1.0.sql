-- Se crea la BASE DE DATOS y se indica que se va a usar
	CREATE DATABASE DB_HILOS_LIBERTAD
	GO
	   	 
	USE DB_HILOS_LIBERTAD
	GO


-- Se crea el ESQUEMA sobre el cual trabajaremos
	CREATE SCHEMA HL
	GO





-- Se crean las TABLAS		
	CREATE TABLE HL.sectores(
		idSector NUMERIC(5,0) PRIMARY KEY, 
		nombreSectorUSUARIO NVARCHAR(255) NOT NULL
	)
	GO
		
	CREATE TABLE HL.maquinas(
		idMaquina NUMERIC(5,0) PRIMARY KEY, 
		idSector NUMERIC(5,0) REFERENCES HL.sectores,
		numeroMaquinaUSUARIO SMALLINT,
		nombreMaquinaUSUARIO NVARCHAR(255),
		descripcionMaquinaUSUARIO NVARCHAR(255)
	)
	GO

	CREATE TABLE HL.registros(
		idRegistro NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
		idMaquina NUMERIC(5,0) REFERENCES HL.maquinas,
		fechaHoraEncendida SMALLDATETIME NOT NULL,
		fechaHoraUltimoRegistroEncendida SMALLDATETIME NOT NULL,
		fueApagadaPorOperarioOPorFallaParticular BIT
	)
	GO

						SELECT * FROM HL.sectores
						SELECT * FROM HL.maquinas
						SELECT * FROM HL.registros
						/* 
						Para eliminar todas las tablas se debe respetar un orden (el cual es inverso al que fueron creadas):
								DROP TABLE HL.registros
								DROP TABLE HL.maquinas
								DROP TABLE HL.sectores
						*/
						/* 
						Para resetear el campo ID de una tabla HL.XXXXXXXXXXXXXX a 0, primero debe vaciarse y luego se resetea dicho campo autoincremental: 
								DELETE FROM HL.XXXXXXXXXXXXXX
								DBCC CHECKIDENT ('HL.XXXXXXXXXXXXXX', RESEED, 0)
						*/


-- Se insertan los valores iniciales en las tablas
	--INSERT INTO HL.sectores VALUES (idSector, nombreSectorUSUARIO)
	INSERT INTO HL.sectores VALUES (1, 'Telares')
	INSERT INTO HL.sectores VALUES (2, 'Cordoneras')
	INSERT INTO HL.sectores VALUES (3, 'Terminación')
	GO

	--INSERT INTO HL.maquinas VALUES (idMaquina, idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO)
	INSERT INTO HL.maquinas VALUES (1,	1,	1,	'COSMO 8 BOCAS',		'')
	INSERT INTO HL.maquinas VALUES (2,	1,	2,	'KYAN YHE 6/40',		'')
	INSERT INTO HL.maquinas VALUES (3,	1,	3,	'DKW 8/30',				'')
	INSERT INTO HL.maquinas VALUES (4,	1,	4,	'YITAI 8/55',			'')
	INSERT INTO HL.maquinas VALUES (5,	1,	5,	'KYAN YHE VIEJO 8/20',	'')
	INSERT INTO HL.maquinas VALUES (6,	1,	6,	'BONAS 2/60 (CEBRA)',	'')
	INSERT INTO HL.maquinas VALUES (7,	1,	7,	'BONAS 2/60  ',			'')
	INSERT INTO HL.maquinas VALUES (8,	1,	8,	'BONAS 2/25',			'')
	INSERT INTO HL.maquinas VALUES (9,	1,	9,	'BONAS 4/25',			'')
	INSERT INTO HL.maquinas VALUES (10,	1,	16,	'URDIDORA',				'')

	INSERT INTO HL.maquinas VALUES (11,	2,	10,	'KYAN YHE INDESMAYABLE',		'')
	INSERT INTO HL.maquinas VALUES (12,	2,	11,	'KYAN YHE INDESMAYABLE',		'')
	INSERT INTO HL.maquinas VALUES (13,	2,	12,	'KYAN YHE INDESMAYABLE',		'')
	INSERT INTO HL.maquinas VALUES (14,	2,	13,	'TEXMAQ INDESMAYABLE',			'')
	INSERT INTO HL.maquinas VALUES (15,	2,	14,	'TEXMAQ INDESMAYABLE',			'')
	INSERT INTO HL.maquinas VALUES (16,	2,	15,	'RIUS 2 BOCAS INDEMAYABLES',	'')
	INSERT INTO HL.maquinas VALUES (17,	2,	17,	'TUBULAR AZUL 10 BOCAS',		'')
	INSERT INTO HL.maquinas VALUES (18,	2,	18,	'TUBULAR VIEJA 10 BOCAS',		'')
	INSERT INTO HL.maquinas VALUES (19,	2,	22,	'TUBULAR NUEVA 14 BOCAS',		'Número asignado: 22')
	
	INSERT INTO HL.maquinas VALUES (20,	3,	19,	'PUNTERA AZUL',				'')
	INSERT INTO HL.maquinas VALUES (21,	3,	20,	'PUNTERA VERDE',			'')
	INSERT INTO HL.maquinas VALUES (22,	3,	21,	'PUNTERA AZUL KYAN YHE',	'')
	GO

						SELECT * FROM HL.maquinas





-- Se crean los STORED PROCEDURES para permitir insertar/actualizar/terminar sesiones
	CREATE OR ALTER PROCEDURE HL.sp_insertarSesion
		@ID_MAQ NUMERIC(5,0),
		@FH_ENC SMALLDATETIME
	AS BEGIN
		SET DATEFORMAT YMD
		INSERT INTO HL.registros (idMaquina,	fechaHoraEncendida,	fechaHoraUltimoRegistroEncendida,	fueApagadaPorOperarioOPorFallaParticular)
							VALUES (@ID_MAQ,		@FH_ENC,			@FH_ENC,							0)
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_actualizarSesion
		@ID_MAQ NUMERIC(5, 0),
		@FH_URE SMALLDATETIME
	AS BEGIN
		SET DATEFORMAT YMD
		UPDATE HL.registros
			SET fechaHoraUltimoRegistroEncendida = @FH_URE
			WHERE idRegistro = (SELECT TOP 1 idRegistro
								FROM HL.registros
								WHERE idMaquina = @ID_MAQ
								ORDER BY fechaHoraUltimoRegistroEncendida DESC, idRegistro DESC)
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_terminarSesion
		@ID_MAQ NUMERIC(5, 0),
		@FH_URE SMALLDATETIME
	AS BEGIN
		SET DATEFORMAT YMD
		UPDATE HL.registros
			SET fechaHoraUltimoRegistroEncendida = @FH_URE,
				fueApagadaPorOperarioOPorFallaParticular = 1
			WHERE idRegistro = (SELECT TOP 1 idRegistro
								FROM HL.registros
								WHERE idMaquina = @ID_MAQ
								ORDER BY fechaHoraUltimoRegistroEncendida DESC, idRegistro DESC)
	END
	GO





-- Se crean las FUNCIONES
-- LAS FECHAS QUE SE PASEN POR PARÁMETRO DEBEN TENER EL SIGUIENTE FORMATO: 'YY-DD-MM HH:MM:SS'.
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




-- Se crean los STORED PROCEDURES para mostrar los tiempos 
	CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_1intervalo
		@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
		@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
		@STR_NUMERO_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_SECTOR VARCHAR(MAX)
	AS BEGIN
		SELECT f0.MAQ_NUM AS '#', 
				f0.MAQ_NOM AS 'MÁQUINA', 
				f0.MAQ_SEC AS 'SECTOR', 
				--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINUTOS ENCENDIDA'
				CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60,	-- horas (COCIENTE)
						' h  ',
						SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60,	-- minutos (RESTO)
						' min') AS 'TIEMPO ENCENDIDA',
				--CONCAT(HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) / 60, ' h  ', HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) % 60, ' min') AS 'TIEMPO TOTAL',
				--CONCAT(CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)), ' %') AS '% ENCENDIDA',
				CAST(100 AS NUMERIC(7, 3)) - CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA'
				--100 - CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA',
				--CONCAT(100 - CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)), ' %') AS '% APAGADA'
				--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS_ON', 
				--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60.0 AS 'HRS_ON'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
						m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
						m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
						s.nombreSectorUSUARIO AS 'MAQ_SEC', 
						r.fechaHoraEncendida AS 'FH_ENC', 
						r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
				FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
									FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
				--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q'
				--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
				WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
				AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
				AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
				) AS f0
		GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
		ORDER BY f0.MAQ_NUM
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorSector_1intervalo
		@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
		@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
		@STR_NUMERO_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_SECTOR VARCHAR(MAX)
	AS BEGIN
		SELECT f0.MAQ_SEC AS 'SECTOR', 
				--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINUTOS ENCENDIDO', 
				CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60,
						' h  ',
						SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60,
						' min ') AS 'TIEMPO ENCENDIDO'
				--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60.0 AS 'HRS_ON'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
						m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
						m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
						s.nombreSectorUSUARIO AS 'MAQ_SEC', 
						r.fechaHoraEncendida AS 'FH_ENC', 
						r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
				FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
									FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
				--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
				WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
				AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
				AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
				) AS f0
		GROUP BY f0.MAQ_SEC
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposTotales_1intervalo
		@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
		@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
		@STR_NUMERO_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_SECTOR VARCHAR(MAX)
	AS BEGIN
		SELECT --SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINUTOS ENCENDIDAS', 
				CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60,
						' h  ',
						SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60,
						' min ') AS 'TIEMPO ENCENDIDAS'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
						m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
						m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
						s.nombreSectorUSUARIO AS 'MAQ_SEC', 
						r.fechaHoraEncendida AS 'FH_ENC', 
						r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
				FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
									FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
				--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q'
				--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
				WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
				AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
				AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
				) AS f0
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_Nintervalos
		@STR_F_INI DATE,			-- string de FECHA inicial en formato 'YYYY-DD-MM'
		@STR_F_FIN DATE,			-- string de FECHA final en formato 'YYYY-DD-MM'
		@STR_H_INI TIME,			-- string de HORARIO inicial en formato 'HH:MM:00'
		@STR_H_FIN TIME,			-- string de HORARIO final en formato 'HH:MM:00'
		@STR_NUMERO_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_SECTOR VARCHAR(MAX)
	AS BEGIN
		SELECT f0.MAQ_NUM AS '#', 
				f0.MAQ_NOM AS 'MÁQUINA', 
				f0.MAQ_SEC AS 'SECTOR', 
				--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINUTOS ENCENDIDA',
				CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60,	-- horas (COCIENTE)
						' h  ',
						SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60,	-- minutos (RESTO)
						' min') AS 'TIEMPO ENCENDIDA',
				--CONCAT(HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) / 60, ' h  ', HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) % 60,  ' min') AS 'TIEMPO TOTAL',
				--CONCAT(100 - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)), ' %') AS '% ENCENDIDA',
				CAST(100 AS NUMERIC(7, 3)) - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA'
				--100 - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA',
				--CONCAT(CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)), ' %') AS '% APAGADA'
				--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS_ON', 
				--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60.0 AS 'HRS_ON'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
						m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
						m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
						s.nombreSectorUSUARIO AS 'MAQ_SEC', 
						r.fechaHoraEncendida AS 'FH_ENC', 
						r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
				FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
									FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
				--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q'
				--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
				WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
				AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
				AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
				) AS f0
		GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
		ORDER BY f0.MAQ_NUM
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorSector_Nintervalos
		@STR_F_INI DATE,			-- string de FECHA inicial en formato 'YYYY-DD-MM'
		@STR_F_FIN DATE,			-- string de FECHA final en formato 'YYYY-DD-MM'
		@STR_H_INI TIME,			-- string de HORARIO inicial en formato 'HH:MM:00'
		@STR_H_FIN TIME,			-- string de HORARIO final en formato 'HH:MM:00'
		@STR_NUMERO_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_SECTOR VARCHAR(MAX)
	AS BEGIN
		SELECT f0.MAQ_SEC AS 'SECTOR', 
				--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINUTOS ENCENDIDO', 
				CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60,
						' h  ',
						SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60,
						' min ') AS 'TIEMPO ENCENDIDO'
				--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60.0 AS 'HRS_ON'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
						m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
						m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
						s.nombreSectorUSUARIO AS 'MAQ_SEC', 
						r.fechaHoraEncendida AS 'FH_ENC', 
						r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
				FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
									FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
				--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q'
				--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
				WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
				AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
				AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
				) AS f0
		GROUP BY f0.MAQ_SEC
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposTotales_Nintervalos
		@STR_F_INI DATE,			-- string de FECHA inicial en formato 'YYYY-DD-MM'
		@STR_F_FIN DATE,			-- string de FECHA final en formato 'YYYY-DD-MM'
		@STR_H_INI TIME,			-- string de HORARIO inicial en formato 'HH:MM:00'
		@STR_H_FIN TIME,			-- string de HORARIO final en formato 'HH:MM:00'
		@STR_NUMERO_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
		@STR_NOMBRE_SECTOR VARCHAR(MAX)
	AS BEGIN
		SELECT --SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINUTOS ENCENDIDAS', 
				CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60,
						' h  ',
						SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60,
						' min ') AS 'TIEMPO ENCENDIDAS'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
						m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
						m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
						s.nombreSectorUSUARIO AS 'MAQ_SEC', 
						r.fechaHoraEncendida AS 'FH_ENC', 
						r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
				FROM HL.sectores s FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
									FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
				--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q'
				--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
				WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
				AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
				AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
				) AS f0
	END
	GO






-- Se crean los STORED PROCEDURES para llenar los DataGridView/ComboBox/TextBox de los sectores
	CREATE OR ALTER PROCEDURE HL.sp_llenarDGVsectores
	AS BEGIN
		SELECT s.nombreSectorUSUARIO AS 'SECTOR'
		FROM HL.sectores s 
		ORDER BY s.idSector
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_llenarCMBsectores
	AS BEGIN
		SELECT s.idSector, 
				s.nombreSectorUSUARIO
		FROM HL.sectores s
		ORDER BY s.idSector
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_cargarTXTsectores
		@ID_SECTOR NUMERIC
	AS BEGIN
		SELECT s.idSector,
				s.nombreSectorUSUARIO
		FROM HL.sectores s 
		WHERE s.idSector = @ID_SECTOR
	END
	GO

-- Se crean los STORED PROCEDURES para llenar los DataGridView/ComboBox/TextBox de las máquinas
	CREATE OR ALTER PROCEDURE HL.sp_llenarDGVmaquinas
	AS BEGIN
		SELECT m.idMaquina AS '#',
				m.numeroMaquinaUSUARIO AS 'NÚMERO',
				m.nombreMaquinaUSUARIO AS 'MÁQUINA',
				m.descripcionMaquinaUSUARIO AS 'DESCRIPCIÓN'
		FROM HL.maquinas m
		ORDER BY m.idMaquina
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_llenarCMBmaquinas
	AS BEGIN
		SELECT m.idMaquina,
				m.numeroMaquinaUSUARIO,
				m.nombreMaquinaUSUARIO,
				m.descripcionMaquinaUSUARIO
		FROM HL.maquinas m
		ORDER BY m.idMaquina
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_cargarTXTmaquinas
		@ID_MAQUINA NUMERIC
	AS BEGIN
		SELECT m.idMaquina,
				m.numeroMaquinaUSUARIO, 
				m.nombreMaquinaUSUARIO, 
				m.descripcionMaquinaUSUARIO 
		FROM HL.maquinas m 
		WHERE m.idMaquina = @ID_MAQUINA
	END
	GO





-- Se crean los STORED PROCEDURES para actualizar sectores y máquinas
	CREATE OR ALTER PROCEDURE HL.sp_actualizarSector
		@ID_SECTOR NUMERIC(5, 0),
		@NOMBRE_SECTOR NVARCHAR(255)
	AS BEGIN
		UPDATE HL.sectores
			SET nombreSectorUSUARIO = @NOMBRE_SECTOR
			WHERE idSector = @ID_SECTOR
	END
	GO

	CREATE OR ALTER PROCEDURE HL.sp_actualizarMaquina
		@ID_MAQUINA NUMERIC(5, 0),
		@NUMERO_MAQUINA SMALLINT,
		@NOMBRE_MAQUINA NVARCHAR(255),
		@DESCRIPCION_MAQUINA NVARCHAR(255)
	AS BEGIN
		UPDATE HL.maquinas
			SET numeroMaquinaUSUARIO = @NUMERO_MAQUINA,
				nombreMaquinaUSUARIO = @NOMBRE_MAQUINA,
				descripcionMaquinaUSUARIO = @DESCRIPCION_MAQUINA
			WHERE idMaquina = @ID_MAQUINA
	END
	GO





	-- Se crea la VISTA
	CREATE OR ALTER VIEW HL.v_registrador AS (
		SELECT r.idRegistro AS 'idReg',
				r.idMaquina AS 'idMaq',
				r.fechaHoraEncendida AS 'INIT_DT',
				r.fechaHoraUltimoRegistroEncendida AS 'LAST_DT',
				r.fueApagadaPorOperarioOPorFallaParticular AS 'TRND_OFF',
				DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) AS 'MINS_DIFF'
		FROM HL.registros r
	)
	GO

						SELECT * FROM HL.v_registrador
						/*
						AL ELIMINAR LA VISTA, TAMBIÉN SE ELIMINAN LOS DATOS ASOCIADOS A LA TABLA HL.registros --> DELETE HL.v_registrador 
						PARA BORRAR LA VISTA:
						DROP VIEW HL.v_registrador
						*/
