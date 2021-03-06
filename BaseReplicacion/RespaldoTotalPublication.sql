use [LabMedicoDB5]
exec sp_replicationdboption @dbname = N'LabMedicoDB5', @optname = N'publish', @value = N'true'
GO
-- Adding the transactional publication
use [LabMedicoDB5]
exec sp_addpublication @publication = N'RespaldoTotal', @description = N'Transactional publication of database ''LabMedicoDB5'' from Publisher ''DESKTOP-T67LOK0\DISTTEST''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'RespaldoTotal', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N''


use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'__MigrationHistory', @source_owner = N'dbo', @source_object = N'__MigrationHistory', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'__MigrationHistory', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dbo__MigrationHistory', @del_cmd = N'CALL sp_MSdel_dbo__MigrationHistory', @upd_cmd = N'SCALL sp_MSupd_dbo__MigrationHistory'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Analisis', @source_owner = N'dbo', @source_object = N'Analisis', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Analisis', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAnalisis', @del_cmd = N'CALL sp_MSdel_dboAnalisis', @upd_cmd = N'SCALL sp_MSupd_dboAnalisis'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AnalisisSucursales', @source_owner = N'dbo', @source_object = N'AnalisisSucursales', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AnalisisSucursales', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAnalisisSucursales', @del_cmd = N'CALL sp_MSdel_dboAnalisisSucursales', @upd_cmd = N'SCALL sp_MSupd_dboAnalisisSucursales'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetRoles', @source_owner = N'dbo', @source_object = N'AspNetRoles', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetRoles', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAspNetRoles', @del_cmd = N'CALL sp_MSdel_dboAspNetRoles', @upd_cmd = N'SCALL sp_MSupd_dboAspNetRoles'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUserClaims', @source_owner = N'dbo', @source_object = N'AspNetUserClaims', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUserClaims', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAspNetUserClaims', @del_cmd = N'CALL sp_MSdel_dboAspNetUserClaims', @upd_cmd = N'SCALL sp_MSupd_dboAspNetUserClaims'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUserLogins', @source_owner = N'dbo', @source_object = N'AspNetUserLogins', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUserLogins', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAspNetUserLogins', @del_cmd = N'CALL sp_MSdel_dboAspNetUserLogins', @upd_cmd = N'SCALL sp_MSupd_dboAspNetUserLogins'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUserRoles', @source_owner = N'dbo', @source_object = N'AspNetUserRoles', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUserRoles', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAspNetUserRoles', @del_cmd = N'CALL sp_MSdel_dboAspNetUserRoles', @upd_cmd = N'SCALL sp_MSupd_dboAspNetUserRoles'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUsers', @source_owner = N'dbo', @source_object = N'AspNetUsers', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUsers', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAspNetUsers', @del_cmd = N'CALL sp_MSdel_dboAspNetUsers', @upd_cmd = N'SCALL sp_MSupd_dboAspNetUsers'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Citas', @source_owner = N'dbo', @source_object = N'Citas', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Citas', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboCitas', @del_cmd = N'CALL sp_MSdel_dboCitas', @upd_cmd = N'SCALL sp_MSupd_dboCitas'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Clientes', @source_owner = N'dbo', @source_object = N'Clientes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Clientes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboClientes', @del_cmd = N'CALL sp_MSdel_dboClientes', @upd_cmd = N'SCALL sp_MSupd_dboClientes'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Estudios', @source_owner = N'dbo', @source_object = N'Estudios', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Estudios', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboEstudios', @del_cmd = N'CALL sp_MSdel_dboEstudios', @upd_cmd = N'SCALL sp_MSupd_dboEstudios'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Historicos', @source_owner = N'dbo', @source_object = N'Historicos', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Historicos', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboHistoricos', @del_cmd = N'CALL sp_MSdel_dboHistoricos', @upd_cmd = N'SCALL sp_MSupd_dboHistoricos'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Sucursales', @source_owner = N'dbo', @source_object = N'Sucursales', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Sucursales', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboSucursales', @del_cmd = N'CALL sp_MSdel_dboSucursales', @upd_cmd = N'SCALL sp_MSupd_dboSucursales'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'TecnicoCitas', @source_owner = N'dbo', @source_object = N'TecnicoCitas', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'TecnicoCitas', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboTecnicoCitas', @del_cmd = N'CALL sp_MSdel_dboTecnicoCitas', @upd_cmd = N'SCALL sp_MSupd_dboTecnicoCitas'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Tecnicos', @source_owner = N'dbo', @source_object = N'Tecnicos', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Tecnicos', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboTecnicos', @del_cmd = N'CALL sp_MSdel_dboTecnicos', @upd_cmd = N'SCALL sp_MSupd_dboTecnicos'
GO




use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Zonas', @source_owner = N'dbo', @source_object = N'Zonas', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Zonas', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboZonas', @del_cmd = N'CALL sp_MSdel_dboZonas', @upd_cmd = N'SCALL sp_MSupd_dboZonas'
GO




