IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertaTecnicos') 
BEGIN
	DROP TRIGGER [dbo].[InsertaTecnicos]
END
GO
CREATE TRIGGER dbo.InsertaTecnicos
	ON dbo.Tecnicos INSTEAD OF INSERT
AS
BEGIN
	DECLARE	@zONA_ID INT = (SELECT	TOP 1 S.ZonaId
							FROM	inserted I
							INNER	JOIN Sucursales S
										ON S.SucursalId = I.SucursalId),
			@ParmDefinition varchar(max) = null,
			@sERVER	VARCHAR(50) = '',
			@bASE	VARCHAR(50) = '',
			@eSQUEMA VARCHAR(50) = '',
			@strSQL	VARCHAR(500) = '',
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

	SELECT	@sERVER = D.NombreServidor,
			@bASE = D.BaseDatos,
			@eSQUEMA = D.Esquema
	FROM	DiccionarioFragmentos D
	WHERE	DiccionarioFragmentosId = @zONA_ID

	SELECT	@Nombre	= I.Nombre		
			,@ApellidoPaterno = I.ApellidoPaterno
			,@ApellidoMaterno = I.ApellidoMaterno
			,@Calle = I.Calle	
			,@NumeroInterior = I.NumeroInterior		
			,@NumeroExterior = I.NumeroExterior	
			,@Colonia = I.Colonia	
			,@DelegacionMunicipio = I.DelegacionMunicipio
			,@CodigoPostal = I.CodigoPostal
			,@Estado = I.Estado
			,@Edad = I.Edad
			,@Sexo = I.Sexo	
			,@Notas = I.Notas	
			,@Estatus = I.Estatus	
			,@SucursalId = I.SucursalId	
			,@EstudioId = I.EstudioId
	FROM	inserted I

	SET @strSQL = 'INSERT INTO [' + @sERVER + '].[' + @bASE + '].[' + @eSQUEMA + '].[Tecnicos]([Nombre]
           ,[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio]
           ,[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
		   VALUES(' 
		   + char(39) + @Nombre	+ char(39) + ',' +
		   + char(39) +@ApellidoPaterno + char(39)	 + ',' +
		   + char(39) +@ApellidoMaterno	 + char(39) + ',' +
		   + char(39) +@Calle + char(39)				 + ',' +
		   + char(39) +@NumeroInterior	+ char(39)	 + ',' +
		   + char(39) +@NumeroExterior + char(39)		 + ',' +
		   + char(39) +@Colonia	+ char(39)		 + ',' +
		   + char(39) +@DelegacionMunicipio + char(39) + ',' +
		   +  +CAST(@CodigoPostal AS varchar) 	 + ',' +
		   + char(39) +@Estado	+ char(39)			 + ',' +
		   +  +CAST(@Edad	AS varchar)	 + ',' +
		   + char(39) +@Sexo + char(39)				 + ',' +
		   + char(39) +@Notas + char(39)			 + ',' +
		   + char(39) +@Estatus	+ char(39)		 + ',' +
		   +  +CAST(@SucursalId AS varchar)		 + ',' +
		   +  +CAST(@EstudioId AS varchar) +')'

	print @strSQL
		   exec(@strSQL)
	--SET @ParmDefinition = N'
	--		@Nombre				VARCHAR(MAX) = NULL,
	--		@ApellidoPaterno	VARCHAR(MAX) = NULL,
	--		@ApellidoMaterno	VARCHAR(MAX) = NULL,
	--		@Calle				VARCHAR(MAX) = NULL,
	--		@NumeroInterior		VARCHAR(50) = NULL,
	--		@NumeroExterior		VARCHAR(50) = NULL,
	--		@Colonia			VARCHAR(MAX) = NULL,
	--		@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	--		@CodigoPostal		INT = 0,
	--		@Estado				VARCHAR(30) = NULL,
	--		@Edad				INT = 0,
	--		@Sexo				VARCHAR(3) = NULL,
	--		@Notas				VARCHAR(MAX) = NULL,
	--		@Estatus			VARCHAR(3) = NULL,
	--		@SucursalId			INT = 0,
	--		@EstudioId			INT = 0';  
	--PRINT @strSQL

	--EXECUTE sp_executesql   
	--	@strSQL,
	--	@ParmDefinition	
	--	,@pNombre					 = @Nombre				
	--	,@pApellidoPaterno			 = @ApellidoPaterno	
	--	,@pApellidoMaterno			 = @ApellidoMaterno	
	--	,@pCalle					 = @Calle				
	--	,@pNumeroInterior			 = @NumeroInterior		
	--	,@pNumeroExterior			 = @NumeroExterior		
	--	,@pColonia					 = @Colonia			
	--	,@pDelegacionMunicipio		 = @DelegacionMunicipio
	--	,@pCodigoPostal				 = @CodigoPostal		
	--	,@pEstado					 = @Estado				
	--	,@pEdad						 = @Edad				
	--	,@pSexo						 = @Sexo				
	--	,@pNotas					 = @Notas				
	--	,@pEstatus					 = @Estatus			
	--	,@pSucursalId				 = @SucursalId			
	--	,@pEstudioId				 = @EstudioId			

END 
GO


INSERT INTO [dbo].[Tecnicos]
           ([Nombre]
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
           ,[EstudioId])
     VALUES
           ('ABC'
           ,'ABC'
           ,'ABC'
           ,'ABC'
           ,'ABC'
           ,'ABC'
           ,'ABC'
           ,'ABC'
           ,55555
           ,'ASsdf'
           ,0
           ,'ABC'
           ,'ABC'
           ,'ABC'
           ,2
           ,2)
GO


EXECUTE sp_executesql   
          N'SELECT * FROM AdventureWorks2012.HumanResources.Employee   
          WHERE BusinessEntityID = @level',  
          N'@level tinyint',  
          @level = 109;  

SELECT	*
FROM	DiccionarioFragmentos


CREATE PROCEDURE executeSQLDynamic 
-- Add the parameters for the stored procedure here
@tablaName nvarchar(80), 
@colFiltro nvarchar (80),
@valCom nvarchar (80)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
DECLARE @strSQL nvarchar(200);
DECLARE @paramDefinition nvarchar(200);
SET @strSQL = N'SELECT * FROM ' + @tablaName + ' WHERE ' + @colFiltro + ' = @valor'; 
SET @paramDefinition = N'@valor varchar(200)';
EXEC sp_executeSQL @strSQL, @paramDefinition, @valor = @valCom;
END
GO
EXEC executeSQLDynamic @tablaName = N'sales.SalesOrderHeader', @colFiltro = N'salesOrderNumber', @valCom = N'SO43697';

INSERT INTO [192.168.1.76].[Medico].[dbo].[Tecnicos]([Nombre]
           ,[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio]
           ,[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
		   VALUES('ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC',55555,'ASsdf',0,'ABC','ABC','ABC',2,2)



IF EXISTS (SELECT * FROM sysobjects WHERE name='InsertaPTecnicos') 
BEGIN
	DROP PROCEDURE [dbo].[InsertaPTecnicos]
END
GO
CREATE PROCEDURE dbo.InsertaPTecnicos
	--ON dbo.Tecnicos INSTEAD OF INSERT
AS
BEGIN
	DECLARE	@zONA_ID INT = (SELECT	TOP 1 S.ZonaId
							FROM	inserted I
							INNER	JOIN Sucursales S
										ON S.SucursalId = I.SucursalId),
			@ParmDefinition varchar(max) = null,
			@sERVER	VARCHAR(50) = '',
			@bASE	VARCHAR(50) = '',
			@eSQUEMA VARCHAR(50) = '',
			@strSQL	VARCHAR(500) = '',
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

	SELECT	@sERVER = D.NombreServidor,
			@bASE = D.BaseDatos,
			@eSQUEMA = D.Esquema
	FROM	DiccionarioFragmentos D
	WHERE	DiccionarioFragmentosId = @zONA_ID

	SELECT	@Nombre	= I.Nombre		
			,@ApellidoPaterno = I.ApellidoPaterno
			,@ApellidoMaterno = I.ApellidoMaterno
			,@Calle = I.Calle	
			,@NumeroInterior = I.NumeroInterior		
			,@NumeroExterior = I.NumeroExterior	
			,@Colonia = I.Colonia	
			,@DelegacionMunicipio = I.DelegacionMunicipio
			,@CodigoPostal = I.CodigoPostal
			,@Estado = I.Estado
			,@Edad = I.Edad
			,@Sexo = I.Sexo	
			,@Notas = I.Notas	
			,@Estatus = I.Estatus	
			,@SucursalId = I.SucursalId	
			,@EstudioId = I.EstudioId
	FROM	inserted I

	SET @strSQL = 'INSERT INTO [' + @sERVER + '].[' + @bASE + '].[' + @eSQUEMA + '].[Tecnicos]([Nombre]
           ,[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio]
           ,[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
		   VALUES(' 
		   + char(39) + @Nombre	+ char(39) + ',' +
		   + char(39) +@ApellidoPaterno + char(39)	 + ',' +
		   + char(39) +@ApellidoMaterno	 + char(39) + ',' +
		   + char(39) +@Calle + char(39)				 + ',' +
		   + char(39) +@NumeroInterior	+ char(39)	 + ',' +
		   + char(39) +@NumeroExterior + char(39)		 + ',' +
		   + char(39) +@Colonia	+ char(39)		 + ',' +
		   + char(39) +@DelegacionMunicipio + char(39) + ',' +
		   +  +CAST(@CodigoPostal AS varchar) 	 + ',' +
		   + char(39) +@Estado	+ char(39)			 + ',' +
		   +  +CAST(@Edad	AS varchar)	 + ',' +
		   + char(39) +@Sexo + char(39)				 + ',' +
		   + char(39) +@Notas + char(39)			 + ',' +
		   + char(39) +@Estatus	+ char(39)		 + ',' +
		   +  +CAST(@SucursalId AS varchar)		 + ',' +
		   +  +CAST(@EstudioId AS varchar) +')'

	print @strSQL
		   exec(@strSQL)
	--SET @ParmDefinition = N'
	--		@Nombre				VARCHAR(MAX) = NULL,
	--		@ApellidoPaterno	VARCHAR(MAX) = NULL,
	--		@ApellidoMaterno	VARCHAR(MAX) = NULL,
	--		@Calle				VARCHAR(MAX) = NULL,
	--		@NumeroInterior		VARCHAR(50) = NULL,
	--		@NumeroExterior		VARCHAR(50) = NULL,
	--		@Colonia			VARCHAR(MAX) = NULL,
	--		@DelegacionMunicipio	VARCHAR(MAX) = NULL,
	--		@CodigoPostal		INT = 0,
	--		@Estado				VARCHAR(30) = NULL,
	--		@Edad				INT = 0,
	--		@Sexo				VARCHAR(3) = NULL,
	--		@Notas				VARCHAR(MAX) = NULL,
	--		@Estatus			VARCHAR(3) = NULL,
	--		@SucursalId			INT = 0,
	--		@EstudioId			INT = 0';  
	--PRINT @strSQL

	--EXECUTE sp_executesql   
	--	@strSQL,
	--	@ParmDefinition	
	--	,@pNombre					 = @Nombre				
	--	,@pApellidoPaterno			 = @ApellidoPaterno	
	--	,@pApellidoMaterno			 = @ApellidoMaterno	
	--	,@pCalle					 = @Calle				
	--	,@pNumeroInterior			 = @NumeroInterior		
	--	,@pNumeroExterior			 = @NumeroExterior		
	--	,@pColonia					 = @Colonia			
	--	,@pDelegacionMunicipio		 = @DelegacionMunicipio
	--	,@pCodigoPostal				 = @CodigoPostal		
	--	,@pEstado					 = @Estado				
	--	,@pEdad						 = @Edad				
	--	,@pSexo						 = @Sexo				
	--	,@pNotas					 = @Notas				
	--	,@pEstatus					 = @Estatus			
	--	,@pSucursalId				 = @SucursalId			
	--	,@pEstudioId				 = @EstudioId			

END 
GO
