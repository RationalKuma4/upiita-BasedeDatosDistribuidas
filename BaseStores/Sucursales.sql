IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertSucursales') 
BEGIN
	DROP PROCEDURE [dbo].[InsertSucursales]
END
GO
CREATE PROCEDURE [dbo].[InsertSucursales]
	@Nombre				VARCHAR(MAX) = NULL,
	@Telefono			VARCHAR(MAX) = NULL,
	@Calle				VARCHAR(MAX) = NULL,
	@NumeroInterior		VARCHAR(MAX) = NULL,
	@NumeroExterior		VARCHAR(MAX) = NULL,
	@Colonia			VARCHAR(MAX) = NULL,
	@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	@CodigoPostal		INT = 0,
	@Estatus			VARCHAR(3) = NULL,
	@Horario			VARCHAR(MAX) = NULL,
	@ZonaId				INT = 0
AS
BEGIN 
	INSERT INTO [dbo].[Sucursales]
	([Nombre],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio]
	,[CodigoPostal],[Telefono],[Horario],[Estatus],[ZonaId])
	VALUES
	(@Nombre,@Calle,@NumeroInterior,@NumeroExterior,@Colonia,@DelegacionMunicipio
	,@CodigoPostal,@Telefono,@Horario,@Estatus,@ZonaId)
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateSucursales') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateSucursales]
END
GO
CREATE PROCEDURE [dbo].[UpdateSucursales]
	@SucursalId			int = 0,
	@Nombre				VARCHAR(MAX) = NULL,
	@Telefono			VARCHAR(MAX) = NULL,
	@Calle				VARCHAR(MAX) = NULL,
	@NumeroInterior		VARCHAR(MAX) = NULL,
	@NumeroExterior		VARCHAR(MAX) = NULL,
	@Colonia			VARCHAR(MAX) = NULL,
	@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	@CodigoPostal		INT = 0,
	@Estatus			VARCHAR(3) = NULL,
	@Horario			VARCHAR(MAX) = NULL,
	@ZonaId				INT = 0
AS
BEGIN 
	UPDATE [dbo].[Sucursales]
	   SET [Nombre] = @Nombre
		  ,[Calle] = @Calle
		  ,[NumeroInterior] = @NumeroInterior
		  ,[NumeroExterior] = @NumeroExterior
		  ,[Colonia] = @Colonia
		  ,[DelegacionMunicipio] = @DelegacionMunicipio
		  ,[CodigoPostal] = @CodigoPostal
		  ,[Telefono] = @Telefono
		  ,[Horario] = @Horario
		  ,[Estatus] = @Estatus
		  ,[ZonaId] = @ZonaId
	 WHERE SucursalId = @SucursalId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosSucursales') 
BEGIN
	DROP PROCEDURE [dbo].[VariosSucursales]
END
GO
CREATE PROCEDURE [dbo].[VariosSucursales]
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN 
	SELECT [ClienteId]
		  ,[Nombre]
		  ,[ApellidoPaterno]
		  ,[ApellidoMaterno]
		  ,[Telefono]
		  ,[Celular]
		  ,[Calle]
		  ,[NumeroInterior]
		  ,[NumeroExterior]
		  ,[Colonia]
		  ,[DelegacionMunicipio]
		  ,[CodigoPostal]
		  ,[Sexo]
		  ,[Peso]
		  ,[Edad]
		  ,[Estatus]
	  FROM [dbo].[Sucursales]
		WHERE Nombre LIKE '%' + @nOMBRE + '%'
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneSucursales') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneSucursales]
END
GO
CREATE PROCEDURE [dbo].[GetOneSucursales]
	@ClienteId	INT = 0
AS
BEGIN 
	SELECT [ClienteId]
		  ,[Nombre]
		  ,[ApellidoPaterno]
		  ,[ApellidoMaterno]
		  ,[Telefono]
		  ,[Celular]
		  ,[Calle]
		  ,[NumeroInterior]
		  ,[NumeroExterior]
		  ,[Colonia]
		  ,[DelegacionMunicipio]
		  ,[CodigoPostal]
		  ,[Sexo]
		  ,[Peso]
		  ,[Edad]
		  ,[Estatus]
	  FROM [dbo].[Sucursales]
	  WHERE ClienteId = @ClienteId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteSucursales') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteSucursales]
END
GO
CREATE PROCEDURE [dbo].[DeleteSucursales]
	@ClienteId	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Sucursales]
	WHERE ClienteId = @ClienteId
END
GO
