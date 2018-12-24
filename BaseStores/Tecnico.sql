IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertTecnico') 
BEGIN
	DROP PROCEDURE [dbo].[InsertTecnico]
END
GO
CREATE PROCEDURE [dbo].[InsertTecnico]
	@Nombre				VARCHAR(MAX) = NULL,
	@ApellidoPaterno	VARCHAR(MAX) = NULL,
	@ApellidoMaterno	VARCHAR(MAX) = NULL,
	@Calle				VARCHAR(MAX) = NULL,
	@NumeroInterior		VARCHAR(50) = NULL,
	@NumeroExterior		VARCHAR(50) = NULL,
	@Colonia			VARCHAR(MAX) = NULL,
	@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	@CodigoPostal		INT = 0,
	@Estado				VARCHAR(30) = NULL,
	@Edad				INT = 0,
	@Sexo				VARCHAR(3) = NULL,
	@Notas				VARCHAR(MAX) = NULL,
	@Estatus			VARCHAR(3) = NULL,
	@SucursalId			INT = 0,
	@EstudioId			INT = 0
AS
BEGIN 
	INSERT INTO [dbo].[Tecnicos]
           ([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia]
           ,[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId])
	VALUES
    (@Nombre,@ApellidoPaterno,@ApellidoMaterno,@Calle,@NumeroInterior,@NumeroExterior		
	,@Colonia,@DelegacionMunicipio,@CodigoPostal,@Estado,@Edad,@Sexo,@Notas,@Estatus			
	,@SucursalId,@EstudioId)
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateTecnico') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateTecnico]
END
GO
CREATE PROCEDURE [dbo].[UpdateTecnico]
	@TecnicoId			int = 0,
	@Nombre				VARCHAR(MAX) = NULL,
	@ApellidoPaterno	VARCHAR(MAX) = NULL,
	@ApellidoMaterno	VARCHAR(MAX) = NULL,
	@Calle				VARCHAR(MAX) = NULL,
	@NumeroInterior		VARCHAR(50) = NULL,
	@NumeroExterior		VARCHAR(50) = NULL,
	@Colonia			VARCHAR(MAX) = NULL,
	@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	@CodigoPostal		INT = 0,
	@Estado				VARCHAR(30) = NULL,
	@Edad				INT = 0,
	@Sexo				VARCHAR(3) = NULL,
	@Notas				VARCHAR(MAX) = NULL,
	@Estatus			VARCHAR(3) = NULL,
	@SucursalId			INT = 0,
	@EstudioId			INT = 0
AS
BEGIN 
	UPDATE [dbo].[Tecnicos]
	   SET [Nombre] = @Nombre
		  ,[ApellidoPaterno] = @ApellidoPaterno
		  ,[ApellidoMaterno] = @ApellidoMaterno
		  ,[Calle] = @Calle
		  ,[NumeroInterior] = @NumeroInterior
		  ,[NumeroExterior] = @NumeroExterior
		  ,[Colonia] = @Colonia
		  ,[DelegacionMunicipio] = @DelegacionMunicipio
		  ,[CodigoPostal] = @CodigoPostal
		  ,[Estado] = @Estado
		  ,[Edad] = @Edad
		  ,[Sexo] = @Sexo
		  ,[Notas] = @Notas
		  ,[Estatus] = @Estatus
		  ,[SucursalId] = @SucursalId
		  ,[EstudioId] = @EstudioId
	 WHERE TecnicoId = @TecnicoId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosTecnico') 
BEGIN
	DROP PROCEDURE [dbo].[VarioTecnico]
END
GO
CREATE PROCEDURE [dbo].[VarioTecnico]
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN 
	SELECT [TecnicoId]
		  ,[Nombre]
		  ,[ApellidoPaterno]
		  ,[ApellidoMaterno]
		  ,[Calle]
		  ,[NumeroInterior]
		  ,[NumeroExterior]
		  ,[Colonia]
		  ,[DelegacionMunicipio]
		  ,[CodigoPostal]
		  ,[Estado]
		  ,[Edad]
		  ,[Sexo]
		  ,[Notas]
		  ,[Estatus]
		  ,[SucursalId]
		  ,[EstudioId]
	  FROM [dbo].[Tecnicos]
	  WHERE Nombre LIKE '%' + @nOMBRE + '%'
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneTecnico') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneTecnico]
END
GO
CREATE PROCEDURE [dbo].[GetOneTecnico]
	@tECNICO_ID	INT = 0
AS
BEGIN 
	SELECT [TecnicoId]
		  ,[Nombre]
		  ,[ApellidoPaterno]
		  ,[ApellidoMaterno]
		  ,[Calle]
		  ,[NumeroInterior]
		  ,[NumeroExterior]
		  ,[Colonia]
		  ,[DelegacionMunicipio]
		  ,[CodigoPostal]
		  ,[Estado]
		  ,[Edad]
		  ,[Sexo]
		  ,[Notas]
		  ,[Estatus]
		  ,[SucursalId]
		  ,[EstudioId]
	  FROM [dbo].[Tecnicos]
	  WHERE TecnicoId = @tECNICO_ID
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteTecnico') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteTecnico]
END
GO
CREATE PROCEDURE [dbo].[DeleteTecnico]
	@tECNICO_ID	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Tecnicos]
		  WHERE TecnicoId = @tECNICO_ID
END
GO
