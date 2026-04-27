--CORRECCIÓN DEL SP sp_mostrarTiemposPorMaquina_Nintervalos:
ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_Nintervalos
	@STR_F_INI DATE,		-- string de FECHA inicial en formato 'YYYY-DD-MM'
	@STR_F_FIN DATE,		-- string de FECHA final en formato 'YYYY-DD-MM'
	@STR_H_INI TIME,		-- string de HORARIO inicial en formato 'HH:MM:00'
	@STR_H_FIN TIME,		-- string de HORARIO final en formato 'HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT	f0.MAQ_NUM AS '#', 
			f0.MAQ_NOM AS 'MÁQUINA', 
			f0.MAQ_SEC AS 'SECTOR', 
			CAST(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]',
			ISNULL( CONCAT( CAST( (SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.0) / NULLIF(HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN), 0) AS NUMERIC(7,3) ), ' %'), '0.000 %') AS '% ENC.',
			SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * f0.MAQ_MPM AS 'METROS FABRICADOS'
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
			WHERE m.numeroMaquinaUSUARIO LIKE CONCAT('%', @STR_NUMERO_MAQUINA, '%')
			AND m.nombreMaquinaUSUARIO LIKE CONCAT('%', @STR_NOMBRE_MAQUINA, '%')
			AND s.nombreSectorUSUARIO LIKE CONCAT('%', @STR_NOMBRE_SECTOR, '%')
			) AS f0
	GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_MPM, f0.MAQ_SEC
	ORDER BY f0.MAQ_NUM
END