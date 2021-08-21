USE prueba3
GO


/* VACIAR Y REINICIAR TABLA registros
SELECT * FROM HL.registros
DELETE FROM HL.registros
DBCC CHECKIDENT ('HL.registros', RESEED, 0)
SELECT * FROM HL.registros
*/


-- MÁQUINA 1 · SECTOR TELARES · TELAR 1 · 1 sesión
	--1
		EXEC HL.sp_insertarSesion 1, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 1, '2021-04-09 00:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 2 · SECTOR TELARES · TELAR 2 · 6 sesiones
	--1
		EXEC HL.sp_insertarSesion 2, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 2, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 2, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 2, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 2, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 2, '2021-01-09 00:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 2, '2021-01-09 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 2, '2021-02-09 00:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 2, '2021-02-09 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 2, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 2, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 2, '2021-04-09 00:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 3 · SECTOR TELARES · TELAR 3 · 19 sesiones
	--1
		EXEC HL.sp_insertarSesion 3, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-29-08 06:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 3, '2021-29-08 06:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-29-08 18:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 3, '2021-29-08 18:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 3, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 3, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-30-08 15:00' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 3, '2021-30-08 15:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 3, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 3, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 3, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-01-09 12:00' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 3, '2021-01-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 3, '2021-01-09 23:00' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 3, '2021-01-09 23:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 3, '2021-02-09 01:00' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 3, '2021-02-09 01:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-02-09 08:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 3, '2021-02-09 08:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-02-09 09:00' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 3, '2021-02-09 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 3, '2021-02-09 10:00' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 3, '2021-02-09 10:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-02-09 10:45' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 3, '2021-02-09 10:45' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-02-09 12:30' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 3, '2021-02-09 12:30' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-02-09 16:45' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 3, '2021-02-09 16:45' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-03-09 17:00' --'YY-DD-MM HH:MM:SS'
	--19
		EXEC HL.sp_insertarSesion 3, '2021-03-09 17:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 3, '2021-04-09 00:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 4 · SECTOR TELARES · TELAR 4 · 6 sesiones
	--1	
		EXEC HL.sp_insertarSesion 4, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 4, '2021-29-08 12:00' --'YY-DD-MM HH:MM:SS'
	--2	
		EXEC HL.sp_insertarSesion 4, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 4, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS'
	--3	
		EXEC HL.sp_insertarSesion 4, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 4, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS'
	--4	
		EXEC HL.sp_insertarSesion 4, '2021-01-09 13:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 4, '2021-02-09 00:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 4, '2021-02-09 13:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 4, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS'
	--6	
		EXEC HL.sp_insertarSesion 4, '2021-03-09 13:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 4, '2021-04-09 00:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 5 · SECTOR TELARES · TELAR 5 · 6 sesiones
	--1
		EXEC HL.sp_insertarSesion 5, '2021-29-08 05:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 5, '2021-29-08 18:00' --'YY-DD-MM HH:MM:SS'
	--2	
		EXEC HL.sp_insertarSesion 5, '2021-30-08 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 5, '2021-30-08 18:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 5, '2021-31-08 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 5, '2021-31-08 18:15' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 5, '2021-01-09 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 5, '2021-01-09 18:30' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 5, '2021-02-09 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 5, '2021-02-09 18:45' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 5, '2021-03-09 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 5, '2021-03-09 19:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 6 · SECTOR TELARES · TELAR 6 · 5 sesiones
	--1
		EXEC HL.sp_insertarSesion 6, '2021-29-08 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 6, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 6, '2021-30-08 22:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 6, '2021-31-08 06:15' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 6, '2021-31-08 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 6, '2021-01-09 06:30' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 6, '2021-01-09 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 6, '2021-02-09 06:45' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 6, '2021-02-09 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 6, '2021-03-09 07:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 7 · SECTOR TELARES · TELAR 7 · 12 sesiones
	--1
		EXEC HL.sp_insertarSesion 7, '2021-29-08 02:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 7, '2021-29-08 09:00' --'YY-DD-MM HH:MM:SS'
	--2	
		EXEC HL.sp_insertarSesion 7, '2021-29-08 14:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 7, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 7, '2021-30-08 02:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 7, '2021-30-08 08:45' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 7, '2021-30-08 14:15' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 7, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 7, '2021-31-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-31-08 08:30' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 7, '2021-31-08 14:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 7, '2021-01-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-01-09 08:15' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 7, '2021-01-09 14:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 7, '2021-02-09 02:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 7, '2021-02-09 08:00' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 7, '2021-02-09 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-02-09 21:00' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 7, '2021-03-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-03-09 07:45' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 7, '2021-03-09 15:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 7, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 8 · SECTOR TELARES · TELAR 8 · 18 sesiones
	--1
		EXEC HL.sp_insertarSesion 8, '2021-29-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-29-08 07:30' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 8, '2021-29-08 10:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-29-08 11:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 8, '2021-29-08 15:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 8, '2021-30-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-30-08 07:15' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 8, '2021-30-08 10:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-30-08 11:15' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 8, '2021-30-08 15:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 8, '2021-31-08 02:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 8, '2021-31-08 07:00' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 8, '2021-31-08 10:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-31-08 11:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 8, '2021-31-08 16:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 8, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 8, '2021-01-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-01-09 06:45' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 8, '2021-01-09 10:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-01-09 11:15' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 8, '2021-01-09 16:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 8, '2021-02-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-02-09 06:30' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 8, '2021-02-09 10:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-02-09 11:30' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 8, '2021-02-09 16:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-02-09 21:00' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 8, '2021-03-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-03-09 06:15' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 8, '2021-03-09 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-03-09 11:45' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 8, '2021-03-09 16:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 8, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 9 · SECTOR TELARES · TELAR 9 · 23 sesiones
	--1
		EXEC HL.sp_insertarSesion 9, '2021-29-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-29-08 06:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 9, '2021-29-08 10:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 9, '2021-29-08 12:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 9, '2021-29-08 17:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 9, '2021-29-08 23:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-30-08 00:15' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 9, '2021-30-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-30-08 05:45' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 9, '2021-30-08 09:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-30-08 12:15' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 9, '2021-30-08 17:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 9, '2021-30-08 23:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-31-08 00:30' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 9, '2021-31-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-31-08 05:30' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 9, '2021-31-08 09:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-31-08 12:30' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 9, '2021-31-08 17:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 9, '2021-31-08 23:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-01-09 00:45' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 9, '2021-01-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-01-09 05:15' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 9, '2021-01-09 09:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-01-09 12:45' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 9, '2021-01-09 17:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 9, '2021-01-09 23:45' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 9, '2021-02-09 01:00' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 9, '2021-02-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-02-09 05:00' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 9, '2021-02-09 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-02-09 13:00' --'YY-DD-MM HH:MM:SS'
	--19
		EXEC HL.sp_insertarSesion 9, '2021-02-09 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-02-09 21:30' --'YY-DD-MM HH:MM:SS'
	--20
		EXEC HL.sp_insertarSesion 9, '2021-03-09 00:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-03-09 01:15' --'YY-DD-MM HH:MM:SS'
	--21
		EXEC HL.sp_insertarSesion 9, '2021-03-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-03-09 04:45' --'YY-DD-MM HH:MM:SS'
	--22
		EXEC HL.sp_insertarSesion 9, '2021-03-09 08:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-03-09 13:15' --'YY-DD-MM HH:MM:SS'
	--23
		EXEC HL.sp_insertarSesion 9, '2021-03-09 18:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 9, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS'
	

