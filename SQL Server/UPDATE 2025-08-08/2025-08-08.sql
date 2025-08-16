/*
TABLA maquinas:
	- Se agrega una nueva columna "metrosPorMinutoProducidosUSUARIO" de tipo NUMERIC(5,0): 5 d�gitos en total - 0 d�gitos parte mantisa (= 5 d�gitos parte entera)
*/
ALTER TABLE HL.maquinas
	ADD metrosPorMinutoProducidosUSUARIO NUMERIC(5,0)
GO


/*
TABLA maquinas:
	- A todas las m�quinas se le actualiza el campo metrosPorMinutoProducidosUSUARIO al valor 1.
	- Se eligi� el valor "1" de manera arbitraria. El usuario luego actualizar� con un valor acorde.
	- Dado el tipo de dato NUMERIC(5,2), el n�mero quedar� como "1.00".
*/
UPDATE HL.maquinas
	SET metrosPorMinutoProducidosUSUARIO = 1
GO



/*
(1) En los 6 STORED PROCEDURES (3 dataGridViews * 2 tipos de intevalos (1 y N) = 6 casos, 1 SP por caso):
	- Se cambia la columna de "<hh> h <mm> min" por "<hh>:<mm>". Ahora, en lugar de mostrarse "20h 45min" se muestra "20:45".
(2) En los 2 STORED PROCEDURES correspondientes a las m�quinas:
	- Ahora devuelve una columna m�s: la cantidad de metros producidos (es el producto entre los minutos encendida y los metros producidos) en el intervalo seleccionado.
*/

-- SP 1/6 � Tiempos por M�quina � 1 intervalo
CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_1intervalo
	@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
	@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT	f0.MAQ_NUM AS '#', 
			f0.MAQ_NOM AS 'M�QUINA', 
			f0.MAQ_SEC AS 'SECTOR', 
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60 + ':' + SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60,
			CAST(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]', --NUEVO
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, ' min') AS 'TIEMPO ENC.', --EL DE SIEMPRE --horas (COCIENTE):minutos(RESTO)
			--CONCAT(HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) / 60, ' h  ', HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) % 60, ' min') AS 'TIEMPO TOTAL',
			CONCAT(CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)), ' %') AS '% ENC.',
			SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * f0.MAQ_MPM AS 'METROS FABRICADOS'
			--CAST(100 AS NUMERIC(7, 3)) - CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA'
			--100 - CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA',
			--CONCAT(100 - CAST((SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 /  HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN)) AS NUMERIC(7, 3)), ' %') AS '% APAGADA'
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS_ON', 
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60.0 AS 'HRS_ON'
	FROM (
			SELECT	m.idMaquina AS 'MAQ_ID',
					m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
					m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
					m.metrosPorMinutoProducidosUSUARIO AS 'MAQ_MPM',
					s.nombreSectorUSUARIO AS 'MAQ_SEC', 
					r.fechaHoraEncendida AS 'FH_ENC', 
					r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
			FROM HL.sectores s	FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
								FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
			--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-08-29 00:00:00', '2021-09-04 00:00:00', 'm12q,   m13q'
			--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
			WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
			AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
			AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
			) AS f0
	GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_MPM, f0.MAQ_SEC
	ORDER BY f0.MAQ_NUM
END
GO

