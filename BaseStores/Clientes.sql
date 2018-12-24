IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertClientes') 
BEGIN
	DROP PROCEDURE [dbo].[InsertClientes]
END
GO
CREATE PROCEDURE [dbo].[InsertClientes]
	@Nombre		VARCHAR(MAX) = NULL,
	@ApellidoPaterno	VARCHAR(MAX) = NULL,
	@ApellidoMaterno	VARCHAR(MAX) = NULL,
	@Telefono			VARCHAR(MAX) = NULL,
	@Celular			VARCHAR(50) = NULL,
	@Calle				VARCHAR(MAX) = NULL,
	@NumeroInterior		VARCHAR(MAX) = NULL,
	@NumeroExterior		VARCHAR(MAX) = NULL,
	@Colonia			VARCHAR(MAX) = NULL,
	@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	@CodigoPostal	INT = 0,
	@Sexo	VARCHAR(1) = NULL,
	@Peso	DECIMAL = 0,
	@Edad	INT = 0,
	@Estatus	VARCHAR(3) = NULL
AS
BEGIN 
	INSERT INTO [dbo].[Clientes]
	([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Telefono],[Celular],[Calle]
	,[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo]
	,[Peso],[Edad],[Estatus])
	VALUES
		(@Nombre,@ApellidoPaterno,@ApellidoMaterno,@Telefono,@Celular			
		,@Calle,@NumeroInterior,@NumeroExterior,@Colonia,@DelegacionMunicipio
		,@CodigoPostal,@Sexo,@Peso,@Edad,@Estatus);
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateClientes') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateClientes]
END
GO
CREATE PROCEDURE [dbo].[UpdateClientes]
	@ClienteId			int = 0,
	@Nombre		VARCHAR(MAX) = NULL,
	@ApellidoPaterno	VARCHAR(MAX) = NULL,
	@ApellidoMaterno	VARCHAR(MAX) = NULL,
	@Telefono			VARCHAR(MAX) = NULL,
	@Celular			VARCHAR(50) = NULL,
	@Calle				VARCHAR(MAX) = NULL,
	@NumeroInterior		VARCHAR(MAX) = NULL,
	@NumeroExterior		VARCHAR(MAX) = NULL,
	@Colonia			VARCHAR(MAX) = NULL,
	@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	@CodigoPostal	INT = 0,
	@Sexo	VARCHAR(1) = NULL,
	@Peso	DECIMAL = 0,
	@Edad	INT = 0,
	@Estatus	VARCHAR(3) = NULL
AS
BEGIN 
	UPDATE [dbo].[Clientes]
	   SET [Nombre] = @Nombre
		  ,[ApellidoPaterno] = @ApellidoPaterno
		  ,[ApellidoMaterno] = @ApellidoMaterno
		  ,[Telefono] = @Telefono
		  ,[Celular] = @Celular
		  ,[Calle] = @Calle
		  ,[NumeroInterior] = @NumeroInterior
		  ,[NumeroExterior] = @NumeroExterior
		  ,[Colonia] = @Colonia 
		  ,[DelegacionMunicipio] = @DelegacionMunicipio
		  ,[CodigoPostal] = @CodigoPostal
		  ,[Sexo] = @Sexo
		  ,[Peso] = @Peso
		  ,[Edad] = @Edad
		  ,[Estatus] = @Estatus
	 WHERE ClienteId = @ClienteId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosClientes') 
BEGIN
	DROP PROCEDURE [dbo].[VariosClientes]
END
GO
CREATE PROCEDURE [dbo].[VariosClientes]
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
	  FROM [dbo].[Clientes]
		WHERE Nombre LIKE '%' + @nOMBRE + '%'
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneClientes') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneClientes]
END
GO
CREATE PROCEDURE [dbo].[GetOneClientes]
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
	  FROM [dbo].[Clientes]
	  WHERE ClienteId = @ClienteId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteClientes') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteClientes]
END
GO
CREATE PROCEDURE [dbo].[DeleteClientes]
	@ClienteId	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Clientes]
	WHERE ClienteId = @ClienteId
END
GO
