-- TRIGGER
-- En su momento, la tabla registros tenía un campo "cantidadMinutosEncendida".
-- Al actualizarse cualquier fecha de un registro, se disparaba el trigger que actualizaba la cantidad de minutos encendida de ese registro.
-- Como el cálculo entre fechas y franjas horarias no iba a ser siempre una resta entre los campos "fechaHoraUltimoRegistroEncendida" y "fechaHoraEncendida", se descartó el campo "cantidadMinutosEncendida".
-- Descartado el campo "cantidadMinutosEncendida", el trigger tampoco tendría razón de ser.
-- Por eso, el trigger se descartó completamente.

		--TRIGGER actualizarCantidadMinutosEncendida
		--Al actualizarse la TABLA registros, se actualiza (automáticamente) la cantidad de minutos que estuvo la máquina encendida.
		CREATE OR ALTER TRIGGER HL.t_actualizarCantidadMinutosEncendida
		ON HL.registros
		AFTER UPDATE
		AS BEGIN
			DECLARE @idReg NUMERIC(18,0),
					@idMaq NUMERIC(18,0),
					@fhEnc SMALLDATETIME,
					@fhUltRegEnc SMALLDATETIME,
					@cantMinEnc INT
			DECLARE cursor1 CURSOR FOR
				SELECT d.idRegistro,
					   d.idMaquina,
					   d.fechaHoraEncendida,
					   i.fechaHoraUltimoRegistroEncendida
				FROM inserted i JOIN deleted d ON (i.idRegistro = d.idRegistro)
			OPEN cursor1
			FETCH NEXT FROM cursor1 INTO @idReg, @idMaq, @fhEnc, @fhUltRegEnc
			WHILE @@FETCH_STATUS = 0 BEGIN
				SET @cantMinEnc = DATEDIFF(MINUTE, @fhEnc, @fhUltRegEnc)
				UPDATE HL.registros
					SET cantidadMinutosEncendida = @cantMinEnc
					WHERE idRegistro = (SELECT TOP 1 idRegistro
										FROM HL.registros
										WHERE idMaquina = @idMaq
										ORDER BY fechaHoraUltimoRegistroEncendida DESC)
				FETCH NEXT FROM cursor1 INTO @idReg, @idMaq, @fhEnc, @fhUltRegEnc
			END
			CLOSE cursor1
			DEALLOCATE cursor1
		END
		--Para eliminar el TRIGGER: DROP TRIGGER HL.t_actualizarCantidadMinutosEncendida

		