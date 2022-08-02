

-- Se crea la funci�n para que, teniendo el idMaq, se pueda obtener la cantidad de minutos transcurridos desde la �ltima vez en que se tiene registro de encendido hasta el instante actual.
		CREATE FUNCTION HL.f_getMinsONSinceLastReg
			(@idMaq NUMERIC)
		RETURNS INT
		AS BEGIN
			DECLARE @MaqFHURE SMALLDATETIME		--�ltimo registro de encendido de dicha m�quina
			DECLARE @mins INT

			-- Dado un idMaq, se calcula la �ltima fechaHora de registro de encendido.
			-- De no encontrarse ning�n registro, la fechaHora ser�n las 00:00:00 del 01/01/2020...
			
			IF (SELECT MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r WHERE r.idMaquina = @idMaq GROUP BY r.idMaquina) > 0
			BEGIN
				SELECT @MaqFHURE = MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r WHERE r.idMaquina = @idMaq GROUP BY r.idMaquina
			END
			ELSE BEGIN
				SELECT @MaqFHURE = '2020-01-01 00:00:00'
			END
			
			-- Se obtiene la cantidad de minutos transcurridos desde dicha fecha hasta el instante actual...
			--SELECT @mins = DATEDIFF(MINUTE, @MaqFHURE, GETDATE())
			SET @mins = (SELECT DATEDIFF(MINUTE, @MaqFHURE, GETDATE()) AS 'mm')

			RETURN @mins
		END
		--Ejemplos de uso:
		--SELECT 0, HL.f_getMinsONSinceLastReg(0) AS 'mm'
		--SELECT 1, HL.f_getMinsONSinceLastReg(1) AS 'mm'
		--SELECT 4, HL.f_getMinsONSinceLastReg(4) AS 'mm'
		--SELECT HL.f_getMinsONSinceLastReg(0) AS 'mm'
		--SELECT HL.f_getMinsONSinceLastReg(1) AS 'mm'
		--SELECT HL.f_getMinsONSinceLastReg(4) AS 'mm'

