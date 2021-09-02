--STORED PROCEDURES

/*
DATO APARTE:Se pueden crear STORED PROCEDURES sobre consultas SELECT.
*/

/*
DATO PARA NUESTROS STORED PROCEDURES: las fechas que se pasen por parémetro deben tener el siguiente formato: 'YY-DD-MM HH:MM:SS'.
*/


		--STORED PROCEDURE insertarSesion --> "SESSION STARTS"
		--Sirve para insertar el idMaquina y su fecha/hora de encendido.
		CREATE OR ALTER PROCEDURE HL.sp_insertarSesion
			@ID_MAQ NUMERIC(5,0),
			@FH_ENC SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			INSERT INTO HL.registros (idMaquina,	fechaHoraEncendida,	fechaHoraUltimoRegistroEncendida,	fueApagadaPorOperarioOPorFallaParticular)
							  VALUES (@ID_MAQ,		@FH_ENC,			@FH_ENC,							0)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_insertarSesion
		

		--STORED PROCEDURE actualizarSesion --> "SESSION CONTINUES"
		--Sirve para actualizar la fecha/hora del último registro de encendido de cierta máquina (cuyo ID se pasa por parámetro).
		CREATE OR ALTER PROCEDURE HL.sp_actualizarSesion
			@ID_MAQ NUMERIC(5, 0),
			@FH_URE SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			UPDATE HL.registros
				SET fechaHoraUltimoRegistroEncendida = @FH_URE
				WHERE idRegistro = (SELECT TOP 1 idRegistro
									FROM HL.registros
									WHERE idMaquina = @ID_MAQ
									ORDER BY fechaHoraUltimoRegistroEncendida DESC, idRegistro DESC)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_actualizarSesion


		--STORED PROCEDURE terminarSesion --> "SESSION FINISHES"
		--Sirve para actualizar la fecha/hora del último registro de encendido de cierta máquina (cuyo ID se pasa por parámetro), indicando que fue apagada por un operario o por una falla particular.
		CREATE OR ALTER PROCEDURE HL.sp_terminarSesion
			@ID_MAQ NUMERIC(5, 0),
			@FH_URE SMALLDATETIME
		AS BEGIN
			SET DATEFORMAT YMD
			UPDATE HL.registros
				SET fechaHoraUltimoRegistroEncendida = @FH_URE,
					fueApagadaPorOperarioOPorFallaParticular = 1
				WHERE idRegistro = (SELECT TOP 1 idRegistro
									FROM HL.registros
									WHERE idMaquina = @ID_MAQ
									ORDER BY fechaHoraUltimoRegistroEncendida DESC, idRegistro DESC)
		END
		GO
		--Para eliminar el STORED PROCEDURE: DROP PROCEDURE HL.sp_terminarSesion


