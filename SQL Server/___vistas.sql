-- CONFIGURACIONES INICIALES
		--Se usa la base de datos de nombre "pruebaDB"
		--USE DB_HilosLibertad
		USE prueba1
		GO
		--Se crea el esquema
		CREATE SCHEMA HL
		GO
		--Se establece el formato de fecha (para que sea YYYY-MM-DD HH:MM:SS)
		SET DATEFORMAT YMD
		GO



-- VISTAS

		--VISTA vista_registrador
		--Usada para pruebas en el Registrador
		CREATE OR ALTER VIEW HL.v_registrador AS (
			SELECT r.idMaquina AS 'idMaq',
				   r.fechaHoraEncendida AS 'INIT_DT',
				   r.fechaHoraUltimoRegistroEncendida AS 'LAST_DT',
				   r.fueApagadaPorOperarioOPorFallaParticular AS 'TRND_OFF',
				   r.cantidadMinutosEncendida AS 'MINS_ON'
			FROM HL.registros r
		)
		GO
		--Ejemplo de uso: SELECT TOP 1 * FROM vista_registrador ORDER BY LAST_DT DESC
		--Para borrar la vista: DROP VIEW HL.v_registrador
		--TENER EN CUENTA QUE, AL BORRAR LA VISTA, TAMBIÉN SE BORRAN LOS DATOS DE LA TABLA ASOCIADA --> DELETE HL.v_registrador 
		

		SELECT * FROM HL.v_registrador