-- MÁQUINA 10 · SECTOR TELARES · URDIDORA · 25 sesiones
	--1
		EXEC HL.sp_insertarSesion 10, '2021-29-08 00:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-29-08 01:30' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 10, '2021-29-08 02:00' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 10, '2021-29-08 04:30' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 10, '2021-29-08 08:30' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 10, '2021-29-08 13:30' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 10, '2021-29-08 18:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 10, '2021-30-08 00:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-30-08 01:45' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 10, '2021-30-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-30-08 04:15' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 10, '2021-30-08 08:15' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 10, '2021-30-08 13:45' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 10, '2021-30-08 18:45' --'YY-DD-MM HH:MM:SS'
		EXEC HL.sp_terminarSesion 10, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 10, '2021-31-08 01:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-31-08 04:00' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 10, '2021-31-08 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-31-08 11:00' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 10, '2021-31-08 11:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-31-08 14:00' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 10, '2021-31-08 19:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 10, '2021-01-09 01:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-01-09 03:45' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 10, '2021-01-09 07:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-01-09 10:45' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 10, '2021-01-09 11:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-01-09 14:15' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 10, '2021-01-09 19:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 10, '2021-02-09 01:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-02-09 03:30' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 10, '2021-02-09 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-02-09 10:30' --'YY-DD-MM HH:MM:SS'
	--19
		EXEC HL.sp_insertarSesion 10, '2021-02-09 11:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-02-09 14:30' --'YY-DD-MM HH:MM:SS'
	--20
		EXEC HL.sp_insertarSesion 10, '2021-02-09 19:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-02-09 21:00' --'YY-DD-MM HH:MM:SS'
	--21
		EXEC HL.sp_insertarSesion 10, '2021-03-09 01:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-03-09 03:15' --'YY-DD-MM HH:MM:SS'
	--22
		EXEC HL.sp_insertarSesion 10, '2021-03-09 07:15' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-03-09 10:15' --'YY-DD-MM HH:MM:SS'
	--23
		EXEC HL.sp_insertarSesion 10, '2021-03-09 11:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-03-09 11:15' --'YY-DD-MM HH:MM:SS'
	--24
		EXEC HL.sp_insertarSesion 10, '2021-03-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-03-09 14:45' --'YY-DD-MM HH:MM:SS'
	--25
		EXEC HL.sp_insertarSesion 10, '2021-03-09 19:45' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 10, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS'
	


