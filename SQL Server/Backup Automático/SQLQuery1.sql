

select @@version



select * from HL.registros




EXEC [dbo].[sp_BackupDatabases] @backupLocation='E:\Backups_DB', @backupType='F'



EXEC [dbo].[sp_BackupDatabases] @databaseName='DB_HILOS_LIBERTAD', @backupLocation='E:\Backups_DB\', @backupType='F'
GO


select @@servername + '\' + @@servicename








