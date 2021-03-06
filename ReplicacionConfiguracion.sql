/****** Scripting replication configuration. Script Date: 11/12/2016 01:56:53 p. m. ******/
/****** Please Note: For security reasons, all password parameters were scripted with either NULL or an empty string. ******/

/****** Begin: Script to be run at Publisher ******/

/****** Installing the server as a Distributor. Script Date: 11/12/2016 01:56:53 p. m. ******/
use master
exec sp_adddistributor @distributor = N'DESKTOP-T67LOK0\DISTTEST', @password = N'', @from_scripting = 1
GO

-- Adding the agent profiles
-- Updating the agent profile defaults
exec sp_MSupdate_agenttype_default @profile_id = 1
GO
exec sp_MSupdate_agenttype_default @profile_id = 2
GO
exec sp_MSupdate_agenttype_default @profile_id = 4
GO
exec sp_MSupdate_agenttype_default @profile_id = 6
GO
exec sp_MSupdate_agenttype_default @profile_id = 11
GO

-- Adding the distribution databases
use master
exec sp_adddistributiondb @database = N'distribution', @data_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL13.DISTTEST\MSSQL\Data', @data_file = N'distribution.MDF', @data_file_size = 13, @log_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL13.DISTTEST\MSSQL\Data', @log_file = N'distribution.LDF', @log_file_size = 9, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1, @from_scripting = 1
GO

------ Script Date: Replication agents checkup ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Checkup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Checkup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Replication agents checkup')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Replication agents checkup', @enabled = 1, @description = N'Detects replication agents that are not logging history actively.', @start_step_id = 1, @category_name = N'REPL-Checkup', @owner_login_name = N'sa', @notify_level_eventlog = 2, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'sys.sp_replication_agent_checkup @heartbeat_interval = 10', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @database_name = N'master', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20161125, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Reinitialize subscriptions having data validation failures ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Alert Response') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Alert Response'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Reinitialize subscriptions having data validation failures')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Reinitialize subscriptions having data validation failures', @enabled = 1, @description = N'Reinitializes all subscriptions that have data validation failures.', @start_step_id = 1, @category_name = N'REPL-Alert Response', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'exec sys.sp_MSreinit_failed_subscriptions @failure_level = 1', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'master', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Replication monitoring refresher for distribution. ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Alert Response') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Alert Response'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Replication monitoring refresher for distribution.')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Replication monitoring refresher for distribution.', @enabled = 0, @description = N'Replication monitoring refresher for distribution.', @start_step_id = 1, @category_name = N'REPL-Alert Response', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'exec dbo.sp_replmonitorrefreshjob  ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161125, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Agent history clean up: distribution ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-History Cleanup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-History Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Agent history clean up: distribution')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Agent history clean up: distribution', @enabled = 1, @description = N'Removes replication agent history from the distribution database.', @start_step_id = 1, @category_name = N'REPL-History Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC dbo.sp_MShistory_cleanup @history_retention = 48', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20161125, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: Distribution clean up: distribution ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution Cleanup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Distribution clean up: distribution')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Distribution clean up: distribution', @enabled = 1, @description = N'Removes replicated transactions from the distribution database.', @start_step_id = 1, @category_name = N'REPL-Distribution Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC dbo.sp_MSdistribution_cleanup @min_distretention = 0, @max_distretention = 72', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 10, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20161125, @active_end_date = 99991231, @active_start_time = 500, @active_end_time = 459
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

-- Adding the distribution publishers
exec sp_adddistpublisher @publisher = N'DESKTOP-T67LOK0\DISTTEST', @distribution_db = N'distribution', @security_mode = 0, @login = N'sa', @password = N'', @working_directory = N'\\DESKTOP-T67LOK0\repldata', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER'
GO

