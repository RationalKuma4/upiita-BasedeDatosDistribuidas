IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertHistoricos') 
BEGIN
	DROP PROCEDURE [dbo].[InsertHistoricos]
END
GO
CREATE PROCEDURE [dbo].[InsertHistoricos]
	@CitaId	INT = 0,
	@FechaRegistro	DATETIME = NULL,
	@Monto	DECIMAL = 0
AS
BEGIN 
	INSERT INTO [dbo].[Historicos]
			   ([CitaId]
			   ,[FechaRegistro]
			   ,[Monto])
		 VALUES
			   (@CitaId
			   ,@FechaRegistro
			   ,@Monto);
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateHistoricos') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateHistoricos]
END
GO
CREATE PROCEDURE [dbo].[UpdateHistoricos]
	@HistoricoId	INT = 0,
	@CitaId			INT = 0,
	@FechaRegistro	DATETIME = NULL,
	@Monto			DECIMAL = 0
AS
BEGIN 
	UPDATE [dbo].[Historicos]
	   SET [CitaId] = @CitaId
		  ,[FechaRegistro] = @FechaRegistro
		  ,[Monto] = @Monto
	 WHERE HistoricoId = @HistoricoId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosHistoricos') 
BEGIN
	DROP PROCEDURE [dbo].[VariosHistoricos]
END
GO
CREATE PROCEDURE [dbo].[VariosHistoricos]
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN 
	SELECT [HistoricoId]
		  ,[CitaId]
		  ,[FechaRegistro]
		  ,[Monto]
	  FROM [dbo].[Historicos]
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneHistoricos') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneHistoricos]
END
GO
CREATE PROCEDURE [dbo].[GetOneHistoricos]
	@HistoricoId	INT = 0
AS
BEGIN 
	SELECT [HistoricoId]
		  ,[CitaId]
		  ,[FechaRegistro]
		  ,[Monto]
	  FROM [dbo].[Historicos]
	  WHERE HistoricoId = @HistoricoId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteHistoricos') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteHistoricos]
END
GO
CREATE PROCEDURE [dbo].[DeleteHistoricos]
	@HistoricoId	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Historicos]
	WHERE HistoricoId = @HistoricoId
END
GO