-- MÁQUINA 11 · SECTOR CORDONERAS · CORDONERA 1 · 1 sesión
	--1
		EXEC HL.sp_insertarSesion 11, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 11, '2021-04-09 00:00' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 12 · SECTOR CORDONERAS · CORDONERA 2 · 3 sesiones
	--1
		EXEC HL.sp_insertarSesion 12, '2021-29-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 12, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 12, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 12, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 12, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 12, '2021-01-09 12:00' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 13 · SECTOR CORDONERAS · CORDONERA 3 · 21 sesiones
	--1
		EXEC HL.sp_insertarSesion 13, '2021-30-08 03:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 03:15' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 13, '2021-30-08 03:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 04:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 13, '2021-30-08 04:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 05:15' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 13, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 07:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 13, '2021-30-08 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 09:15' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 13, '2021-30-08 10:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 13, '2021-30-08 13:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 15:15' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 13, '2021-30-08 17:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 19:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 13, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-30-08 23:15' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 13, '2021-31-08 01:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-31-08 04:00' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 13, '2021-31-08 06:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-31-08 09:15' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 13, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-31-08 15:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 13, '2021-31-08 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-31-08 21:15' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 13, '2021-01-09 00:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-01-09 04:00' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 13, '2021-01-09 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-01-09 11:15' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 13, '2021-01-09 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-01-09 19:00' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 13, '2021-01-09 23:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-02-09 03:15' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 13, '2021-02-09 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-02-09 12:00' --'YY-DD-MM HH:MM:SS'
	--19
		EXEC HL.sp_insertarSesion 13, '2021-02-09 16:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-02-09 21:15' --'YY-DD-MM HH:MM:SS'
	--20
		EXEC HL.sp_insertarSesion 13, '2021-03-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-03-09 07:00' --'YY-DD-MM HH:MM:SS'
	--21
		EXEC HL.sp_insertarSesion 13, '2021-03-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 13, '2021-03-09 17:15' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 14 · SECTOR CORDONERAS · CORDONERA 4 · 17 sesiones
	--1
		EXEC HL.sp_insertarSesion 14, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-29-08 00:30' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 14, '2021-29-08 01:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-29-08 02:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 14, '2021-29-08 03:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-29-08 04:30' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 14, '2021-29-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-29-08 08:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 14, '2021-29-08 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-29-08 12:30' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 14, '2021-29-08 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-29-08 18:00' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 14, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-30-08 00:30' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 14, '2021-30-08 04:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-30-08 08:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 14, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-30-08 16:30' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 14, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-31-08 02:00' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 14, '2021-31-08 07:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-31-08 12:30' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 14, '2021-31-08 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-01-09 00:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 14, '2021-01-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-01-09 12:30' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 14, '2021-01-09 19:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-02-09 02:00' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 14, '2021-02-09 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-02-09 16:30' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 14, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-03-09 08:00' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 14, '2021-03-09 16:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 14, '2021-04-09 00:00' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 15 · SECTOR CORDONERAS · CORDONERA 5 · 6 sesiones
	--1
		EXEC HL.sp_insertarSesion 15, '2021-29-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 15, '2021-29-08 15:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 15, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 15, '2021-30-08 15:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 15, '2021-31-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 15, '2021-31-08 15:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 15, '2021-01-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 15, '2021-01-09 15:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 15, '2021-02-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 15, '2021-02-09 15:00' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 15, '2021-03-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 15, '2021-03-09 15:00' --'YY-DD-MM HH:MM:SS'

		
