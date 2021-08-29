--Ejemplo STORED PROCEDURE HL.sp_1
	CREATE OR ALTER PROCEDURE HL.sp_1
	AS BEGIN
		SELECT * FROM HL.registros
	END
	GO

EXEC HL.sp_1
--DROP PROCEDURE HL.sp_1




-- USADO PARA LLENAR EL DataGridView CON LOS NOMBRES (ENTENDIDOS POR EL USUARIO) DE TODOS LOS SECTORES, ORDENADOS POR idSector
		CREATE OR ALTER PROCEDURE HL.sp_llenarDGVsectores
		AS BEGIN
			SELECT s.nombreSectorUSUARIO AS 'SECTOR'
			FROM HL.sectores s 
			ORDER BY s.idSector
		END
		GO


-- USADO PARA LLENAR EL ComboBox CON TODOS LOS SECTORES, ORDENADOS POR idSector
		CREATE OR ALTER PROCEDURE HL.sp_llenarCMBsectores
		AS BEGIN
			SELECT s.idSector, 
				   s.nombreSectorUSUARIO
			FROM HL.sectores s
			ORDER BY s.idSector
		END
		GO


-- USADO PARA CARGAR LOS TextBox CON LOS SECTORES, PR�XIMOS A SER EDITADOS
		CREATE OR ALTER PROCEDURE HL.sp_cargarTXTsectores
			@ID_SECTOR NUMERIC
		AS BEGIN
			SELECT s.idSector,
				   s.nombreSectorUSUARIO
			FROM HL.sectores s 
			WHERE s.idSector = @ID_SECTOR
		END
		GO




-- USADO PARA LLENAR EL DataGridView CON LOS N�MEROS/NOMBRES/DESCRIPCIONES (ENTENDIDOS POR EL USUARIO) DE TODOS LAS M�QUINAS, ORDENADOS POR idMaquina
		CREATE OR ALTER PROCEDURE HL.sp_llenarDGVmaquinas
		AS BEGIN
			SELECT m.idMaquina AS '#',
				   m.numeroMaquinaUSUARIO AS 'N�MERO',
				   m.nombreMaquinaUSUARIO AS 'M�QUINA',
				   m.descripcionMaquinaUSUARIO AS 'DESCRIPCI�N'
			FROM HL.maquinas m
			ORDER BY m.idMaquina
		END
		GO


-- USADO PARA LLENAR EL ComboBox CON TODAS LAS M�QUINAS, ORDENADAS POR idMaquina
		CREATE OR ALTER PROCEDURE HL.sp_llenarCMBmaquinas
		AS BEGIN
			SELECT m.idMaquina,
				   m.numeroMaquinaUSUARIO,
				   m.nombreMaquinaUSUARIO,
				   m.descripcionMaquinaUSUARIO
			FROM HL.maquinas m
			ORDER BY m.idMaquina
		END
		GO


-- USADO PARA CARGAR LOS TextBox CON LOS SECTORES, PR�XIMOS A SER EDITADOS
		CREATE OR ALTER PROCEDURE HL.sp_cargarTXTmaquinas
			@ID_MAQUINA NUMERIC
		AS BEGIN
			SELECT m.idMaquina,
				   m.numeroMaquinaUSUARIO, 
				   m.nombreMaquinaUSUARIO, 
				   m.descripcionMaquinaUSUARIO 
			FROM HL.maquinas m 
			WHERE m.idMaquina = @ID_MAQUINA
		END
		GO

		
