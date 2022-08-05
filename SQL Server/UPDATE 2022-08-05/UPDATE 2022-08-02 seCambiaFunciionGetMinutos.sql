-- Se corrige la funci�n que trae los minutos
-- Ahora es por numMaq (del usuario) y no por idMaq (de la DB)
ALTER FUNCTION HL.f_getMinsONSinceLastReg
	(@numMaq NUMERIC)
RETURNS INT
AS BEGIN
	DECLARE @MaqFHURE SMALLDATETIME		--�ltimo registro de encendido de dicha m�quina
	DECLARE @mins INT

	-- Dado un idMaq, se calcula la �ltima fechaHora de registro de encendido.
	-- De no encontrarse ning�n registro, la fechaHora ser�n las 00:00:00 del 01/01/2020...
			
	--IF (SELECT MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r WHERE r.idMaquina = @numMaq GROUP BY r.idMaquina) > 0
	IF (SELECT MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) WHERE m.numeroMaquinaUSUARIO = @numMaq GROUP BY m.numeroMaquinaUSUARIO) > 0
	BEGIN
		--SELECT @MaqFHURE = MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r WHERE r.idMaquina = @numMaq GROUP BY r.idMaquina
		SELECT @MaqFHURE = MAX(fechaHoraUltimoRegistroEncendida) FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) WHERE m.numeroMaquinaUSUARIO = @numMaq GROUP BY m.numeroMaquinaUSUARIO
	END
	ELSE BEGIN
		SELECT @MaqFHURE = '2020-01-01 00:00:00'
	END
			
	-- Se obtiene la cantidad de minutos transcurridos desde dicha fecha hasta el instante actual...
	--SELECT @mins = DATEDIFF(MINUTE, @MaqFHURE, GETDATE())
	SET @mins = (SELECT DATEDIFF(MINUTE, @MaqFHURE, GETDATE()) AS 'mm')

	RETURN @mins
END