-- MÁQUINA 16 · SECTOR CORDONERAS · CORDONERA 6 · 6 sesiones
	--1
		EXEC HL.sp_insertarSesion 16, '2021-29-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 16, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 16, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 16, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 16, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 16, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 16, '2021-01-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 16, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 16, '2021-02-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 16, '2021-02-09 21:00' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 16, '2021-03-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 16, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 17 · SECTOR CORDONERAS · CORDONERA 7 · 5 sesiones
	--1
		EXEC HL.sp_insertarSesion 17, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 17, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 17, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 17, '2021-31-08 06:00' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 17, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 17, '2021-01-09 06:00' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 17, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 17, '2021-02-09 06:00' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 17, '2021-02-09 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 17, '2021-03-09 06:00' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 18 · SECTOR CORDONERAS · CORDONERA 8 · ninguna sesión

-- MÁQUINA 19 · SECTOR CORDONERAS · CORDONERA 9 · ninguna sesión

-- MÁQUINA 20 · SECTOR TERMINACIÓN · TERMINACIÓN 1 · 119 sesiones
	--1
		EXEC HL.sp_insertarSesion 20, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 00:15' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 20, '2021-29-08 00:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 00:45' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 20, '2021-29-08 01:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 01:15' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 20, '2021-29-08 01:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 01:45' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 20, '2021-29-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 02:15' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 20, '2021-29-08 02:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 02:45' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 20, '2021-29-08 03:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 03:15' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 20, '2021-29-08 03:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 03:45' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 20, '2021-29-08 04:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 04:15' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 20, '2021-29-08 04:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 04:45' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 20, '2021-29-08 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 05:15' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 20, '2021-29-08 05:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 05:45' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 20, '2021-29-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 06:15' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 20, '2021-29-08 06:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 06:45' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 20, '2021-29-08 07:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 07:15' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 20, '2021-29-08 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 07:45' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 20, '2021-29-08 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 08:15' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 20, '2021-29-08 08:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 08:45' --'YY-DD-MM HH:MM:SS'
	--19
		EXEC HL.sp_insertarSesion 20, '2021-29-08 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 09:15' --'YY-DD-MM HH:MM:SS'
	--20
		EXEC HL.sp_insertarSesion 20, '2021-29-08 09:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 09:45' --'YY-DD-MM HH:MM:SS'
	--21
		EXEC HL.sp_insertarSesion 20, '2021-29-08 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 10:15' --'YY-DD-MM HH:MM:SS'
	--22
		EXEC HL.sp_insertarSesion 20, '2021-29-08 10:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 10:45' --'YY-DD-MM HH:MM:SS'
	--23
		EXEC HL.sp_insertarSesion 20, '2021-29-08 11:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 11:15' --'YY-DD-MM HH:MM:SS'
	--24
		EXEC HL.sp_insertarSesion 20, '2021-29-08 11:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 11:45' --'YY-DD-MM HH:MM:SS'
	--25
		EXEC HL.sp_insertarSesion 20, '2021-29-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 12:15' --'YY-DD-MM HH:MM:SS'
	--26
		EXEC HL.sp_insertarSesion 20, '2021-29-08 12:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 12:45' --'YY-DD-MM HH:MM:SS'
	--27
		EXEC HL.sp_insertarSesion 20, '2021-29-08 13:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 13:15' --'YY-DD-MM HH:MM:SS'
	--28
		EXEC HL.sp_insertarSesion 20, '2021-29-08 13:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 13:45' --'YY-DD-MM HH:MM:SS'
	--29
		EXEC HL.sp_insertarSesion 20, '2021-29-08 14:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 14:15' --'YY-DD-MM HH:MM:SS'
	--30
		EXEC HL.sp_insertarSesion 20, '2021-29-08 14:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 14:45' --'YY-DD-MM HH:MM:SS'
	--31
		EXEC HL.sp_insertarSesion 20, '2021-29-08 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 15:15' --'YY-DD-MM HH:MM:SS'
	--32
		EXEC HL.sp_insertarSesion 20, '2021-29-08 15:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 15:45' --'YY-DD-MM HH:MM:SS'
	--33
		EXEC HL.sp_insertarSesion 20, '2021-29-08 16:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 16:15' --'YY-DD-MM HH:MM:SS'
	--34
		EXEC HL.sp_insertarSesion 20, '2021-29-08 16:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 16:45' --'YY-DD-MM HH:MM:SS'
	--35
		EXEC HL.sp_insertarSesion 20, '2021-29-08 17:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 17:15' --'YY-DD-MM HH:MM:SS'
	--36
		EXEC HL.sp_insertarSesion 20, '2021-29-08 17:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 17:45' --'YY-DD-MM HH:MM:SS'
	--37
		EXEC HL.sp_insertarSesion 20, '2021-29-08 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 18:15' --'YY-DD-MM HH:MM:SS'
	--38
		EXEC HL.sp_insertarSesion 20, '2021-29-08 18:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 18:45' --'YY-DD-MM HH:MM:SS'
	--39
		EXEC HL.sp_insertarSesion 20, '2021-29-08 19:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 19:15' --'YY-DD-MM HH:MM:SS'
	--40
		EXEC HL.sp_insertarSesion 20, '2021-29-08 19:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 19:45' --'YY-DD-MM HH:MM:SS'
	--41
		EXEC HL.sp_insertarSesion 20, '2021-29-08 20:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 20:15' --'YY-DD-MM HH:MM:SS'
	--42
		EXEC HL.sp_insertarSesion 20, '2021-29-08 20:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 20:45' --'YY-DD-MM HH:MM:SS'
	--43
		EXEC HL.sp_insertarSesion 20, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 21:15' --'YY-DD-MM HH:MM:SS'
	--44
		EXEC HL.sp_insertarSesion 20, '2021-29-08 21:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 21:45' --'YY-DD-MM HH:MM:SS'
	--45
		EXEC HL.sp_insertarSesion 20, '2021-29-08 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 22:15' --'YY-DD-MM HH:MM:SS'
	--46
		EXEC HL.sp_insertarSesion 20, '2021-29-08 22:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 22:45' --'YY-DD-MM HH:MM:SS'
	--47
		EXEC HL.sp_insertarSesion 20, '2021-29-08 23:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 23:15' --'YY-DD-MM HH:MM:SS'
	--48
		EXEC HL.sp_insertarSesion 20, '2021-29-08 23:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-29-08 23:45' --'YY-DD-MM HH:MM:SS'
	--49
		EXEC HL.sp_insertarSesion 20, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 00:30' --'YY-DD-MM HH:MM:SS'
	--50
		EXEC HL.sp_insertarSesion 20, '2021-30-08 01:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 01:30' --'YY-DD-MM HH:MM:SS'
	--51
		EXEC HL.sp_insertarSesion 20, '2021-30-08 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 02:30' --'YY-DD-MM HH:MM:SS'
	--52
		EXEC HL.sp_insertarSesion 20, '2021-30-08 03:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 03:30' --'YY-DD-MM HH:MM:SS'
	--53
		EXEC HL.sp_insertarSesion 20, '2021-30-08 04:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 04:30' --'YY-DD-MM HH:MM:SS'
	--54
		EXEC HL.sp_insertarSesion 20, '2021-30-08 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 05:30' --'YY-DD-MM HH:MM:SS'
	--55
		EXEC HL.sp_insertarSesion 20, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 06:30' --'YY-DD-MM HH:MM:SS'
	--56
		EXEC HL.sp_insertarSesion 20, '2021-30-08 07:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 07:30' --'YY-DD-MM HH:MM:SS'
	--57
		EXEC HL.sp_insertarSesion 20, '2021-30-08 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 08:30' --'YY-DD-MM HH:MM:SS'
	--58
		EXEC HL.sp_insertarSesion 20, '2021-30-08 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 09:30' --'YY-DD-MM HH:MM:SS'
	--59
		EXEC HL.sp_insertarSesion 20, '2021-30-08 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 10:30' --'YY-DD-MM HH:MM:SS'
	--60
		EXEC HL.sp_insertarSesion 20, '2021-30-08 11:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 11:30' --'YY-DD-MM HH:MM:SS'
	--61
		EXEC HL.sp_insertarSesion 20, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 12:30' --'YY-DD-MM HH:MM:SS'
	--62
		EXEC HL.sp_insertarSesion 20, '2021-30-08 13:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 13:30' --'YY-DD-MM HH:MM:SS'
	--63
		EXEC HL.sp_insertarSesion 20, '2021-30-08 14:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 14:30' --'YY-DD-MM HH:MM:SS'
	--64
		EXEC HL.sp_insertarSesion 20, '2021-30-08 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 15:30' --'YY-DD-MM HH:MM:SS'
	--65
		EXEC HL.sp_insertarSesion 20, '2021-30-08 16:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 16:30' --'YY-DD-MM HH:MM:SS'
	--66
		EXEC HL.sp_insertarSesion 20, '2021-30-08 17:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 17:30' --'YY-DD-MM HH:MM:SS'
	--67
		EXEC HL.sp_insertarSesion 20, '2021-30-08 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 18:30' --'YY-DD-MM HH:MM:SS'
	--68
		EXEC HL.sp_insertarSesion 20, '2021-30-08 19:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 19:30' --'YY-DD-MM HH:MM:SS'
	--69
		EXEC HL.sp_insertarSesion 20, '2021-30-08 20:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 20:30' --'YY-DD-MM HH:MM:SS'
	--70
		EXEC HL.sp_insertarSesion 20, '2021-30-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 21:30' --'YY-DD-MM HH:MM:SS'
	--71
		EXEC HL.sp_insertarSesion 20, '2021-30-08 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 22:30' --'YY-DD-MM HH:MM:SS'
	--72
		EXEC HL.sp_insertarSesion 20, '2021-30-08 23:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-30-08 23:30' --'YY-DD-MM HH:MM:SS'
	--73
		EXEC HL.sp_insertarSesion 20, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 00:45' --'YY-DD-MM HH:MM:SS'
	--74
		EXEC HL.sp_insertarSesion 20, '2021-31-08 01:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 02:15' --'YY-DD-MM HH:MM:SS'
	--75
		EXEC HL.sp_insertarSesion 20, '2021-31-08 03:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 03:45' --'YY-DD-MM HH:MM:SS'
	--76
		EXEC HL.sp_insertarSesion 20, '2021-31-08 04:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 05:15' --'YY-DD-MM HH:MM:SS'
	--77
		EXEC HL.sp_insertarSesion 20, '2021-31-08 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 06:45' --'YY-DD-MM HH:MM:SS'
	--78
		EXEC HL.sp_insertarSesion 20, '2021-31-08 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 08:15' --'YY-DD-MM HH:MM:SS'
	--79
		EXEC HL.sp_insertarSesion 20, '2021-31-08 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 09:45' --'YY-DD-MM HH:MM:SS'
	--80
		EXEC HL.sp_insertarSesion 20, '2021-31-08 10:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 11:15' --'YY-DD-MM HH:MM:SS'
	--81
		EXEC HL.sp_insertarSesion 20, '2021-31-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 12:45' --'YY-DD-MM HH:MM:SS'
	--82
		EXEC HL.sp_insertarSesion 20, '2021-31-08 13:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 14:15' --'YY-DD-MM HH:MM:SS'
	--83
		EXEC HL.sp_insertarSesion 20, '2021-31-08 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 15:45' --'YY-DD-MM HH:MM:SS'
	--84
		EXEC HL.sp_insertarSesion 20, '2021-31-08 16:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 17:15' --'YY-DD-MM HH:MM:SS'
	--85
		EXEC HL.sp_insertarSesion 20, '2021-31-08 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 18:45' --'YY-DD-MM HH:MM:SS'
	--86
		EXEC HL.sp_insertarSesion 20, '2021-31-08 19:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 20:15' --'YY-DD-MM HH:MM:SS'
	--87
		EXEC HL.sp_insertarSesion 20, '2021-31-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 21:45' --'YY-DD-MM HH:MM:SS'
	--88
		EXEC HL.sp_insertarSesion 20, '2021-31-08 22:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-31-08 23:15' --'YY-DD-MM HH:MM:SS'
	--89
		EXEC HL.sp_insertarSesion 20, '2021-01-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 01:00' --'YY-DD-MM HH:MM:SS'
	--90
		EXEC HL.sp_insertarSesion 20, '2021-01-09 02:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 03:00' --'YY-DD-MM HH:MM:SS'
	--91
		EXEC HL.sp_insertarSesion 20, '2021-01-09 04:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 05:00' --'YY-DD-MM HH:MM:SS'
	--92
		EXEC HL.sp_insertarSesion 20, '2021-01-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 07:00' --'YY-DD-MM HH:MM:SS'
	--93
		EXEC HL.sp_insertarSesion 20, '2021-01-09 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 09:00' --'YY-DD-MM HH:MM:SS'
	--94
		EXEC HL.sp_insertarSesion 20, '2021-01-09 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 11:00' --'YY-DD-MM HH:MM:SS'
	--95
		EXEC HL.sp_insertarSesion 20, '2021-01-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 13:00' --'YY-DD-MM HH:MM:SS'
	--96
		EXEC HL.sp_insertarSesion 20, '2021-01-09 14:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 15:00' --'YY-DD-MM HH:MM:SS'
	--97
		EXEC HL.sp_insertarSesion 20, '2021-01-09 16:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 17:00' --'YY-DD-MM HH:MM:SS'
	--98
		EXEC HL.sp_insertarSesion 20, '2021-01-09 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 19:00' --'YY-DD-MM HH:MM:SS'
	--99
		EXEC HL.sp_insertarSesion 20, '2021-01-09 20:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 21:00' --'YY-DD-MM HH:MM:SS'
	--100
		EXEC HL.sp_insertarSesion 20, '2021-01-09 22:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-01-09 23:00' --'YY-DD-MM HH:MM:SS'
	--101
		EXEC HL.sp_insertarSesion 20, '2021-02-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 01:15' --'YY-DD-MM HH:MM:SS'
	--102
		EXEC HL.sp_insertarSesion 20, '2021-02-09 02:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 03:45' --'YY-DD-MM HH:MM:SS'
	--103
		EXEC HL.sp_insertarSesion 20, '2021-02-09 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 06:15' --'YY-DD-MM HH:MM:SS'
	--104
		EXEC HL.sp_insertarSesion 20, '2021-02-09 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 08:45' --'YY-DD-MM HH:MM:SS'
	--105
		EXEC HL.sp_insertarSesion 20, '2021-02-09 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 11:15' --'YY-DD-MM HH:MM:SS'
	--106
		EXEC HL.sp_insertarSesion 20, '2021-02-09 12:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 13:45' --'YY-DD-MM HH:MM:SS'
	--107
		EXEC HL.sp_insertarSesion 20, '2021-02-09 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 16:15' --'YY-DD-MM HH:MM:SS'
	--108
		EXEC HL.sp_insertarSesion 20, '2021-02-09 17:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 18:45' --'YY-DD-MM HH:MM:SS'
	--109
		EXEC HL.sp_insertarSesion 20, '2021-02-09 20:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 21:15' --'YY-DD-MM HH:MM:SS'
	--110
		EXEC HL.sp_insertarSesion 20, '2021-02-09 22:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-02-09 23:45' --'YY-DD-MM HH:MM:SS'
	--111
		EXEC HL.sp_insertarSesion 20, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 01:30' --'YY-DD-MM HH:MM:SS'
	--112
		EXEC HL.sp_insertarSesion 20, '2021-03-09 03:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 04:30' --'YY-DD-MM HH:MM:SS'
	--113
		EXEC HL.sp_insertarSesion 20, '2021-03-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 07:30' --'YY-DD-MM HH:MM:SS'
	--114
		EXEC HL.sp_insertarSesion 20, '2021-03-09 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 10:30' --'YY-DD-MM HH:MM:SS'
	--115
		EXEC HL.sp_insertarSesion 20, '2021-03-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 13:30' --'YY-DD-MM HH:MM:SS'
	--116
		EXEC HL.sp_insertarSesion 20, '2021-03-09 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 16:30' --'YY-DD-MM HH:MM:SS'
	--117
		EXEC HL.sp_insertarSesion 20, '2021-03-09 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 19:30' --'YY-DD-MM HH:MM:SS'
	--118
		EXEC HL.sp_insertarSesion 20, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 20, '2021-03-09 22:30' --'YY-DD-MM HH:MM:SS'


