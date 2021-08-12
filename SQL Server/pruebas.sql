USE prueba3
GO


/* VACIAR Y REINICIAR TABLA registros
DELETE FROM HL.registros
DBCC CHECKIDENT ('HL.registros', RESEED, 0)
*/


-- INSERCIÓN DE CASOS DE PRUEBA
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-25-09 00:00' --'YY-DD-MM HH:MM:SS'
EXEC HL.sp_terminarSesion 1, '2021-30-09 00:00' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-04-10 12:00' --'YY-DD-MM HH:MM:SS'
EXEC HL.sp_terminarSesion 1, '2021-04-10 15:00' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-05-10 23:00' --'YY-DD-MM HH:MM:SS'
EXEC HL.sp_terminarSesion 1, '2021-06-10 01:00' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 18, '2021-04-10 12:00' --'YY-DD-MM HH:MM:SS'
EXEC HL.sp_terminarSesion 18, '2021-04-10 12:06' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 18, '2021-06-10 22:00' --'YY-DD-MM HH:MM:SS'
EXEC HL.sp_terminarSesion 18, '2021-06-10 23:02' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 20, '2021-05-10 12:00' --'YY-DD-MM HH:MM:SS'
EXEC HL.sp_terminarSesion 20, '2021-05-10 22:15' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros


SELECT *
FROM HL.sectores s
JOIN HL.maquinas m ON (s.idSector = m.idSector)
JOIN HL.registros r ON (m.idMaquina = r.idMaquina)


--Filtro por máquinas
SELECT r.idMaquina AS 'MAQ_ID',
	   m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
	   m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
	   s.nombreSectorUSUARIO AS 'MAQ_SEC',
	   r.idRegistro AS 'REG_ID',
	   r.fechaHoraEncendida AS 'FH_ENC',
	   r.fechaHoraUltimoRegistroEncendida AS 'FH_URE',
	   DATEDIFF(MINUTE, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida) AS 'MINS_ON',
	   HL.f_transformarMinutosEnHoras(DATEDIFF(MINUTE, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)) AS 'HRS_ON'
FROM HL.sectores s
JOIN HL.maquinas m ON (s.idSector = m.idSector)
JOIN HL.registros r ON (m.idMaquina = r.idMaquina)
--WHERE (r.idMaquina IN " + STRING_LISTA_idMaquina + ")
WHERE r.idMaquina IN (1, 18, 20)
GO



--Filtro por Fechas + Filtro por máquinas --> CON EL WHERE ADENTRO
SELECT f_maq.MAQ_NUM,
	   f_maq.MAQ_NOM,
	   f_maq.MAQ_SEC,
	   SUM(f_maq.MINS_ON) AS 'Minutos Encendida', --No es un SUM de esas dos fechas... hay que contemplar los límites
	   SUM(f_maq.HRS_ON) AS 'Horas Encendida'
FROM (SELECT r.idMaquina AS 'MAQ_ID',
	   m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
	   m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
	   s.nombreSectorUSUARIO AS 'MAQ_SEC',
	   r.idRegistro AS 'REG_ID',
	   r.fechaHoraEncendida AS 'FH_ENC',
	   r.fechaHoraUltimoRegistroEncendida AS 'FH_URE',
	   DATEDIFF(MINUTE, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida) AS 'MINS_ON',
	   HL.f_transformarMinutosEnHoras(DATEDIFF(MINUTE, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)) AS 'HRS_ON'
	  FROM HL.sectores s
	  JOIN HL.maquinas m ON (s.idSector = m.idSector)
	  JOIN HL.registros r ON (m.idMaquina = r.idMaquina)
	  WHERE (r.idMaquina IN (1, 18, 20))
	    AND ((HL.f_getYYYYMMDDfromDateTime(r.fechaHoraUltimoRegistroEncendida) >= 20211005) AND (HL.f_getYYYYMMDDfromDateTime(r.fechaHoraEncendida) <= 20211005))
	  ) AS f_maq --filtro por máquinas
--WHERE (HL.f_getYYYYMMDDfromDateTime (f_maq.FH_URE) >= STRING_FECHA_DESDE) AND (HL.f_getYYYYMMDDfromDateTime (f_maq.FH_URE) <= STRING_FECHA_HASTA)
GROUP BY f_maq.MAQ_ID, f_maq.MAQ_NUM, f_maq.MAQ_NOM, f_maq.MAQ_SEC






select '2021-05-10 22:15',
	   GETDATE()