-- SP 2/6 � Tiempos por M�quina � N intervalos
CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_Nintervalos
	@STR_F_INI DATE,			-- string de FECHA inicial en formato 'YYYY-DD-MM'
	@STR_F_FIN DATE,			-- string de FECHA final en formato 'YYYY-DD-MM'
	@STR_H_INI TIME,			-- string de HORARIO inicial en formato 'HH:MM:00'
	@STR_H_FIN TIME,			-- string de HORARIO final en formato 'HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT	f0.MAQ_NUM AS '#', 
			f0.MAQ_NOM AS 'M�QUINA', 
			f0.MAQ_SEC AS 'SECTOR', 
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 + ':' + SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60 AS 'MM:DD ENC.',
			CAST(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]', --NUEVO
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, ' min') AS 'TIEMPO ENC.', --EL DE SIEMPRE-- horas (COCIENTE):minutos(RESTO)
			--CONCAT(HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) / 60, ' h  ', HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) % 60,  ' min') AS 'TIEMPO TOTAL',
			CONCAT(100 - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)), ' %') AS '% ENC.',
			SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * f0.MAQ_MPM AS 'METROS FABRICADOS'
			--CAST(100 AS NUMERIC(7, 3)) - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA'
			--100 - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)) AS '% APAGADA',
			--CONCAT(CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)), ' %') AS '% APAGADA'
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS_ON', 
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60.0 AS 'HRS_ON'
	FROM (
			SELECT	m.idMaquina AS 'MAQ_ID',
					m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
					m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
					m.metrosPorMinutoProducidosUSUARIO AS 'MAQ_MPM',
					s.nombreSectorUSUARIO AS 'MAQ_SEC', 
					r.fechaHoraEncendida AS 'FH_ENC', 
					r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' 
			FROM HL.sectores s	FULL JOIN HL.maquinas m ON (s.idSector = m.idSector) 
								FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina) 
			--WHERE @STR_LISTAidMaq LIKE CONCAT('%m', m.idMaquina, 'q%') --EXEC HL.sp_mostrarTiemposPorMaquina_1intervalo '2021-08-29 00:00:00', '2021-09-04 00:00:00', 'm12q,   m13q'
			--WHERE @STR_LISTAidMaq LIKE CONCAT('% ', m.idMaquina, ',%')
			WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
			AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
			AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
			) AS f0
	GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_MPM, f0.MAQ_SEC
	ORDER BY f0.MAQ_NUM
END
GO

-- SP 3/6 � Tiempos por Sector � 1 intervalo
CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorSector_1intervalo
	@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
	@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT f0.MAQ_SEC AS 'SECTOR', 
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			CAST(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]' --NUEVO
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, ' min ') AS 'TIEMPO ENC.' --EL DE SIEMPRE--
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

-- SP 4/6 � Tiempos por Sector � N intervalos
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
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			CAST(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]' --NUEVO
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, ' min ') AS 'TIEMPO ENC.' --EL DE SIEMPRE--
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

-- SP 5/6 � Tiempos Totales � 1 intervalo
CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposTotales_1intervalo
	@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
	@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT --SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			CAST(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]' --NUEVO
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, ' min ') AS 'TIEMPO ENC.' --EL DE SIEMPRE
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

-- SP 6/6 � Tiempos Totales � N intervalos
CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposTotales_Nintervalos
	@STR_F_INI DATE,			-- string de FECHA inicial en formato 'YYYY-DD-MM'
	@STR_F_FIN DATE,			-- string de FECHA final en formato 'YYYY-DD-MM'
	@STR_H_INI TIME,			-- string de HORARIO inicial en formato 'HH:MM:00'
	@STR_H_FIN TIME,			-- string de HORARIO final en formato 'HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT --SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			CAST(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]' --NUEVO
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, ' min ') AS 'TIEMPO ENC.' --EL DE SIEMPRE
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



/*
Se alteran los STORED PROCEDURES para considerar los metros por minuto producidos por cada m�quina
*/
--1/4
CREATE OR ALTER PROCEDURE HL.sp_llenarDGVmaquinas
AS BEGIN
	SELECT m.idMaquina AS '#',
			m.numeroMaquinaUSUARIO AS 'N�MERO',
			m.nombreMaquinaUSUARIO AS 'M�QUINA',
			m.metrosPorMinutoProducidosUSUARIO AS 'METROS POR MINUTO',	-- LO NUEVO
			m.descripcionMaquinaUSUARIO AS 'DESCRIPCI�N'
	FROM HL.maquinas m
	ORDER BY m.idMaquina