-- MÁQUINA 21 · SECTOR TERMINACIÓN · TERMINACIÓN 2 · 31 sesiones
	--1
		EXEC HL.sp_insertarSesion 21, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 01:45' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 21, '2021-29-08 03:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 05:15' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 21, '2021-29-08 07:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 08:45' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 21, '2021-29-08 10:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 12:15' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 21, '2021-29-08 14:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 15:45' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 21, '2021-29-08 17:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 19:15' --'YY-DD-MM HH:MM:SS'		
	--7
		EXEC HL.sp_insertarSesion 21, '2021-29-08 21:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-29-08 22:45' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 21, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-30-08 02:00' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 21, '2021-30-08 04:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-30-08 06:00' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 21, '2021-30-08 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-30-08 10:00' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 21, '2021-30-08 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-30-08 14:00' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 21, '2021-30-08 16:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-30-08 18:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 21, '2021-30-08 20:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-30-08 22:00' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 21, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-31-08 02:15' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 21, '2021-31-08 04:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-31-08 06:45' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 21, '2021-31-08 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-31-08 11:15' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 21, '2021-31-08 13:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-31-08 15:45' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 21, '2021-31-08 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-31-08 20:15' --'YY-DD-MM HH:MM:SS'
	--19
		EXEC HL.sp_insertarSesion 21, '2021-01-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-01-09 02:30' --'YY-DD-MM HH:MM:SS'
	--20
		EXEC HL.sp_insertarSesion 21, '2021-01-09 05:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-01-09 07:30' --'YY-DD-MM HH:MM:SS'
	--21
		EXEC HL.sp_insertarSesion 21, '2021-01-09 10:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-01-09 12:30' --'YY-DD-MM HH:MM:SS'
	--22
		EXEC HL.sp_insertarSesion 21, '2021-01-09 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-01-09 17:30' --'YY-DD-MM HH:MM:SS'
	--23
		EXEC HL.sp_insertarSesion 21, '2021-01-09 20:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-01-09 22:30' --'YY-DD-MM HH:MM:SS'
	--24
		EXEC HL.sp_insertarSesion 21, '2021-02-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-02-09 02:45' --'YY-DD-MM HH:MM:SS'
	--25
		EXEC HL.sp_insertarSesion 21, '2021-02-09 05:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-02-09 08:15' --'YY-DD-MM HH:MM:SS'
	--26
		EXEC HL.sp_insertarSesion 21, '2021-02-09 11:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-02-09 13:45' --'YY-DD-MM HH:MM:SS'
	--27
		EXEC HL.sp_insertarSesion 21, '2021-02-09 16:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-02-09 19:15' --'YY-DD-MM HH:MM:SS'
	--28
		EXEC HL.sp_insertarSesion 21, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-03-09 03:00' --'YY-DD-MM HH:MM:SS'
	--29
		EXEC HL.sp_insertarSesion 21, '2021-03-09 06:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-03-09 09:00' --'YY-DD-MM HH:MM:SS'
	--30
		EXEC HL.sp_insertarSesion 21, '2021-03-09 12:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-03-09 15:00' --'YY-DD-MM HH:MM:SS'
	--31
		EXEC HL.sp_insertarSesion 21, '2021-03-09 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 21, '2021-03-09 21:00' --'YY-DD-MM HH:MM:SS'
		