SELECT CONVERT(DATE, getdate()),
	   GETDATE()

SELECT CONVERT(DATE, '2021-05-10 22:15'),
	   CONVERT(time, '2021-05-10 22:15'),
	   '2021-05-10 22:15'

SELECT DATEPART(DAY, '2021-05-10 22:15')


SELECT DATEPART(YEAR, '2021-09-30 23:45') * 10000 + DATEPART(MONTH, '2021-09-30 23:45') * 100 + DATEPART(DAY, '2021-09-30 23:45') AS 'YYYYMMDD',
	   DATEPART(HOUR, '2021-09-30 23:45') * 100 + DATEPART(MINUTE, '2021-09-30 23:45') AS 'HHMM',
	   '2021-09-30 23:45'






SELECT *
FROM HL.registros r
WHERE HL.f_getYYYYMMDDfromDateTime (r.fechaHoraEncendida) < 20211000




















SELECT 20210925,
	   CONVERT(DATE, CONVERT(CHAR(8), 20210925)) AS 'Fecha'

-- DATE from SMALLDATETIME
SELECT '2021-09-25 23:45:00' AS 'YYYY-MM-DD HH:MM:00',
	   CONVERT(DATE, CONVERT(CHAR(10), '2021-09-25 23:45:00')) AS 'Fecha'
-- TIME from SMALLDATETIME
SELECT '2021-09-25 23:45:00' AS 'YYYY-MM-DD HH:MM:00',
	   CAST('2021-09-25 23:45:00' AS time(0)) AS 'Horario'



SELECT '2021-09-25 23:45:00' AS 'YYYY-MM-DD HH:MM:00',
	   CONVERT(TIME, CONVERT(CHAR(10), '2021-09-25 23:45:00')) AS 'Horario'



SELECT '22:15' AS 'HHmm',
	   CONVERT(DATE, CONVERT(CHAR(10), '2021-09-25')) AS 'Fecha'

SELECT 202109252345 AS 'YYYYMMDDhhmm',
	   CONVERT(DATETIME, CONVERT(VARCHAR(20), 202109252345)) AS 'FechaHora'


	   SELECT 202109252345 AS 'YYYYMMDDhhmm',
			  CAST(CAST(202109252345 AS VARCHAR(80)) AS smalldatetime)



SELECT 2345 AS 'HHMM',
	   CONVERT(time, CONVERT(CHAR(8), 2345))

select CONVERT (datetime, convert(char(8), 20100121))
select CONVERT (date, convert(char(8), 20100121))
select CONVERT (datetime, convert(char(8), 20100121))



--Opción 1
SELECT '2021-09-25 23:45' AS 'FECHA y HORA',
	   HL.f_getYYYYMMDDfromDateTime('2021-09-25 23:45') AS 'FECHA',
	   HL.f_getHHMMfromDateTime('2021-09-25 23:45') AS 'HORA'

--Opción 2
SELECT CAST('2021-25-09 23:45' AS SMALLDATETIME) AS 'FECHA y HORA',
	   HL.f_getYYYYMMDDfromDateTime('2021-09-25 23:45') AS 'FECHA',
	   HL.f_getHHMMfromDateTime('2021-09-25 23:45') AS 'HORA'







select *
from HL.registros r

select r.idMaquina,
	   r.fechaHoraEncendida,
	   r.fechaHoraUltimoRegistroEncendida,
	   DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) AS 'MINS_ON'
from HL.registros r


select r.idMaquina,
	   SUM(DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida)) AS 'TOTAL_MINS_ON'
from HL.registros r
group by r.idMaquina







/* ÚTIL PARA LAS CONSULTAS REQUERIDAS
DATEDIFF(MINUTE, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida) AS 'MINS_ON'
HL.f_transformarMinutosEnHoras(DATEDIFF(MINUTE, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida)) AS 'HRS_ON'
*/

--CONSULTA 0 - Filtro por máquinas, solamente
SELECT m.numeroMaquinaUSUARIO AS 'MAQ_NUM',
	   m.nombreMaquinaUSUARIO AS 'MAQ_NOM',
	   s.nombreSectorUSUARIO AS 'MAQ_SEC',
	   r.fechaHoraEncendida AS 'FH_ENC',
	   r.fechaHoraUltimoRegistroEncendida AS 'FH_URE',
	   DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) AS 'MINS_ON',
	   DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) / 60.0 AS 'HRS_ON'