END
GO

--2/4
CREATE OR ALTER PROCEDURE HL.sp_llenarCMBmaquinas
AS BEGIN
	SELECT m.idMaquina,
			m.numeroMaquinaUSUARIO,
			m.nombreMaquinaUSUARIO,
			m.metrosPorMinutoProducidosUSUARIO,	-- LO NUEVO
			m.descripcionMaquinaUSUARIO
	FROM HL.maquinas m
	ORDER BY m.idMaquina
END
GO

--3/4
CREATE OR ALTER PROCEDURE HL.sp_cargarTXTmaquinas
	@ID_MAQUINA NUMERIC
AS BEGIN
	SELECT m.idMaquina,
			m.numeroMaquinaUSUARIO, 
			m.nombreMaquinaUSUARIO, 
			m.metrosPorMinutoProducidosUSUARIO,	-- LO NUEVO
			m.descripcionMaquinaUSUARIO 
	FROM HL.maquinas m 
	WHERE m.idMaquina = @ID_MAQUINA
END
GO

--4/4
CREATE OR ALTER PROCEDURE HL.sp_actualizarMaquina
	@ID_MAQUINA NUMERIC(5, 0),
	@NUMERO_MAQUINA SMALLINT,
	@NOMBRE_MAQUINA NVARCHAR(255),
	@METROSPRODUCIDOS_MAQUINA NUMERIC(5, 2),
	@DESCRIPCION_MAQUINA NVARCHAR(255)
AS BEGIN
	UPDATE HL.maquinas
		SET numeroMaquinaUSUARIO = @NUMERO_MAQUINA,
			nombreMaquinaUSUARIO = @NOMBRE_MAQUINA,
			metrosPorMinutoProducidosUSUARIO = @METROSPRODUCIDOS_MAQUINA,
			descripcionMaquinaUSUARIO = @DESCRIPCION_MAQUINA
		WHERE idMaquina = @ID_MAQUINA
END
GO



/*
*/
CREATE OR ALTER PROCEDURE HL.sp_cargarTXTmaquinas
	@ID_MAQUINA NUMERIC
AS BEGIN
	SELECT m.idMaquina,
			m.numeroMaquinaUSUARIO, 
			m.nombreMaquinaUSUARIO, 
			m.metrosPorMinutoProducidosUSUARIO,
			m.descripcionMaquinaUSUARIO,
			s.nombreSectorUSUARIO	
	FROM HL.maquinas m JOIN HL.sectores s ON (m.idSector = s.idSector)
	WHERE m.idMaquina = @ID_MAQUINA
END
GO




/*
Se actualiza el STORED PROCEDURE para que traiga una columna nueva: el SECTOR asociado a la m�quina correspondiente
*/
CREATE OR ALTER PROCEDURE HL.sp_llenarDGVmaquinas
AS BEGIN
		SELECT m.idMaquina AS '#',
				m.numeroMaquinaUSUARIO AS 'N�MERO',
				m.nombreMaquinaUSUARIO AS 'M�QUINA',
				m.metrosPorMinutoProducidosUSUARIO AS 'METROS POR MINUTO',
				m.descripcionMaquinaUSUARIO AS 'DESCRIPCI�N',
				s.nombreSectorUSUARIO AS 'SECTOR'	-- LO NUEVO
		FROM HL.maquinas m JOIN HL.sectores s ON (m.idSector = s.idSector)
		ORDER BY m.idMaquina
END
GO




/*
Se actualiza el STORED PROCEDURE para que se guarde tambi�n el cambio de sector.
*/
CREATE OR ALTER PROCEDURE HL.sp_actualizarMaquina
	@ID_MAQUINA NUMERIC(5, 0),
	@NUMERO_MAQUINA SMALLINT,
	@NOMBRE_MAQUINA NVARCHAR(255),
	@METROSPRODUCIDOS_MAQUINA NUMERIC(5, 2),
	@DESCRIPCION_MAQUINA NVARCHAR(255),
	@SECTOR NVARCHAR(255)
