USE prueba2



-- INSERCI�N DE CASOS DE PRUEBA
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-07-08 16:00' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_terminarSesion 1, '2021-07-08 17:25'
SELECT * FROM HL.registros



		--STORED PROCEDURE 
		--Sirve para ...
		/*
		CREATE OR ALTER PROCEDURE HL.getMinutosEncendidaEntreDosFechas
			@idMaq NUMERIC(18,0),
			@FH_enc SMALLDATETIME,
			@FH_apg SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			INSERT INTO HL.registros
					   (idMaquina, fechaHoraEncendida, fechaHoraUltimoRegistroEncendida, fueApagadaPorOperarioOPorFallaParticular, cantidadMinutosEncendida)
				VALUES (@idMaq,	   @fHEnc,			   @fHEnc,							 0,										   0)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_insertarSesion
		*/








		


		














		
			-- Filtrar fechas �tiles para contar minutos
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


			SELECT m.numeroMaquinaUSUARIO AS '# M�q.',
				   m.nombreMaquinaUSUARIO AS 'M�quina',
				   SUM (HL.f_getMinutosEncendida (r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida, '2021-07-08 07:43', '2021-07-08 09:15')) AS 'Minutos encendida'
		FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
		--WHERE m.idMaquina IN 
		GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO







			--EXEC HL.sp_filtrarFechasUtiles 7, '2021-07-08 08:22', '2021-07-08 10:58'

					SELECT m.numeroMaquinaUSUARIO AS '#M�q.',
						   m.nombreMaquinaUSUARIO AS 'M�quina',
						   r.fechaHoraEncendida AS 'FH_ini',
						   r.fechaHoraUltimoRegistroEncendida AS 'FH_fin'
					FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
					WHERE (r.fechaHoraUltimoRegistroEncendida > )
					--(@FHRfin > @FHSini AND @FHRini ) OR ()
		











		CREATE OR ALTER FUNCTION HL.f_getMinutosEncendida
			(@FH_Rini SMALLDATETIME,
			 @FH_Rfin SMALLDATETIME,
			 @FH_Sini SMALLDATETIME,
			 @FH_Sfin SMALLDATETIME)
		RETURNS INT
		AS BEGIN
			DECLARE @desde SMALLDATETIME
			DECLARE @hasta SMALLDATETIME
			DECLARE @retorno INT
			
			IF (@FH_Rini > @FH_Sini) BEGIN SET @desde = @FH_Rini END
			ELSE BEGIN SET @desde = @FH_Sini END

			IF (@FH_Rfin < @FH_Sfin) BEGIN SET @hasta = @FH_Rfin END
			ELSE BEGIN SET @hasta = @FH_Sfin END

			IF (DATEDIFF(MINUTE, @desde, @hasta) >= 0) SET @retorno = DATEDIFF(MINUTE, @desde, @hasta)
			ELSE SET @retorno = 0
			
			RETURN @retorno

			--RETURN DATEDIFF(MINUTE, @desde, @hasta)
		END
		GO


-- PRUEBA - Consulta que, dada una fecha de inicio y de fin, devuelve los minutos que estuvo encendida durante esa ventana de tiempo
		
		--mini consulta que filtra fechas �tiles --> "filtro 1"
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
		SELECT f1.numMaqUSUARIO AS '# M�q.',
			   f1.nomMaqUSUARIO AS 'M�quina',
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
			SELECT f1.numMaqUSUARIO AS '# M�q.',
				   f1.nomMaqUSUARIO AS 'M�quina',
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
		-- - STRING_FECHA_DESDE es un string (de formato: 'YYYY-MM-DD HH:MM') que se lee desde el dateTimePicker de la aplicaci�n. --------
		-- - STRING_FECHA_HASTA es un string (de formato: 'YYYY-MM-DD HH:MM') que se lee desde el dateTimePicker de la aplicaci�n. --------
		-- - STRING_LISTA_idMaquina es un string que se ir� llenando de acuerdo a los checkBox que est�n tildados. ------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		SELECT f1.numMaqUSUARIO AS '# M�q.',
			   f1.nomMaqUSUARIO AS 'M�quina',
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






		--Ejemplo de CONSULTA 2

			SELECT f2.nomSec AS 'Sector',
				   SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49')) AS 'Minutos encendida'
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

			
			
			
			
		--Ejemplo de CONSULTA 3
		
			SELECT SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, '2021-07-08 07:43', '2021-07-08 15:49')) AS 'Minutos encendida'
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
			





			




-- PRUEBA - Consulta que, dada una fecha de inicio y de fin, devuelve la cantidad de minutos que estuvo encendida durante esa ventana de tiempo
		SELECT m.numeroMaquinaUSUARIO AS '# M�q.',
			   m.nombreMaquinaUSUARIO AS 'M�quina',
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

		SELECT m.numeroMaquinaUSUARIO AS '# M�q.',
			   m.nombreMaquinaUSUARIO AS 'M�quina',
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
WHERE m.idMaquina IN (1, 2, 3) --agregar filtros de idMaquina seg�n checkBoxs tildados
  AND r.							   --agregar filtros de fechas seg�n
*/
GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO









/* 
	ID_M�QUINA = 7
dateTimes para pruebas de la funci�n obtenerMinutos
Antes de iniciar:
	'2021-07-08 07:43'

Inicio sesi�n 1:
	'2021-07-08 08:22'
Mitad de sesi�n 1:
	'2021-07-08 09:15'
Fin de sesi�n 1:
	'2021-07-08 10:58'

Entre sesiones 1 y 2:
	'2021-07-08 12:05'

Inicio sesi�n 2:
	'2021-07-08 13:12'
Mitad de sesi�n 2:
	'2021-07-08 15:49'
Fin de sesi�n 2:
	'2021-07-08 17:33'

Entre sesiones 2 y 3:
	'2021-07-08 18:17'

Inicio sesi�n 3:
	'2021-07-08 20:38'
Mitad de sesi�n 3:
	'2021-07-08 21:22'
Fin de sesi�n 3:
	'2021-07-08 21:43'

Luego de finalizar:
	'2021-07-08 23:18'

*/



-- CONSULTA 2


-- CONSULTA 3
 