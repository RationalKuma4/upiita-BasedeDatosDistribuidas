DECLARE @actualname NVARCHAR(100)
DECLARE @currentname NVARCHAR(100)
SELECT @actualname = CONVERT(NVARCHAR(100), SERVERPROPERTY(N'servername'))
SELECT @currentname = @@SERVERNAME
EXEC sp_dropserver @currentname
EXEC sp_addserver @actualname, local

SELECT SERVERPROPERTY(N'servername')
SELECT @@SERVERNAME

sp_helpserver

SELECT * FROM sys.servers