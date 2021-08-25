--FUNCIÓN FACTORIAL
--Recibe un número entero positivo y devuelve su factorial
--Sirve como ejemplo de recursividad
		CREATE OR ALTER FUNCTION HL.f_factorial (@valor INT)
		RETURNS INT
		AS BEGIN
			DECLARE @factorial INT
			DECLARE @cont INT
			SET @factorial = 1
			SET @cont = 1
			WHILE (@cont <= @valor) BEGIN
				SET @factorial = @factorial * @cont
				SET @cont = @cont + 1
			END
			RETURN @factorial
		END
		GO

		--Ejemplo de uso:
		--SELECT 10 AS 'n', HL.f_factorial(10) AS 'n!'
