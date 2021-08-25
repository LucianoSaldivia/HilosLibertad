-- VISTAS

		--VISTA vista_registrador
		--Usada para pruebas en el Registrador
		CREATE OR ALTER VIEW HL.v_registrador AS (
			SELECT r.idRegistro AS 'idReg',
				   r.idMaquina AS 'idMaq',
				   r.fechaHoraEncendida AS 'INIT_DT',
				   r.fechaHoraUltimoRegistroEncendida AS 'LAST_DT',
				   r.fueApagadaPorOperarioOPorFallaParticular AS 'TRND_OFF',
				   DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) AS 'MINS_DIFF'
			FROM HL.registros r
		)
		GO

		SELECT * FROM HL.v_registrador
		
		/*
		EJEMPLO DE USO
		SELECT TOP 1 * FROM vista_registrador ORDER BY LAST_DT DESC
		*/
				
		/*
		AL ELIMINAR LA VISTA, TAMBIÉN SE ELIMINAN LOS DATOS ASOCIADOS A LA TABLA HL.registros --> DELETE HL.v_registrador 
		PARA BORRAR LA VISTA:
		DROP VIEW HL.v_registrador
		*/
		