AS BEGIN
	UPDATE HL.maquinas
		SET numeroMaquinaUSUARIO = @NUMERO_MAQUINA,
			nombreMaquinaUSUARIO = @NOMBRE_MAQUINA,
			metrosPorMinutoProducidosUSUARIO = @METROSPRODUCIDOS_MAQUINA,
			descripcionMaquinaUSUARIO = @DESCRIPCION_MAQUINA,
			idSector = (
						SELECT s.idSector
						FROM HL.sectores s
						WHERE s.nombreSectorUSUARIO = @SECTOR)
		WHERE idMaquina = @ID_MAQUINA
END
GO


/*

*/
-- SP Tiempos por Sector � 1 intervalo
CREATE OR ALTER PROCEDURE HL.sp_mostrarTiemposPorSector_1intervalo
	@STR_FyH_INI DATETIME,			-- string de FECHAyHORARIO inicial en formato 'YYYY-DD-MM HH:MM:00'
	@STR_FyH_FIN DATETIME,			-- string de FECHAyHORARIO final en formato 'YYYY-DD-MM HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT f0.MAQ_SEC AS 'SECTOR', 
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			CAST(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]',
			--SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) AS 'MINS. ENC.', --nuevo, prueba de minutos enc.
			--(HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) * (SELECT COUNT(*) FROM HL.maquinas m JOIN HL.sectores s ON m.idSector = s.idSector WHERE s.nombreSectorUSUARIO = f0.MAQ_SEC GROUP BY s.nombreSectorUSUARIO)) AS 'MINS. TOT', --cant. minutos de todas las m�quinas del sector
			CONCAT( CAST(( SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) * 100.00 / (HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) * (SELECT COUNT(*) FROM HL.maquinas m JOIN HL.sectores s ON m.idSector = s.idSector WHERE s.nombreSectorUSUARIO = f0.MAQ_SEC GROUP BY s.nombreSectorUSUARIO)) ) AS NUMERIC(7,3)) , ' %') AS '% ENC.'
			--HL.f_getMinsBetween_formatoFecha_1intervalo(@STR_FyH_INI, @STR_FyH_FIN) AS 'MINS. TOT. 1maq' --cant. minutos como si el sector tuviera s�lo 1 m�quina
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_1intervalo(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), @STR_FyH_INI, @STR_FyH_FIN)) % 60, ' min ') AS 'TIEMPO ENC.' --EL DE SIEMPRE--
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

-- SP Tiempos por Sector � N intervalos
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
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS. ENC.', --NUEVO, PRUEBAS
			CAST(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]',
			--SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) AS 'MINS. ENC.', --nuevo, prueba de minutos enc.
			--(HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) * (SELECT COUNT(*) FROM HL.maquinas m JOIN HL.sectores s ON m.idSector = s.idSector WHERE s.nombreSectorUSUARIO = f0.MAQ_SEC GROUP BY s.nombreSectorUSUARIO)) AS 'MINS. TOT.', --cant. minutos de todas las m�quinas del sector
			CONCAT( CAST(( SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 / (HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) * (SELECT COUNT(*) FROM HL.maquinas m JOIN HL.sectores s ON m.idSector = s.idSector WHERE s.nombreSectorUSUARIO = f0.MAQ_SEC GROUP BY s.nombreSectorUSUARIO)) ) AS NUMERIC(7,3)), ' %') AS '% ENC.'
			--HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN) AS 'MINS. TOT. 1maq' --cant. minutos como si el sector tuviera s�lo 1 m�quina
			--CONCAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60, ' h  ', SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, ' min ') AS 'TIEMPO ENC.' --EL DE SIEMPRE--
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


