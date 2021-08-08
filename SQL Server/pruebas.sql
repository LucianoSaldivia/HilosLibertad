USE prueba2



-- INSERCIÓN DE CASOS DE PRUEBA
SELECT * FROM HL.registros
EXEC HL.sp_insertarSesion 1, '2021-07-08 16:00' --'YY-DD-MM HH:MM:SS'
SELECT * FROM HL.registros
EXEC HL.sp_terminarSesion 1, '2021-07-08 17:25'
SELECT * FROM HL.registros



		--STORED PROCEDURE 
		--Sirve para ...
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






-- CONSULTA 1

SELECT m.numeroMaquinaUSUARIO AS '# Máq.',
	   m.nombreMaquinaUSUARIO AS 'Máquina',
	   HL.f_transformarMinutosEnHoras(SUM(r.cantidadMinutosEncendida)) AS 'Horas encendida'
FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina)
WHERE r.
/*
WHERE m.idMaquina IN (1, 2, 3) --agregar filtros de idMaquina según checkBoxs tildados
  AND r.							   --agregar filtros de fechas según
*/
GROUP BY m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO



-- CONSULTA 2
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

-- CONSULTA 3
