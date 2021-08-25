SELECT s.nombreSectorUSUARIO
FROM HL.sectores s

SELECT s.nombreSectorUSUARIO AS 'NOMBRE_SECTOR'
FROM HL.sectores s
ORDER BY s.idSector



SELECT m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO, m.descripcionMaquinaUSUARIO
FROM HL.maquinas m
ORDER BY m.numeroMaquinaUSUARIO







-- ORIGINAL
SELECT f0.MAQ_ID,
		f0.MAQ_NUM,
		f0.MAQ_NOM,
		f0.MAQ_SEC,
		SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-29-08 00:00:00', '2021-04-09 00:00:00')) AS 'MINS_ON',
		SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-29-08 00:00:00', '2021-04-09 00:00:00')) / 60.0 AS 'HRS_ON'
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
		--WHERE (r.idMaquina IN (1, 18, 20))
	) AS f0
GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC



-- NUEVA
SELECT f0.MAQ_ID,
		f0.MAQ_NUM,
		f0.MAQ_NOM,
		f0.MAQ_SEC,
		SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-29-08 00:00:00', '2021-04-09 00:00:00')) AS 'MINS_ON',
		CONCAT(SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-29-08 00:00:00', '2021-04-09 00:00:00')) / 60, 
		       ' h  ', 
			   SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-29-08 00:00:00', '2021-04-09 00:00:00')) % 60, 
			   ' min') AS 'TIME_ON'
		--SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-29-08 00:00:00', '2021-04-09 00:00:00')) / 60.00 AS 'HRS_ON'
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
		--WHERE (r.idMaquina IN (1, 18, 20))
	) AS f0
GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC









-- PRUEBA SENCILLA QUE ANDA
SELECT 139 AS 'DIVIDENDO',
	   60 AS 'DIVISOR',
	   139/60 AS 'COCIENTE',
	   139%60 AS 'RESTO',
	   CONCAT(139/60, ' h  ', 139%60, ' min')


	   		 	  	  










SELECT * FROM HL.sectores

SELECT s.idSector, s.nombreSectorUSUARIO FROM HL.sectores s ORDER BY s.idSector