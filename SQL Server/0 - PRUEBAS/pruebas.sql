		

            
--CONSULTA 1 - CASO: día completo, franja horaria de 24hs
		SELECT f0.MAQ_ID,
				f0.MAQ_NUM,
				f0.MAQ_NOM,
				f0.MAQ_SEC,
				SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) AS 'MINS_ON',
				SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) / 60.0 AS 'HRS_ON'
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


--CONSULTA 2 - CASO: día completo, franja horaria de 24hs
		SELECT f0.MAQ_SEC,
				SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) AS 'MINS_ON',
				SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) / 60.0 AS 'HRS_ON'
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
		HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) > 0


		--CONSULTA 3 - CASO: día completo, franja horaria de 24hs
		SELECT SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) AS 'MINS_ON',
			   SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-25-09 00:00:00', '2021-27-09 00:00:00')) / 60.0 AS 'HRS_ON'
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


-----------------------
SELECT f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC, SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-05-10 00:00:00', '2021-06-10 00:00:00')) AS 'MINS_ON', SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, '2021-05-10 00:00:00', '2021-06-10 00:00:00')) / 60.0 AS 'HRS_ON' FROM (SELECT r.idMaquina AS 'MAQ_ID', m.numeroMaquinaUSUARIO AS 'MAQ_NUM', m.nombreMaquinaUSUARIO AS 'MAQ_NOM', s.nombreSectorUSUARIO AS 'MAQ_SEC', r.fechaHoraEncendida AS 'FH_ENC', r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.idMaquina IN (1, 18, 20)) ) AS f0 GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC
-----------------------