------ Script Date: DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Tecnicos-9 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Snapshot') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Snapshot'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Tecnicos-9')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Tecnicos-9', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Snapshot', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Snapshot Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_snapshot_history @perfmon_increment = 0,  @agent_id = 9, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Snapshot', @command = N'-Publisher [DESKTOP-T67LOK0\DISTTEST] -PublisherDB [LabMedicoDB5] -Distributor [DESKTOP-T67LOK0\DISTTEST] -Publication [Tecnicos] -DistributorSecurityMode 1 ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 10, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Snapshot'', @agent_id = 9', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 0, @freq_type = 1, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Historicos-7 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Snapshot') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Snapshot'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Historicos-7')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Historicos-7', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Snapshot', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Snapshot Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_snapshot_history @perfmon_increment = 0,  @agent_id = 7, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Snapshot', @command = N'-Publisher [DESKTOP-T67LOK0\DISTTEST] -PublisherDB [LabMedicoDB5] -Distributor [DESKTOP-T67LOK0\DISTTEST] -Publication [Historicos] -DistributorSecurityMode 1 ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 10, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Snapshot'', @agent_id = 7', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 0, @freq_type = 1, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-RespaldoTotal-5 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Snapshot') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Snapshot'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-RespaldoTotal-5')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-RespaldoTotal-5', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Snapshot', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Snapshot Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_snapshot_history @perfmon_increment = 0,  @agent_id = 5, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Snapshot', @command = N'-Publisher [DESKTOP-T67LOK0\DISTTEST] -PublisherDB [LabMedicoDB5] -Distributor [DESKTOP-T67LOK0\DISTTEST] -Publication [RespaldoTotal] -DistributorSecurityMode 1 ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 10, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Snapshot'', @agent_id = 5', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 0, @freq_type = 1, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Usuarios-8 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Snapshot') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Snapshot'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Usuarios-8')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Usuarios-8', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Snapshot', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Snapshot Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_snapshot_history @perfmon_increment = 0,  @agent_id = 8, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Snapshot', @command = N'-Publisher [DESKTOP-T67LOK0\DISTTEST] -PublisherDB [LabMedicoDB5] -Distributor [DESKTOP-T67LOK0\DISTTEST] -Publication [Usuarios] -DistributorSecurityMode 1 ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 10, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Snapshot'', @agent_id = 8', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 0, @freq_type = 1, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Clientes-6 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Snapshot') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Snapshot'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Clientes-6')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Clientes-6', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Snapshot', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Snapshot Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_snapshot_history @perfmon_increment = 0,  @agent_id = 6, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Snapshot', @command = N'-Publisher [DESKTOP-T67LOK0\DISTTEST] -PublisherDB [LabMedicoDB5] -Distributor [DESKTOP-T67LOK0\DISTTEST] -Publication [Clientes] -DistributorSecurityMode 1 ', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 10, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Snapshot'', @agent_id = 6', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 0, @freq_type = 1, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-5 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-LogReader') < 1 
  execute msdb.dbo.sp_add_category N'REPL-LogReader'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-5')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-5', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-LogReader', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Log Reader Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_logreader_history @perfmon_increment = 0, @agent_id = 5, @runstatus = 1, 
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'LogReader', @command = N'-Publisher [DESKTOP-T67LOK0\DISTTEST] -PublisherDB [LabMedicoDB5] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1  -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''LogReader'', @agent_id = 5', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-ISHIHARA\MEHPEYKER-32 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-ISHIHARA\MEHPEYKER-32')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-ISHIHARA\MEHPEYKER-32', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 32, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [ISHIHARA\MEHPEYKER] -SubscriberDB [Respaldo] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [RespaldoTotal] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 32', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161209, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-DESKTOP-BVUQAH4\TESTD-35 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-DESKTOP-BVUQAH4\TESTD-35')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-DESKTOP-BVUQAH4\TESTD-35', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 35, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [DESKTOP-BVUQAH4\TESTDDB] -SubscriberDB [Total] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [RespaldoTotal] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 35', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161211, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\TESTD-37 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\TESTD-37')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\TESTD-37', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 37, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [DESKTOP-BVUQAH4\TESTDDB] -SubscriberDB [Usuarios] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [Usuarios] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 37', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161211, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Clientes-DESKTOP-BVUQAH4\TESTD-33 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Clientes-DESKTOP-BVUQAH4\TESTD-33')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Clientes-DESKTOP-BVUQAH4\TESTD-33', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 33, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [DESKTOP-BVUQAH4\TESTDDB] -SubscriberDB [Clientes] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [Clientes] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 33', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161211, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-30 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-30')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-30', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 30, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [KURO\SQLEXPRESST1] -SubscriberDB [RESPALDOTEST] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [RespaldoTotal] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 30', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161209, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Historicos-DESKTOP-BVUQAH4\TESTD-34 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Historicos-DESKTOP-BVUQAH4\TESTD-34')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Historicos-DESKTOP-BVUQAH4\TESTD-34', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 34, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [DESKTOP-BVUQAH4\TESTDDB] -SubscriberDB [Historicos] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [Historicos] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 34', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161211, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\MSSQL-27 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\MSSQL-27')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\MSSQL-27', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 27, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [DESKTOP-BVUQAH4\MSSQLSERVER16] -SubscriberDB [Usuarios] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [Usuarios] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 27', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161208, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Tecnicos-DESKTOP-BVUQAH4\TESTD-36 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Tecnicos-DESKTOP-BVUQAH4\TESTD-36')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Tecnicos-DESKTOP-BVUQAH4\TESTD-36', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 36, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [DESKTOP-BVUQAH4\TESTDDB] -SubscriberDB [Tecnicos] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [Tecnicos] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 36', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161211, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