--Dado el nombre del sector, trae la cantidad de m�quinas en ese sector
SELECT COUNT(*) AS 'CANT_MAQxSECTOR'
FROM HL.maquinas m JOIN HL.sectores s ON m.idSector = s.idSector
WHERE s.nombreSectorUSUARIO = 'Cordoneras'
GROUP BY s.nombreSectorUSUARIO



/*
Se agrega AUDITOR�A:
	(1) Se crean dos tablas adicionales: HL.sectores_au y HL.maquinas_au.		
	(2) Se crean 2 (uno para cada tabla) triggers para que, ante un UPDATE:
		- primero se registren los valores viejos.
		- luego se registren los valores nuevos.
*/

--1/2: Se crean las tablas adicionales
CREATE TABLE HL.sectores_au(
	id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
	idSector NUMERIC(5,0) REFERENCES HL.sectores,
	fechaHora SMALLDATETIME NOT NULL,
	tipoDeInformacion VARCHAR(3) NOT NULL, --'OLD' o 'NEW'
	nombreSectorUSUARIO NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE HL.maquinas_au(
	id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
	idMaquina NUMERIC(5,0) REFERENCES HL.maquinas,
	fechaHora SMALLDATETIME NOT NULL,
	tipoDeInformacion VARCHAR(3) NOT NULL, --'OLD' o 'NEW'
	idSector NUMERIC(5,0) REFERENCES HL.sectores,
	numeroMaquinaUSUARIO SMALLINT,
	nombreMaquinaUSUARIO NVARCHAR(255),
	descripcionMaquinaUSUARIO NVARCHAR(255),
	metrosPorMinutoProducidosUSUARIO NUMERIC(5,0)
)
GO

--2/2: Se crean los triggers correspondientes
CREATE TRIGGER HL.t_au_sectores ON HL.sectores
AFTER UPDATE
AS
BEGIN
	DECLARE @idSector NUMERIC(5,0),
			@nombreSectorUSUARIO_OLD NVARCHAR(255),
			@nombreSectorUSUARIO_NEW NVARCHAR(255)
	DECLARE cur CURSOR FOR
		SELECT d.idSector, d.nombreSectorUSUARIO, i.nombreSectorUSUARIO
		FROM deleted d JOIN inserted i ON (d.idSector = i.idSector)
	OPEN cur
	FETCH NEXT FROM cur INTO @idSector, @nombreSectorUSUARIO_OLD, @nombreSectorUSUARIO_NEW
	WHILE (@@FETCH_STATUS = 0) BEGIN
		INSERT INTO HL.sectores_au (idSector, fechaHora, tipoDeInformacion, nombreSectorUSUARIO) VALUES (@idSector, GETDATE(), 'OLD', @nombreSectorUSUARIO_OLD)
		INSERT INTO HL.sectores_au (idSector, fechaHora, tipoDeInformacion, nombreSectorUSUARIO) VALUES (@idSector, GETDATE(), 'NEW', @nombreSectorUSUARIO_NEW)
		FETCH NEXT FROM cur INTO @idSector, @nombreSectorUSUARIO_OLD, @nombreSectorUSUARIO_NEW
	END
	CLOSE cur
	DEALLOCATE cur
END
GO
				--pruebas del trigger
				SELECT * FROM HL.sectores
				SELECT * FROM HL.sectores_au

				BEGIN TRANSACTION
					UPDATE HL.sectores SET nombreSectorUSUARIO = nombreSectorUSUARIO + '___'
					SELECT * FROM HL.sectores
					SELECT * FROM HL.sectores_au
					ROLLBACK

CREATE TRIGGER HL.t_au_maquinas ON HL.maquinas
AFTER UPDATE
AS
BEGIN
	DECLARE @idMaq NUMERIC(5,0),
			@idSec_OLD NUMERIC(5,0), @numMaqUS_OLD SMALLINT, @nomMaqUS_OLD NVARCHAR(255), @descMaqUS_OLD NVARCHAR(255), @mpmprodUS_OLD NUMERIC(5,0),
			@idSec_NEW NUMERIC(5,0), @numMaqUS_NEW SMALLINT, @nomMaqUS_NEW NVARCHAR(255), @descMaqUS_NEW NVARCHAR(255), @mpmprodUS_NEW NUMERIC(5,0)
	DECLARE cur CURSOR FOR
		SELECT d.idMaquina,
			   d.idSector, d.numeroMaquinaUSUARIO, d.nombreMaquinaUSUARIO, d.descripcionMaquinaUSUARIO, d.metrosPorMinutoProducidosUSUARIO,
			   i.idSector, i.numeroMaquinaUSUARIO, i.nombreMaquinaUSUARIO, i.descripcionMaquinaUSUARIO, i.metrosPorMinutoProducidosUSUARIO
		FROM deleted d JOIN inserted i ON (d.idMaquina = i.idMaquina)
	OPEN cur
	FETCH NEXT FROM cur INTO @idMaq, @idSec_OLD, @numMaqUS_OLD, @nomMaqUS_OLD, @descMaqUS_OLD, @mpmprodUS_OLD, @idSec_NEW, @numMaqUS_NEW, @nomMaqUS_NEW, @descMaqUS_NEW, @mpmprodUS_NEW
	WHILE (@@FETCH_STATUS = 0) BEGIN
		INSERT INTO HL.maquinas_au (idMaquina, fechaHora, tipoDeInformacion, idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO, metrosPorMinutoProducidosUSUARIO)
			VALUES (@idMaq, GETDATE(), 'OLD', @idSec_OLD, @numMaqUS_OLD, @nomMaqUS_OLD, @descMaqUS_OLD, @mpmprodUS_OLD)
		INSERT INTO HL.maquinas_au (idMaquina, fechaHora, tipoDeInformacion, idSector, numeroMaquinaUSUARIO, nombreMaquinaUSUARIO, descripcionMaquinaUSUARIO, metrosPorMinutoProducidosUSUARIO)
			VALUES (@idMaq, GETDATE(), 'NEW', @idSec_NEW, @numMaqUS_NEW, @nomMaqUS_NEW, @descMaqUS_NEW, @mpmprodUS_NEW)
		FETCH NEXT FROM cur INTO @idMaq, @idSec_OLD, @numMaqUS_OLD, @nomMaqUS_OLD, @descMaqUS_OLD, @mpmprodUS_OLD, @idSec_NEW, @numMaqUS_NEW, @nomMaqUS_NEW, @descMaqUS_NEW, @mpmprodUS_NEW
	END
	CLOSE cur
	DEALLOCATE cur
END
GO
				--pruebas del trigger
				SELECT * FROM HL.maquinas
				SELECT * FROM HL.maquinas_au

				BEGIN TRANSACTION
					UPDATE HL.maquinas SET
										numeroMaquinaUSUARIO = numeroMaquinaUSUARIO + 100,
										nombreMaquinaUSUARIO = nombreMaquinaUSUARIO + '___',
										descripcionMaquinaUSUARIO = descripcionMaquinaUSUARIO + '___',
										metrosPorMinutoProducidosUSUARIO = metrosPorMinutoProducidosUSUARIO + 100,
										idSector = 4
					SELECT * FROM HL.maquinas
					SELECT * FROM HL.maquinas_au
					--CORREGIR, HAY UN ERROR EN EL TRIGGER
					ROLLBACK
					

/*
FIN AUDITOR�A
*/



/*
Script del JOB/TRABAJO para Agente SQL Server
- NO EJECUTAR AC�.
- ES PARA COPIAR Y PEGAR EN LA CONFIGURACI�N DEL JOB/TRABAJO
- Va comentado por las dudas:
	--DELETE FROM HL.registros WHERE DATEDIFF(DAY, fechaHoraEncendida, GETDATE()) > 180
*/

