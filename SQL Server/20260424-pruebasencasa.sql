



/*
Se vacía la tabla máquinas
*/
BEGIN TRAN 
DELETE FROM HL.maquinas
SELECT * FROM HL.maquinas
COMMIT




/*
SE INSERTAN TODAS LAS MÁQUINAS
*/

--Board 1 (24 a 31)
INSERT INTO HL.maquinas VALUES (31, 1, 1001, 'Telar 1', 'Telar 1', 1)
INSERT INTO HL.maquinas VALUES (30, 1, 1002, 'Telar 2', 'Telar 2', 1)
INSERT INTO HL.maquinas VALUES (29, 1, 1003, 'Telar 3', 'Telar 3', 1)
INSERT INTO HL.maquinas VALUES (28, 1, 1004, 'Telar 4', 'Telar 4', 1)
INSERT INTO HL.maquinas VALUES (27, 1, 1005, 'Telar 5', 'Telar 5', 1)
INSERT INTO HL.maquinas VALUES (26, 1, 1006, 'Telar 6', 'Telar 6', 1)
INSERT INTO HL.maquinas VALUES (25, 1, 1007, 'Telar 7', 'Telar 7', 1)
INSERT INTO HL.maquinas VALUES (24, 1, 1009, 'Telar 9', 'Telar 9', 1)
--Board 1 (16 a 23)
--23 vacío
--22 vacío
INSERT INTO HL.maquinas VALUES (21, 2, 2101, 'Trenzadora 1', 'Trenzadora 1', 1)
INSERT INTO HL.maquinas VALUES (20, 2, 2102, 'Trenzadora 2', 'Trenzadora 2', 1)
INSERT INTO HL.maquinas VALUES (19, 2, 2001, 'Cordonera 1', 'Cordonera 1', 1)
INSERT INTO HL.maquinas VALUES (18, 2, 2002, 'Cordonera 2', 'Cordonera 2', 1)
INSERT INTO HL.maquinas VALUES (17, 2, 2003, 'Cordonera 3', 'Cordonera 3', 1)
INSERT INTO HL.maquinas VALUES (16, 2, 2004, 'Cordonera 4', 'Cordonera 4', 1)
--Board 0 (8 a 15)
INSERT INTO HL.maquinas VALUES (15, 2, 2007, 'Cordonera 7', 'Cordonera 7', 1)
INSERT INTO HL.maquinas VALUES (14, 2, 2006, 'Cordonera 6', 'Cordonera 6', 1)
INSERT INTO HL.maquinas	VALUES (13, 3, 3002, 'Puntera 2', 'Puntera 2', 1)
INSERT INTO HL.maquinas	VALUES (12, 3, 3001, 'Puntera 1', 'Puntera 1', 1)
INSERT INTO HL.maquinas VALUES (11, 2, 2103, 'Trenzadora 3', 'Trenzadora 3', 1)
INSERT INTO HL.maquinas VALUES (10, 2, 2106, 'Trenzadora 6', 'Trenzadora 6', 1)
INSERT INTO HL.maquinas VALUES (9,  2, 2104, 'Trenzadora 4', 'Trenzadora 4', 1)
INSERT INTO HL.maquinas VALUES (8,  2, 2009, 'Cordonera 9', 'Cordonera 9', 1)
--Board 0 (0 a 7)
INSERT INTO HL.maquinas VALUES (7,  2, 2010, 'Cordonera 10', 'Cordonera 10', 1)
INSERT INTO HL.maquinas VALUES (6,  2, 2008, 'Cordonera 8', 'Cordonera 8', 1)
INSERT INTO HL.maquinas VALUES (5,  4, 4001, 'Urdidora', 'Urdidora', 1)
INSERT INTO HL.maquinas VALUES (4,  1, 1008, 'Telar 8', 'Telar 8', 1)
INSERT INTO HL.maquinas VALUES (3,  2, 2005, 'Cordonera 5', 'Cordonera 5', 1)
INSERT INTO HL.maquinas VALUES (2,  2, 2105, 'Trenzadora 5', 'Trenzadora 5', 1)
INSERT INTO HL.maquinas VALUES (1,  3, 3102, 'Encarreteladora 2', 'Encarreteladora 2', 1)
INSERT INTO HL.maquinas VALUES (0,  3, 3101, 'Encarreteladora 1', 'Encarreteladora 1', 1)

SELECT * FROM HL.maquinas





/*
CARGA DE DATOS DE PRUEBA
*/

--Todavía no...
BEGIN TRAN
-- idMaquina 19 · 1 sesión · Formato de fecha: 'YY-MM-DD HH:MM:SS'
EXEC HL.sp_insertarSesion 19, '2026-04-20 00:00'
EXEC HL.sp_terminarSesion 19, '2026-04-23 00:00'
-- idMaquina 19 · 1 sesión · Formato de fecha: 'YY-MM-DD HH:MM:SS'
SELECT * FROM HL.registros
ROLLBACK
COMMIT