FROM HL.sectores s
JOIN HL.maquinas m ON (s.idSector = m.idSector)
JOIN HL.registros r ON (m.idMaquina = r.idMaquina)
WHERE (r.idMaquina IN (1, 18, 20))
--WHERE (r.idMaquina IN " + STRING_LISTA_idMaquina + ")
--  AND 
            
            
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


select datepart(YEAR, '2021-08-08 00:00:00')
select '2021-09-08 00:00:00'

































		












		
			-- Filtrar fechas útiles para contar minutos
			-- DROP FUNCTION HL.f_getMinutosEncendida
			CREATE OR ALTER FUNCTION HL.f_getMinsEnc
				(@idMaq NUMERIC(18,0),
				 @FHSini SMALLDATETIME,
				 @FHSfin SMALLDATETIME)
				 RETURNS INT
			AS BEGIN
				--DECLARE @FHRini SMALLDATETIME
				--DECLARE @FHRfin SMALLDATETIME
				DECLARE @retorno INT



				RETURN @retorno
			END
			GO


			SELECT m.numeroMaquinaUSUARIO AS '# Máq.',
				   m.nombreMaquinaUSUARIO AS 'Máquina',
				   SUM (HL.f_getMinutosEncendida (r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, '2021-07-08 07:43', '2021-07-08 09:15')) AS 'Minutos encendida'
		FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
		--WHERE m.idMaquina IN 
		GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO







			--EXEC HL.sp_filtrarFechasUtiles 7, '2021-07-08 08:22', '2021-07-08 10:58'

					SELECT m.numeroMaquinaUSUARIO AS '#Máq.',
						   m.nombreMaquinaUSUARIO AS 'Máquina',
						   r.fechaHoraEncendida AS 'FH_ini',
						   r.fechaHoraUltimoRegistroEncendida AS 'FH_fin'
					FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
					WHERE (r.fechaHoraUltimoRegistroEncendida > )
					--(@FHRfin > @FHSini AND @FHRini ) OR ()
		






		select * from HL.registros




		


