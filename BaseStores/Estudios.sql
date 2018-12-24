IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertEstudios') 
BEGIN
	DROP PROCEDURE [dbo].[InsertEstudios]
END
GO
CREATE PROCEDURE [dbo].[InsertEstudios]
	@nOMBRE	VARCHAR(100) = NULL,
	@dESCRIPCION	VARCHAR(MAX) = NULL,
	@eSTATUS	VARCHAR(3) = NULL
AS
BEGIN 
	INSERT INTO [dbo].[Estudios]
	([Nombre],[Descripcion],[Estatus])
     VALUES
           (@nOMBRE, @dESCRIPCION, @eSTATUS)
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateEstudios') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateEstudios]
END
GO
CREATE PROCEDURE [dbo].[UpdateEstudios]
	@eSTUDIO_ID	INT = 0,
	@nOMBRE	VARCHAR(100) = NULL,
	@dESCRIPCION	VARCHAR(MAX) = NULL,
	@eSTATUS	VARCHAR(3) = NULL
AS
BEGIN 
	UPDATE [dbo].[Estudios]
	   SET [Nombre] = @nOMBRE
		  ,[Descripcion] = @dESCRIPCION
		  ,[Estatus] = @eSTATUS
	 WHERE EstudioId = @eSTUDIO_ID
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosEstudios') 
BEGIN
	DROP PROCEDURE [dbo].[VarioEstudios]
END
GO
CREATE PROCEDURE [dbo].[VariosEstudios]
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN 
	SELECT [EstudioId]
		  ,[Nombre]
		  ,[Descripcion]
		  ,[Estatus]
	  FROM [dbo].[Estudios]
	  WHERE Nombre LIKE '%' + @nOMBRE + '%'
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneEstudios') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneEstudios]
END
GO
CREATE PROCEDURE [dbo].[GetOneEstudios]
	@eSTUDIO_ID	INT = 0
AS
BEGIN 
	SELECT [EstudioId]
		  ,[Nombre]
		  ,[Descripcion]
		  ,[Estatus]
	  FROM [dbo].[Estudios]
	  WHERE EstudioId = @eSTUDIO_ID
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteEstudios') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteEstudios]
END
GO
CREATE PROCEDURE [dbo].[DeleteEstudios]
	@eSTUDIO_ID	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Estudios]
    WHERE EstudioId = @eSTUDIO_ID
END
GO
