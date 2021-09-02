--Ejemplo STORED PROCEDURE HL.sp_1
	CREATE OR ALTER PROCEDURE HL.sp_1
	AS BEGIN
		SELECT * FROM HL.registros
	END
	GO

EXEC HL.sp_1
--DROP PROCEDURE HL.sp_1


SELECT CAST (95.33333333 AS NUMERIC(7, 3))


-- UN ÚNICO INTERVALO · TIEMPOS POR MÁQUINA
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

		/* Ejemplos de uso:
				EXECUTE HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 0'
				EXECUTE HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q, 0'
				EXECUTE HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', ' 12, 13, 0'
		*/
			   


-- UN ÚNICO INTERVALO · TIEMPOS POR SECTOR
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
		
		/* Ejemplos de uso:
				EXECUTE HL.sp_mostrarTiemposPorSector_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 0'
				EXECUTE HL.sp_mostrarTiemposPorSector_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q, 0'
				EXECUTE HL.sp_mostrarTiemposPorSector_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', ' 12, 13, 0'
		*/
			   		 
					 

-- UN ÚNICO INTERVALO · TIEMPOS TOTALES
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
		/* Ejemplos de uso:
				EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 0'
				EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', 'm12q,   m13q, 0'
				EXECUTE HL.sp_mostrarTiemposTotales_1intervalo '2021-29-08 00:00:00', '2021-04-09 00:00:00', ' 12, 13, 0'
		*/


		

-- N INTERVALOS · TIEMPOS POR MÁQUINA
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
		/* Ejemplos de uso:
				EXECUTE HL.sp_mostrarTiemposPorMaquina_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 0'
				EXECUTE HL.sp_mostrarTiemposPorMaquina_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', 'm12q,   m13q, 0'
				EXECUTE HL.sp_mostrarTiemposPorMaquina_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', ' 12, 13, 0'
		*/


-- N INTERVALOS · TIEMPOS POR SECTOR
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
		/* Ejemplos de uso:
				EXECUTE HL.sp_mostrarTiemposPorSector_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 0'
				EXECUTE HL.sp_mostrarTiemposPorSector_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', 'm12q,   m13q, 0'
				EXECUTE HL.sp_mostrarTiemposPorSector_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', ' 12, 13, 0'
		*/


	

-- N INTERVALOS · TIEMPOS TOTALES
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
		/* Ejemplos de uso:
				EXECUTE HL.sp_mostrarTiemposTotales_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 0'
				EXECUTE HL.sp_mostrarTiemposTotales_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', 'm12q,   m13q, 0'
				EXECUTE HL.sp_mostrarTiemposTotales_Nintervalos '2021-08-29', '2021-09-04', '06:00:00', '15:00:00', ' 12, 13, 0'
		*/