------ Script Date: DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-31 ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Distribution') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Distribution'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-31')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-31', @enabled = 1, @description = N'No description available.', @start_step_id = 1, @category_name = N'REPL-Distribution', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Distribution Agent startup message.', @subsystem = N'TSQL', @command = N'sp_MSadd_distribution_history @perfmon_increment = 0, @agent_id = 31, @runstatus = 1,  
                    @comments = N''Starting agent.''', @cmdexec_success_code = 0, @on_success_action = 3, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Run agent.', @subsystem = N'Distribution', @command = N'-Subscriber [KURO\SQLEXPRESST1] -SubscriberDB [Prueba2Nueva] -Publisher [DESKTOP-T67LOK0\DISTTEST] -Distributor [DESKTOP-T67LOK0\DISTTEST] -DistributorSecurityMode 1 -Publication [RespaldoTotal] -PublisherDB [LabMedicoDB5]    -Continuous', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 3, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 2147483647, @retry_interval = 1, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'Detect nonlogged agent shutdown.', @subsystem = N'TSQL', @command = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Distribution'', @agent_id = 31', @cmdexec_success_code = 0, @on_success_action = 2, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'distribution', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 64, @freq_interval = 0, @freq_subday_type = 0, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20161209, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO

exec sp_addsubscriber @subscriber = N'DESKTOP-BVUQAH4\MSSQLSERVER16', @type = 0, @description = N''
GO
exec sp_addsubscriber @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @type = 0, @description = N''
GO
exec sp_addsubscriber @subscriber = N'ISHIHARA\MEHPEYKER', @type = 0, @description = N''
GO
exec sp_addsubscriber @subscriber = N'KURO\SQLEXPRESST1', @type = 0, @description = N''
GO

------ Script Date: Expired subscription clean up ------
begin transaction 
  DECLARE @JobID BINARY(16)
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
if (select count(*) from msdb.dbo.syscategories where name = N'REPL-Subscription Cleanup') < 1 
  execute msdb.dbo.sp_add_category N'REPL-Subscription Cleanup'

select @JobID = job_id from msdb.dbo.sysjobs where (name = N'Expired subscription clean up')
if (@JobID is NULL)
BEGIN
  execute @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT, @job_name = N'Expired subscription clean up', @enabled = 1, @description = N'Detects and removes expired subscriptions from published databases.', @start_step_id = 1, @category_name = N'REPL-Subscription Cleanup', @owner_login_name = N'sa', @notify_level_eventlog = 0, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @notify_email_operator_name = N'(unknown)', @notify_netsend_operator_name = N'(unknown)', @notify_page_operator_name = N'(unknown)', @delete_level = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Run agent.', @subsystem = N'TSQL', @command = N'EXEC sys.sp_expired_subscription_cleanup', @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @server = N'DESKTOP-T67LOK0\DISTTEST', @database_name = N'master', @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Replication agent schedule.', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 1, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_start_date = 20161125, @active_end_date = 99991231, @active_start_time = 10000, @active_end_time = 235959
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

  execute @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'DESKTOP-T67LOK0\DISTTEST'
  if (@@ERROR <> 0 OR @ReturnCode <> 0) goto QuitWithRollback

END

commit transaction 
goto EndSave 
QuitWithRollback: 
  if (@@TRANCOUNT > 0) rollback transaction 
EndSave:
GO


/****** End: Script to be run at Publisher ******/


-- Enabling the replication database
use master
exec sp_replicationdboption @dbname = N'LabMedicoDB5', @optname = N'publish', @value = N'true'
GO

exec [LabMedicoDB5].sys.sp_addlogreader_agent @publisher_security_mode = 0, @publisher_login = N'sa', @job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-5', @job_login = null, @job_password = null
GO
exec [LabMedicoDB5].sys.sp_addqreader_agent @job_name = null, @frompublisher = 1, @job_login = null, @job_password = null
GO
-- Adding the transactional publication
use [LabMedicoDB5]
exec sp_addpublication @publication = N'Clientes', @description = N'Transactional publication of database ''LabMedicoDB5'' from Publisher ''DESKTOP-T67LOK0\DISTTEST''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Clientes', @snapshot_job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Clientes-6', @job_login = null, @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N''
exec sp_grant_publication_access @publication = N'Clientes', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'Clientes', @login = N'DESKTOP-T67LOK0\Anselmo-LT'
GO
exec sp_grant_publication_access @publication = N'Clientes', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'Clientes', @login = N'NT SERVICE\SQLAgent$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Clientes', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'Clientes', @login = N'NT Service\MSSQL$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Clientes', @login = N'distributor_admin'
GO

-- Adding the transactional articles
use [LabMedicoDB5]
exec sp_addarticle @publication = N'Clientes', @article = N'Clientes', @source_owner = N'dbo', @source_object = N'Clientes', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Clientes', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboClientes]', @del_cmd = N'CALL [sp_MSdel_dboClientes]', @upd_cmd = N'SCALL [sp_MSupd_dboClientes]'
GO

-- Adding the transactional subscriptions
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'Clientes', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @destination_db = N'Clientes', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Clientes', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @subscriber_db = N'Clientes', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Clientes-DESKTOP-BVUQAH4\TESTD-33', @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [LabMedicoDB5]
exec sp_addpublication @publication = N'Historicos', @description = N'Transactional publication of database ''LabMedicoDB5'' from Publisher ''DESKTOP-T67LOK0\DISTTEST''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Historicos', @snapshot_job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Historicos-7', @job_login = null, @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N''
exec sp_grant_publication_access @publication = N'Historicos', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'Historicos', @login = N'DESKTOP-T67LOK0\Anselmo-LT'
GO
exec sp_grant_publication_access @publication = N'Historicos', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'Historicos', @login = N'NT SERVICE\SQLAgent$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Historicos', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'Historicos', @login = N'NT Service\MSSQL$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Historicos', @login = N'distributor_admin'
GO

-- Adding the transactional articles
use [LabMedicoDB5]
exec sp_addarticle @publication = N'Historicos', @article = N'Historicos', @source_owner = N'dbo', @source_object = N'Historicos', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Historicos', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboHistoricos]', @del_cmd = N'CALL [sp_MSdel_dboHistoricos]', @upd_cmd = N'SCALL [sp_MSupd_dboHistoricos]'
GO

-- Adding the transactional subscriptions
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'Historicos', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @destination_db = N'Historicos', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Historicos', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @subscriber_db = N'Historicos', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Historicos-DESKTOP-BVUQAH4\TESTD-34', @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [LabMedicoDB5]
exec sp_addpublication @publication = N'RespaldoTotal', @description = N'Transactional publication of database ''LabMedicoDB5'' from Publisher ''DESKTOP-T67LOK0\DISTTEST''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'RespaldoTotal', @snapshot_job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-RespaldoTotal-5', @job_login = null, @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N''
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'DESKTOP-T67LOK0\Anselmo-LT'
GO
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'NT SERVICE\SQLAgent$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'NT Service\MSSQL$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'RespaldoTotal', @login = N'distributor_admin'
GO

-- Adding the transactional articles
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'__MigrationHistory', @source_owner = N'dbo', @source_object = N'__MigrationHistory', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'__MigrationHistory', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dbo__MigrationHistory]', @del_cmd = N'CALL [sp_MSdel_dbo__MigrationHistory]', @upd_cmd = N'SCALL [sp_MSupd_dbo__MigrationHistory]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Analisis', @source_owner = N'dbo', @source_object = N'Analisis', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Analisis', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAnalisis]', @del_cmd = N'CALL [sp_MSdel_dboAnalisis]', @upd_cmd = N'SCALL [sp_MSupd_dboAnalisis]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AnalisisSucursales', @source_owner = N'dbo', @source_object = N'AnalisisSucursales', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AnalisisSucursales', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAnalisisSucursales]', @del_cmd = N'CALL [sp_MSdel_dboAnalisisSucursales]', @upd_cmd = N'SCALL [sp_MSupd_dboAnalisisSucursales]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetRoles', @source_owner = N'dbo', @source_object = N'AspNetRoles', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetRoles', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAspNetRoles]', @del_cmd = N'CALL [sp_MSdel_dboAspNetRoles]', @upd_cmd = N'SCALL [sp_MSupd_dboAspNetRoles]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUserClaims', @source_owner = N'dbo', @source_object = N'AspNetUserClaims', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUserClaims', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAspNetUserClaims]', @del_cmd = N'CALL [sp_MSdel_dboAspNetUserClaims]', @upd_cmd = N'SCALL [sp_MSupd_dboAspNetUserClaims]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUserLogins', @source_owner = N'dbo', @source_object = N'AspNetUserLogins', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'AspNetUserLogins', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAspNetUserLogins]', @del_cmd = N'CALL [sp_MSdel_dboAspNetUserLogins]', @upd_cmd = N'SCALL [sp_MSupd_dboAspNetUserLogins]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUserRoles', @source_owner = N'dbo', @source_object = N'AspNetUserRoles', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'AspNetUserRoles', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAspNetUserRoles]', @del_cmd = N'CALL [sp_MSdel_dboAspNetUserRoles]', @upd_cmd = N'SCALL [sp_MSupd_dboAspNetUserRoles]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'AspNetUsers', @source_owner = N'dbo', @source_object = N'AspNetUsers', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUsers', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAspNetUsers]', @del_cmd = N'CALL [sp_MSdel_dboAspNetUsers]', @upd_cmd = N'SCALL [sp_MSupd_dboAspNetUsers]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Citas', @source_owner = N'dbo', @source_object = N'Citas', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Citas', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboCitas]', @del_cmd = N'CALL [sp_MSdel_dboCitas]', @upd_cmd = N'SCALL [sp_MSupd_dboCitas]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Clientes', @source_owner = N'dbo', @source_object = N'Clientes', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Clientes', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboClientes]', @del_cmd = N'CALL [sp_MSdel_dboClientes]', @upd_cmd = N'SCALL [sp_MSupd_dboClientes]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Estudios', @source_owner = N'dbo', @source_object = N'Estudios', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Estudios', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboEstudios]', @del_cmd = N'CALL [sp_MSdel_dboEstudios]', @upd_cmd = N'SCALL [sp_MSupd_dboEstudios]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Historicos', @source_owner = N'dbo', @source_object = N'Historicos', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Historicos', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboHistoricos]', @del_cmd = N'CALL [sp_MSdel_dboHistoricos]', @upd_cmd = N'SCALL [sp_MSupd_dboHistoricos]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Sucursales', @source_owner = N'dbo', @source_object = N'Sucursales', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Sucursales', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboSucursales]', @del_cmd = N'CALL [sp_MSdel_dboSucursales]', @upd_cmd = N'SCALL [sp_MSupd_dboSucursales]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'TecnicoCitas', @source_owner = N'dbo', @source_object = N'TecnicoCitas', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'TecnicoCitas', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboTecnicoCitas]', @del_cmd = N'CALL [sp_MSdel_dboTecnicoCitas]', @upd_cmd = N'SCALL [sp_MSupd_dboTecnicoCitas]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Tecnicos', @source_owner = N'dbo', @source_object = N'Tecnicos', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Tecnicos', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboTecnicos]', @del_cmd = N'CALL [sp_MSdel_dboTecnicos]', @upd_cmd = N'SCALL [sp_MSupd_dboTecnicos]'
GO
use [LabMedicoDB5]
exec sp_addarticle @publication = N'RespaldoTotal', @article = N'Zonas', @source_owner = N'dbo', @source_object = N'Zonas', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Zonas', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboZonas]', @del_cmd = N'CALL [sp_MSdel_dboZonas]', @upd_cmd = N'SCALL [sp_MSupd_dboZonas]'
GO

-- Adding the transactional subscriptions
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'RespaldoTotal', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @destination_db = N'Total', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'RespaldoTotal', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @subscriber_db = N'Total', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-DESKTOP-BVUQAH4\TESTD-35', @dts_package_location = N'Distributor'
GO
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'RespaldoTotal', @subscriber = N'ISHIHARA\MEHPEYKER', @destination_db = N'Respaldo', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'RespaldoTotal', @subscriber = N'ISHIHARA\MEHPEYKER', @subscriber_db = N'Respaldo', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-ISHIHARA\MEHPEYKER-32', @dts_package_location = N'Distributor'
GO
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'RespaldoTotal', @subscriber = N'KURO\SQLEXPRESST1', @destination_db = N'Prueba2Nueva', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'RespaldoTotal', @subscriber = N'KURO\SQLEXPRESST1', @subscriber_db = N'Prueba2Nueva', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-31', @dts_package_location = N'Distributor'
GO
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'RespaldoTotal', @subscriber = N'KURO\SQLEXPRESST1', @destination_db = N'RESPALDOTEST', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'RespaldoTotal', @subscriber = N'KURO\SQLEXPRESST1', @subscriber_db = N'RESPALDOTEST', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-RespaldoTotal-KURO\SQLEXPRESST1-30', @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [LabMedicoDB5]
exec sp_addpublication @publication = N'Tecnicos', @description = N'Transactional publication of database ''LabMedicoDB5'' from Publisher ''DESKTOP-T67LOK0\DISTTEST''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Tecnicos', @snapshot_job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Tecnicos-9', @job_login = null, @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N''
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'DESKTOP-T67LOK0\Anselmo-LT'
GO
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'NT SERVICE\SQLAgent$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'NT Service\MSSQL$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Tecnicos', @login = N'distributor_admin'
GO

-- Adding the transactional articles
use [LabMedicoDB5]
exec sp_addarticle @publication = N'Tecnicos', @article = N'Tecnicos', @source_owner = N'dbo', @source_object = N'Tecnicos', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Tecnicos', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboTecnicos]', @del_cmd = N'CALL [sp_MSdel_dboTecnicos]', @upd_cmd = N'SCALL [sp_MSupd_dboTecnicos]'
GO

-- Adding the transactional subscriptions
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'Tecnicos', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @destination_db = N'Tecnicos', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Tecnicos', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @subscriber_db = N'Tecnicos', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Tecnicos-DESKTOP-BVUQAH4\TESTD-36', @dts_package_location = N'Distributor'
GO

-- Adding the transactional publication
use [LabMedicoDB5]
exec sp_addpublication @publication = N'Usuarios', @description = N'Transactional publication of database ''LabMedicoDB5'' from Publisher ''DESKTOP-T67LOK0\DISTTEST''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Usuarios', @snapshot_job_name = N'DESKTOP-T67LOK0\DISTTEST-LabMedicoDB5-Usuarios-8', @job_login = null, @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N''
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'DESKTOP-T67LOK0\Anselmo-LT'
GO
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'NT SERVICE\SQLAgent$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'NT Service\MSSQL$DISTTEST'
GO
exec sp_grant_publication_access @publication = N'Usuarios', @login = N'distributor_admin'
GO

-- Adding the transactional articles
use [LabMedicoDB5]
exec sp_addarticle @publication = N'Usuarios', @article = N'AspNetUsers', @source_owner = N'dbo', @source_object = N'AspNetUsers', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'AspNetUsers', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboAspNetUsers]', @del_cmd = N'CALL [sp_MSdel_dboAspNetUsers]', @upd_cmd = N'SCALL [sp_MSupd_dboAspNetUsers]'
GO

-- Adding the transactional subscriptions
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'Usuarios', @subscriber = N'DESKTOP-BVUQAH4\MSSQLSERVER16', @destination_db = N'Usuarios', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Usuarios', @subscriber = N'DESKTOP-BVUQAH4\MSSQLSERVER16', @subscriber_db = N'Usuarios', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\MSSQL-27', @dts_package_location = N'Distributor'
GO
use [LabMedicoDB5]
exec sp_addsubscription @publication = N'Usuarios', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @destination_db = N'Usuarios', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'Usuarios', @subscriber = N'DESKTOP-BVUQAH4\TESTDDB', @subscriber_db = N'Usuarios', @job_login = null, @job_password = null, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = null, @job_name = N'DESKTOP-T67LOK0\DISTT-LabMedicoDB5-Usuarios-DESKTOP-BVUQAH4\TESTD-37', @dts_package_location = N'Distributor'
GO



