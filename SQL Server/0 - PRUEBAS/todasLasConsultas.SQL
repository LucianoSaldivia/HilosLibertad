
--Vista para pruebas del Registrador
--AL BORRAR LA VISTA, TAMBIÉN SE BORRAN/VACÍAN LOS DATOS DE LA TABLA ASOCIADA --> DELETE vista_registrador 
--DROP VIEW vista_registrador 
CREATE OR ALTER VIEW vista_registrador AS (
	SELECT r.idMaquina AS 'idMaq',
		   r.fechaHoraEncendida AS 'INIT_DT',
		   r.fechaHoraUltimoRegistroEncendida AS 'LAST_DT',
		   r.fueApagadaPorOperarioOPorFallaParticular AS 'TRND_OFF'
	FROM HILOSLIBERTAD.registros r
)
GO

SELECT * FROM vista_registrador
SELECT TOP 1 * FROM vista_registrador
SELECT TOP 1 * FROM vista_registrador ORDER BY LAST_DT DESC


--Tener en cuenta que las fechas son siempre crecientes.
--A la hora de actualizar una fecha, siempre se actualizará la más reciente

--Considerar todo tipo de casos de prueba: 2 INSERTs seguidos con el mismo idMaquina