-- PRUEBA - Consulta que, dada una fecha de inicio y de fin, devuelve los minutos que estuvo encendida durante esa ventana de tiempo
		
		--mini consulta que filtra fechas útiles --> "filtro 1"
		SELECT r.idRegistro AS 'idReg',
			   m.idMaquina AS 'idMaq',
			   m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO',
			   m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO',
			   r.fechaHoraEncendida AS 'FH_Rini',
			   r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin'
		FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
		WHERE (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 07:43' AND r.fechaHoraEncendida < '2021-07-08 09:15')
		--WHERE (r.idMaquina = @idMaq)
		--  AND (r.fechaHoraUltimoRegistroEncendida > @FH_Sini AND r.fechaHoraEncendida < @FH_Sfin)


		--consulta interesante
		SELECT f1.numMaqUSUARIO AS '# Máq.',
			   f1.nomMaqUSUARIO AS 'Máquina',
			   f1.FH_Rini AS 'FH_ini',
			   f1.FH_Rfin AS 'FH_fin',
			   HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, '2021-07-08 07:43', '2021-07-08 09:15') AS 'Minutos encendida'
			   --HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, @FH_Sini, @FH_Sfin) AS 'Minutos encendida'
		FROM (SELECT r.idRegistro AS 'idReg',
					 m.idMaquina AS 'idMaq',
					 m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO',
					 m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO',
					 r.fechaHoraEncendida AS 'FH_Rini',
					 r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin'
			  FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
			  WHERE (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 07:43' AND r.fechaHoraEncendida < '2021-07-08 09:15')
			  --WHERE (r.idMaquina = @idMaq)
			  --  AND (r.fechaHoraUltimoRegistroEncendida > @FH_Sini AND r.fechaHoraEncendida < @FH_Sfin)
			  ) AS f1 -- filtro 1


		--STORE PROCEDURE sp_obtenerMinutosEncendidas
		CREATE OR ALTER PROCEDURE HL.sp_obtenerMinutosEncendidas
			@idMaq NUMERIC(18, 0),
			@FH_Sini SMALLDATETIME,
			@FH_Sfin SMALLDATETIME
		AS BEGIN
			SELECT f1.numMaqUSUARIO AS '# Máq.',
				   f1.nomMaqUSUARIO AS 'Máquina',
				   SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, @FH_Sini, @FH_Sfin)) AS 'Minutos encendida'
			FROM (SELECT r.idRegistro AS 'idReg',
						 m.idMaquina AS 'idMaq',
						 m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO',
						 m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO',
						 r.fechaHoraEncendida AS 'FH_Rini',
						 r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin'
				  FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
				  WHERE (r.idMaquina = @idMaq)
					AND (r.fechaHoraUltimoRegistroEncendida > @FH_Sini AND r.fechaHoraEncendida < @FH_Sfin)
				  ) AS f1 -- filtro 1
			GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO
		END
		GO

		EXEC HL.sp_obtenerMinutosEncendidas 7, '2021-07-08 07:43', '2021-07-08 15:49'
		



		-----------------------------------------------------------------------------------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		-- CONSULTA 1 - FORMATO -----------------------------------------------------------------------------------------------------------
		-- - STRING_FECHA_DESDE es un string (de formato: 'YYYY-MM-DD HH:MM') que se lee desde el dateTimePicker de la aplicación. --------
		-- - STRING_FECHA_HASTA es un string (de formato: 'YYYY-MM-DD HH:MM') que se lee desde el dateTimePicker de la aplicación. --------
		-- - STRING_LISTA_idMaquina es un string que se irá llenando de acuerdo a los checkBox que estén tildados. ------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		SELECT f1.numMaqUSUARIO AS '# Máq.',
			   f1.nomMaqUSUARIO AS 'Máquina',
			   SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, STRING_FECHA_DESDE, STRING_FECHA_HASTA)) AS 'Minutos encendida'
		FROM (SELECT r.idRegistro AS 'idReg',
					 m.idMaquina AS 'idMaq',
					 m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO',
					 m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO',
					 r.fechaHoraEncendida AS 'FH_Rini',
					 r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin'
			  FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
			  WHERE (r.idMaquina IN STRING_LISTA_idMaquina)
				AND (r.fechaHoraUltimoRegistroEncendida > STRING_FECHA_DESDE AND r.fechaHoraEncendida < STRING_FECHA_HASTA)
			 ) AS f1 -- filtro 1
		GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO
		-----------------------------------------------------------------------------------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		SELECT f1.numMaqUSUARIO AS '# Máq.', f1.nomMaqUSUARIO AS 'Máquina', SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, STRING_FECHA_DESDE, STRING_FECHA_HASTA)) AS 'Minutos encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) WHERE (r.idMaquina IN STRING_LISTA_idMaquina) AND (r.fechaHoraUltimoRegistroEncendida > STRING_FECHA_DESDE AND r.fechaHoraEncendida < STRING_FECHA_HASTA) ) AS f1 GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO
		-------------------------------------------------
		
		
		-- Ejemplo:
		SELECT f1.numMaqUSUARIO AS '# Máq.', f1.nomMaqUSUARIO AS 'Máquina', SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, '2021-07-08 00:00', '2021-07-08 23:45')) AS 'Minutos encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) WHERE (r.idMaquina IN (000, 7, 8, 000)) AND (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 00:00' AND r.fechaHoraEncendida < '2021-07-08 23:45') ) AS f1 GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO

		SELECT f1.numMaqUSUARIO AS '# Máq.', f1.nomMaqUSUARIO AS 'Máquina', SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, '2021-07-08 00:00', '2021-07-08 23:45')) AS 'Minutos encendida', HL.f_transformarMinutosEnHoras	(SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, '2021-07-08 00:00', '2021-07-08 23:45'))) AS 'Horas encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) WHERE (r.idMaquina IN (000, 7, 8, 000)) AND (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 00:00' AND r.fechaHoraEncendida < '2021-07-08 23:45') ) AS f1 GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO
		-----------------------------------



		select *, DATEPART(MONTH, fechaHoraEncendida)
		from HL.registros




		--Ejemplo de CONSULTA 2

			SELECT f2.nomSec AS 'Sector',
				   SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49')) AS 'Minutos encendida',
				   HL.f_transformarMinutosEnHoras(SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49'))) AS 'Horas encendida'
			FROM (SELECT r.idRegistro AS 'idReg',
						 m.idMaquina AS 'idMaq',
						 s.nombreSectorUSUARIO AS 'nomSec',
						 m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO',
						 m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO',
						 r.fechaHoraEncendida AS 'FH_Rini',
						 r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin'
				  FROM HL.sectores s 
				  JOIN HL.maquinas m ON (s.idSector = m.idSector)
				  JOIN HL.registros r ON (m.idMaquina = r.idMaquina)
				  WHERE (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 07:43' AND r.fechaHoraEncendida < '2021-07-08 15:49')
				  ) AS f2 -- filtro 2
			GROUP BY f2.nomSec



			---------------------------------------------------
			SELECT f2.nomSec AS 'Sector', SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49')) AS 'Minutos encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 07:43' AND r.fechaHoraEncendida < '2021-07-08 15:49')) AS f2 GROUP BY f2.nomSec
			---------------------------------------------------

			
			
			
			
		--Ejemplo de CONSULTA 3
		
			SELECT SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49')) AS 'Minutos encendida'
			FROM (SELECT r.idRegistro AS 'idReg',
						 m.idMaquina AS 'idMaq',
						 s.nombreSectorUSUARIO AS 'nomSec',
						 m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO',
						 m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO',
						 r.fechaHoraEncendida AS 'FH_Rini',
						 r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin'
				  FROM HL.sectores s 
				  JOIN HL.maquinas m ON (s.idSector = m.idSector)
				  JOIN HL.registros r ON (m.idMaquina = r.idMaquina)
				  WHERE (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 07:43' AND r.fechaHoraEncendida < '2021-07-08 15:49')
				  ) AS f3 --filtro 3
			
			---------------------------------------------------------------------------------------------------
			SELECT SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49')) AS 'Minutos encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > '2021-07-08 07:43' AND r.fechaHoraEncendida < '2021-07-08 15:49')) AS f3
			---------------------------------------------------------------------------------------------------





			




-- PRUEBA - Consulta que, dada una fecha de inicio y de fin, devuelve la cantidad de minutos que estuvo encendida durante esa ventana de tiempo
		SELECT m.numeroMaquinaUSUARIO AS '# Máq.',
			   m.nombreMaquinaUSUARIO AS 'Máquina',
			   SUM (HL.f_getMinutosEncendida (r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, '2021-07-08 07:43', '2021-07-08 09:15')) AS 'Minutos encendida'
			   --,SUM (HL.f_getMinutosEncendida (r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, @FH_Sini, @FH_Sfin)) AS 'Minutos encendida'
		FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
		--WHERE m.idMaquina = @idMaq
		GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO
		




		
		
		
		CREATE OR ALTER FUNCTION HL.f_obtenerMinutosEncendida
			(@idMaq INT,
			 @FH_Sini SMALLDATETIME,
			 @FH_Sfin SMALLDATETIME)
		RETURNS INT
		AS BEGIN
			DECLARE @retorno INT
			
			SET @retorno = (SELECT SUM (HL.f_getMinutosEncendida (r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, @FH_Sini, @FH_Sfin)) AS 'Minutos encendida'
						   FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
						   WHERE m.idMaquina = @idMaq
						   GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO)

			RETURN @retorno
		END
		GO

		SELECT m.numeroMaquinaUSUARIO AS '# Máq.',
			   m.nombreMaquinaUSUARIO AS 'Máquina',
			   r.fechaHoraEncendida AS 'FH_ini',
			   r.fechaHoraUltimoRegistroEncendida AS 'FH_fin'
		FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)




		SELECT SUM (HL.f_getMinutosEncendida (r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, @FH_Sini, @FH_Sfin)) AS 'Minutos encendida'
		FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
		WHERE m.idMaquina = @idMaq
		GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO




		/*
		*/






-- CONSULTA 1


WHERE r.
/*
WHERE m.idMaquina IN (1, 2, 3) --agregar filtros de idMaquina según checkBoxs tildados
  AND r.							   --agregar filtros de fechas según
*/
GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO









/* 
	ID_MÁQUINA = 7
dateTimes para pruebas de la función obtenerMinutos
Antes de iniciar:
	'2021-07-08 07:43'

Inicio sesión 1:
	'2021-07-08 08:22'
Mitad de sesión 1:
	'2021-07-08 09:15'
Fin de sesión 1:
	'2021-07-08 10:58'

Entre sesiones 1 y 2:
	'2021-07-08 12:05'

Inicio sesión 2:
	'2021-07-08 13:12'
Mitad de sesión 2:
	'2021-07-08 15:49'
Fin de sesión 2:
	'2021-07-08 17:33'

Entre sesiones 2 y 3:
	'2021-07-08 18:17'

Inicio sesión 3:
	'2021-07-08 20:38'
Mitad de sesión 3:
	'2021-07-08 21:22'
Fin de sesión 3:
	'2021-07-08 21:43'

Luego de finalizar:
	'2021-07-08 23:18'

*/



-- CONSULTA 2


-- CONSULTA 3
 