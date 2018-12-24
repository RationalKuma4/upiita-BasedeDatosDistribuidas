IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertAnalisis') 
BEGIN
	DROP PROCEDURE [dbo].[InsertAnalisis]
END
GO
CREATE PROCEDURE [dbo].[InsertAnalisis]
	@nOMBRE		VARCHAR(100) = NULL,
	@dESCRIPCION	VARCHAR(MAX) = NULL,
	@rEQUISITOS	VARCHAR(MAX) = NULL,
	@eSTUDIO_ID	INT = 0,
	@eSTATUS	VARCHAR(3) = NULL
AS
BEGIN 
	INSERT INTO [dbo].[Analisis]
	([Nombre],[Descripcion],[Requisitos],[CategoriaId],[Estatus])
	VALUES
	(@nOMBRE,@dESCRIPCION,@rEQUISITOS,@eSTUDIO_ID,@eSTATUS)
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateAnalisis') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateAnalisis]
END
GO
CREATE PROCEDURE [dbo].[UpdateAnalisis]
	@aNALISIS_ID INT = 0,
	@nOMBRE		VARCHAR(100) = NULL,
	@dESCRIPCION	VARCHAR(MAX) = NULL,
	@rEQUISITOS	VARCHAR(MAX) = NULL,
	@eSTUDIO_ID	INT = 0,
	@eSTATUS	VARCHAR(3) = NULL
AS
BEGIN 
	UPDATE [dbo].[Analisis]
	   SET [Nombre] = @nOMBRE
		  ,[Descripcion] = @dESCRIPCION
		  ,[Requisitos] = @rEQUISITOS
		  ,[CategoriaId] = @eSTUDIO_ID
		  ,[Estatus] = @eSTATUS
	 WHERE CategoriaId = @aNALISIS_ID
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosAnalisis') 
BEGIN
	DROP PROCEDURE [dbo].[VarioAnalisis]
END
GO
CREATE PROCEDURE [dbo].[VariosAnalisis]
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN 
	SELECT [ServicioId]
		  ,[Nombre]
		  ,[Descripcion]
		  ,[Requisitos]
		  ,[CategoriaId]
		  ,[Estatus]
	  FROM [dbo].[Analisis]
	  WHERE	Nombre LIKE '%' + @nOMBRE + '%'
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneAnalisis') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneAnalisis]
END
GO
CREATE PROCEDURE [dbo].[GetOneAnalisis]
	@aNALISIS_ID	INT = 0
AS
BEGIN 
	SELECT [ServicioId]
		  ,[Nombre]
		  ,[Descripcion]
		  ,[Requisitos]
		  ,[CategoriaId]
		  ,[Estatus]
	  FROM [dbo].[Analisis]
	  WHERE	CategoriaId = @aNALISIS_ID
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteAnalisis') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteAnalisis]
END
GO
CREATE PROCEDURE [dbo].[DeleteAnalisis]
	@aNALISIS_ID	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Analisis]
    WHERE CategoriaId = @aNALISIS_ID
END
GO