-- MÁQUINA 22 · SECTOR TERMINACIÓN · TERMINACIÓN 3 · 19 sesiones
	--1
		EXEC HL.sp_insertarSesion 22, '2021-29-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-29-08 03:15' --'YY-DD-MM HH:MM:SS'
	--2
		EXEC HL.sp_insertarSesion 22, '2021-29-08 06:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-29-08 09:45' --'YY-DD-MM HH:MM:SS'
	--3
		EXEC HL.sp_insertarSesion 22, '2021-29-08 13:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-29-08 16:15' --'YY-DD-MM HH:MM:SS'
	--4
		EXEC HL.sp_insertarSesion 22, '2021-29-08 19:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-29-08 22:45' --'YY-DD-MM HH:MM:SS'
	--5
		EXEC HL.sp_insertarSesion 22, '2021-30-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-30-08 03:30' --'YY-DD-MM HH:MM:SS'
	--6
		EXEC HL.sp_insertarSesion 22, '2021-30-08 07:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-30-08 10:30' --'YY-DD-MM HH:MM:SS'
	--7
		EXEC HL.sp_insertarSesion 22, '2021-30-08 14:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-30-08 17:30' --'YY-DD-MM HH:MM:SS'
	--8
		EXEC HL.sp_insertarSesion 22, '2021-31-08 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-31-08 03:45' --'YY-DD-MM HH:MM:SS'
	--9
		EXEC HL.sp_insertarSesion 22, '2021-31-08 07:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-31-08 11:15' --'YY-DD-MM HH:MM:SS'
	--10
		EXEC HL.sp_insertarSesion 22, '2021-31-08 15:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-31-08 18:45' --'YY-DD-MM HH:MM:SS'
	--11
		EXEC HL.sp_insertarSesion 22, '2021-01-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-01-09 04:00' --'YY-DD-MM HH:MM:SS'
	--12
		EXEC HL.sp_insertarSesion 22, '2021-01-09 08:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-01-09 12:00' --'YY-DD-MM HH:MM:SS'
	--13
		EXEC HL.sp_insertarSesion 22, '2021-01-09 16:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-01-09 20:00' --'YY-DD-MM HH:MM:SS'
	--14
		EXEC HL.sp_insertarSesion 22, '2021-02-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-02-09 04:15' --'YY-DD-MM HH:MM:SS'
	--15
		EXEC HL.sp_insertarSesion 22, '2021-02-09 08:30' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-02-09 12:45' --'YY-DD-MM HH:MM:SS'
	--16
		EXEC HL.sp_insertarSesion 22, '2021-02-09 17:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-02-09 21:15' --'YY-DD-MM HH:MM:SS'
	--17
		EXEC HL.sp_insertarSesion 22, '2021-03-09 00:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-03-09 04:30' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 22, '2021-03-09 09:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-03-09 13:30' --'YY-DD-MM HH:MM:SS'
	--18
		EXEC HL.sp_insertarSesion 22, '2021-03-09 18:00' --'YY-DD-MM HH:MM:SS' 
		EXEC HL.sp_terminarSesion 22, '2021-03-09 22:30' --'YY-DD-MM HH:MM:SS'
	



SELECT * FROM HL.registros

