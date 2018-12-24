IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertEstudio') 
BEGIN
	DROP PROCEDURE [dbo].[InsertEstudio]
END
GO
CREATE PROCEDURE dbo.InsertEstudio
	@nombre			varchar(50) = null, 
	@Descripcion	varchar(50) = null 
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[Estudios]
           ([Nombre]
           ,[Descripcion]
           ,[Estatus])
     VALUES
           (@nombre
           ,@Descripcion
           ,'Act')
	SET NOCOUNT OFF;
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateEstudio') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateEstudio]
END
GO
CREATE PROCEDURE dbo.UpdateEstudio
	@nombre			varchar(50) = null, 
	@Descripcion	varchar(50) = null,
	@Estatus		varchar(3) = null,
	@EstudioId	int = 0 
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE	[dbo].[Estudios]
    SET		[Nombre] = @nombre
           ,[Descripcion] = @Descripcion
           ,[Estatus] = @Estatus
    WHERE	CategoriaId = @EstudioId
	SET NOCOUNT OFF;
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteEstudio') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteEstudio]
END
GO
CREATE PROCEDURE dbo.DeleteEstudio
	@EstudioId	int = 0 
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM [dbo].[Estudios]
      WHERE CategoriaId = @EstudioId
	SET NOCOUNT OFF;
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosEstudio') 
BEGIN
	DROP PROCEDURE [dbo].[VariosEstudio]
END
GO
CREATE PROCEDURE dbo.VariosEstudio
	@EstudioId	int = 0,
	@Nombre		varchar(50) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	[CategoriaId]
			,[Nombre]
			,[Descripcion]
			,[Estatus]
	FROM	[dbo].[Estudios]
	WHERE	(@EstudioId = 0 OR CategoriaId = @EstudioId)
	AND		(@Nombre IS NULL OR Nombre LIKE @Nombre + '%')
	SET NOCOUNT OFF;
END
GO