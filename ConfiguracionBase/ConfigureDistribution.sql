/****** Scripting replication configuration. Script Date: 12/11/2016 08:45:51 p. m. ******/
/****** Please Note: For security reasons, all password parameters were scripted with either NULL or an empty string. ******/

/****** Installing the server as a Distributor. Script Date: 12/11/2016 08:45:51 p. m. ******/
use master
exec sp_adddistributor @distributor = N'DESKTOP-BVUQAH4\MSSQLSERVER16', @password = N''
GO
exec sp_adddistributiondb @database = N'distribution', @data_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER16\MSSQL\Data', @log_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER16\MSSQL\Data', @log_file_size = 2, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1
GO

use [distribution] 
if (not exists (select * from sysobjects where name = 'UIProperties' and type = 'U ')) 
	create table UIProperties(id int) 
if (exists (select * from ::fn_listextendedproperty('SnapshotFolder', 'user', 'dbo', 'table', 'UIProperties', null, null))) 
	EXEC sp_updateextendedproperty N'SnapshotFolder', N'\\DESKTOP-BVUQAH4\repldata', 'user', dbo, 'table', 'UIProperties' 
else 
	EXEC sp_addextendedproperty N'SnapshotFolder', N'\\DESKTOP-BVUQAH4\repldata', 'user', dbo, 'table', 'UIProperties'
GO

exec sp_adddistpublisher @publisher = N'DESKTOP-BVUQAH4\MSSQLSERVER16', @distribution_db = N'distribution', @security_mode = 0, @login = N'sa', @password = N'', @working_directory = N'\\DESKTOP-BVUQAH4\repldata', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
GO
