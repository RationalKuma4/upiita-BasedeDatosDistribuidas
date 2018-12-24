IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertCitas') 
BEGIN
	DROP PROCEDURE [dbo].[InsertCitas]
END
GO
CREATE PROCEDURE [dbo].[InsertCitas]
	@FechaRegistro		VARCHAR(MAX) = NULL,
	@FechaEntrega		VARCHAR(MAX) = NULL,
	@FechaAplicacion		VARCHAR(MAX) = NULL,
	@HoraAplicacion		VARCHAR(MAX) = NULL,
	@UsuarioId		VARCHAR(50) = NULL,
	@ClienteId		VARCHAR(50) = NULL,
	@AnalisisId		VARCHAR(MAX) = NULL,
	@TecnicoId		VARCHAR(MAX) = NULL,
	@Estatus		INT = 0
AS
BEGIN 
	INSERT INTO [dbo].[Citas]
	([FechaRegistro],[FechaEntrega],[FechaAplicacion],[HoraAplicacion],[Id]
	,[ClienteId],[AnalisisId],[TecnicoId],[Estatus])
	VALUES
	(<FechaRegistro, datetime,>
	,<FechaEntrega, datetime,>
	,<FechaAplicacion, datetime,>
	,<HoraAplicacion, varchar(100),>
	,<Id, int,>
	,<ClienteId, int,>
	,<AnalisisId, int,>
	,<TecnicoId, int,>
	,<Estatus, varchar(3),>)
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UpdateCitas') 
BEGIN
	DROP PROCEDURE [dbo].[UpdateCitas]
END
GO
CREATE PROCEDURE [dbo].[UpdateCitas]
	@CitasId			int = 0,
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
	UPDATE [dbo].[Citas]
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
	 WHERE CitasId = @CitasId
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosCitas') 
BEGIN
	DROP PROCEDURE [dbo].[VarioCitas]
END
GO
CREATE PROCEDURE [dbo].[VarioCitas]
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN 
	SELECT [CitasId]
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
	  FROM [dbo].[Citas]
	  WHERE Nombre LIKE '%' + @nOMBRE + '%'
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='GetOneCitas') 
BEGIN
	DROP PROCEDURE [dbo].[GetOneCitas]
END
GO
CREATE PROCEDURE [dbo].[GetOneCitas]
	@tECNICO_ID	INT = 0
AS
BEGIN 
	SELECT [CitasId]
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
	  FROM [dbo].[Citas]
	  WHERE CitasId = @tECNICO_ID
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='DeleteCitas') 
BEGIN
	DROP PROCEDURE [dbo].[DeleteCitas]
END
GO
CREATE PROCEDURE [dbo].[DeleteCitas]
	@tECNICO_ID	INT = 0
AS
BEGIN 
	DELETE FROM [dbo].[Citas]
		  WHERE CitasId = @tECNICO_ID
END
GO