EXEC HL.sp_insertarSesion 20, '2026-04-20 08:00'
EXEC HL.sp_terminarSesion 20, '2026-04-20 10:00' --hasta acá, 2h
EXEC HL.sp_insertarSesion 20, '2026-04-21 08:00'
EXEC HL.sp_terminarSesion 20, '2026-04-21 10:00' --hasta acá, 4h
EXEC HL.sp_insertarSesion 20, '2026-04-22 08:00'
EXEC HL.sp_terminarSesion 20, '2026-04-22 10:00' --hasta acá, 6h




/*
PRUEBAS DE LAS FUNCIONES
*/

--Prueba de la función f_getMinsBetween_formatoFecha_1intervalo (DATETIME inicial, DATETIME final)
SELECT HL.f_getMinsBetween_formatoFecha_1intervalo ('2026-04-20 06:00', '2026-04-20 13:30')	--Devuelve 450, OK

--Prueba de la función f_getMinsBetween_formatoFecha_1intervalo (DATE inicial, DATE final, TIME inicial, TIME final)
SELECT HL.f_getMinsBetween_formatoFecha_Nintervalos ('2026-04-20', '2026-04-22', '06:00', '13:30')		--Devuelve 1350, OK
SELECT HL.f_getMinsBetween_formatoFecha_Nintervalos ('2026-04-20', '2026-04-22', '06:00', '13:31')		--Devuelve 1353, OK

--Prueba de la función f_getMinsON_formatoFecha_1intervalo (DATETIME registrado en DB inicial/final, DATETIME seleccionado por usuario en app inicial/final)
SELECT HL.f_getMinsON_formatoFecha_1intervalo ('2026-04-20 00:00', '2026-04-23 00:00', '2026-04-20 06:00', '2026-04-20 13:30')			--Devuelve 450, OK
SELECT HL.f_getMinsON_formatoFecha_1intervalo ('2026-04-20 00:00', '2026-04-23 00:00', '2026-04-20 06:00', '2026-04-20 13:31')			--Devuelve 451, OK
SELECT HL.f_getMinsON_formatoFecha_1intervalo ('2026-04-20 00:00', '2026-04-23 00:00', '2026-04-20 14:00', '2026-04-20 13:15')			--Devuelve 451, OK


--Prueba de la función f_getMinsON_formatoFecha_Nintervalos (DATE seleccionado por usuario en app inicial/final, ídem TIME, DATETIME registrado en DB inicial/final)
SELECT HL.f_getMinsON_formatoFecha_Nintervalos ('2026-04-20', '2026-04-22', '06:00', '13:30', '2026-04-20 00:00', '2026-04-23 00:00')	--Devuelve 1350, OK
SELECT HL.f_getMinsON_formatoFecha_Nintervalos ('2026-04-20', '2026-04-22', '06:00', '13:31', '2026-04-20 00:00', '2026-04-23 00:00')	--Devuelve 1353, OK



SELECT * FROM HL.registros
SELECT * FROM HL.maquinas

BEGIN TRAN
sp_mostrarTiemposPorMaquina_Nintervalos 'YYYY-DD-MM', 'YYYY-DD-MM', 'HH:MM:00', 'HH:MM:00', 'numero', 'nombre', 'sector'

ROLLBACK








/*
CORRECCIONES
*/





-- ORIGINAL, sin corregir
ALTER PROCEDURE HL.sp_mostrarTiemposPorMaquina_Nintervalos
	@STR_F_INI DATE,			-- string de FECHA inicial en formato 'YYYY-DD-MM'
	@STR_F_FIN DATE,			-- string de FECHA final en formato 'YYYY-DD-MM'
	@STR_H_INI TIME,			-- string de HORARIO inicial en formato 'HH:MM:00'
	@STR_H_FIN TIME,			-- string de HORARIO final en formato 'HH:MM:00'
	@STR_NUMERO_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_MAQUINA VARCHAR(MAX), 
	@STR_NOMBRE_SECTOR VARCHAR(MAX)
AS BEGIN
	SELECT	f0.MAQ_NUM AS '#', 
			f0.MAQ_NOM AS 'MÁQUINA', 
			f0.MAQ_SEC AS 'SECTOR', 
			CAST(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) / 60 AS VARCHAR(8)) + ':' + FORMAT(SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) % 60, 'D2') AS 'TIEMPO ENC. [HH:MM]',
			CONCAT(100 - CAST((SUM(HL.f_getMinsON_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN, COALESCE(f0.FH_ENC, '2000-01-01 00:00:00'), COALESCE(f0.FH_URE, '2000-01-01 00:00:00'))) * 100.00 /HL.f_getMinsBetween_formatoFecha_Nintervalos(@STR_F_INI, @STR_F_FIN, @STR_H_INI, @STR_H_FIN)) AS NUMERIC(7, 3)), ' %') AS '% ENC.',
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


--CORRECCIÓN:
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