SELECT m.nombreMaquinaUSUARIO, s.nombreSectorUSUARIO, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida
FROM HL.maquinas m LEFT JOIN HL.registros r ON (m.idMaquina = r.idMaquina) JOIN HL.sectores s ON (m.idSector = s.idSector)

SELECT m.nombreMaquinaUSUARIO, s.nombreSectorUSUARIO, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida
FROM HL.maquinas m FULL OUTER JOIN HL.registros r ON (m.idMaquina = r.idMaquina) JOIN HL.sectores s ON (m.idSector = s.idSector)

SELECT m.nombreMaquinaUSUARIO, s.nombreSectorUSUARIO, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida
FROM HL.maquinas m JOIN HL.registros r ON (m.idMaquina = r.idMaquina) JOIN HL.sectores s ON (m.idSector = s.idSector)

select * from HL.registros r


--El COALESCE va dentro del primer y del segundo parámetro de la función f_getMinsON_formatoFecha

		SELECT f0.MAQ_ID,
			   f0.MAQ_NUM,
			   f0.MAQ_NOM,
			   f0.MAQ_SEC,
			   SUM(HL.f_getMinsON_formatoFecha(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), '2021-29-08 00:00:00', '2021-04-09 00:00:00')) AS 'MINS_ON',
			   SUM(HL.f_getMinsON_formatoFecha(COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'), '2021-29-08 00:00:00', '2021-04-09 00:00:00')) / 60.0 AS 'HRS_ON'
		FROM (
				SELECT m.idMaquina AS 'MAQ_ID',
					   m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
					   m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
					   s.nombreSectorUSUARIO AS 'MAQ_SEC',
					   r.fechaHoraEncendida AS 'FH_ENC',
					   r.fechaHoraUltimoRegistroEncendida AS 'FH_URE'
				FROM HL.sectores s
				FULL JOIN HL.maquinas m ON (s.idSector = m.idSector)
				FULL JOIN HL.registros r ON (m.idMaquina = r.idMaquina)
				--WHERE (m.idMaquina IN (1, 18, 20))
			) AS f0
		GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC


	









--------------------------
            
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
