IF EXISTS (SELECT * FROM sysobjects WHERE name='VariosClientes') 
BEGIN
	DROP PROCEDURE [dbo].[VariosClientes]
END
GO
CREATE PROCEDURE dbo.VariosClientes
	@nOMBRE	VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON
	SELECT	*
	FROM	Clientes
	WHERE	(@nOMBRE IS NULL OR Nombre LIKE @nOMBRE + '%')
	SET NOCOUNT OFF
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='AnalisisxSucursal') 
BEGIN
	DROP PROCEDURE [dbo].[AnalisisxSucursal]
END
GO
CREATE PROCEDURE dbo.AnalisisxSucursal --1
	@sUCURSAL_ID	INT = 0
AS
BEGIN
	SET NOCOUNT ON
	SELECT	AN.SucursalId, S.Nombre, AN.AnalisisId, A.Nombre
	FROM	AnalisisSucursal AN
	INNER	JOIN Sucursales S
			ON S.SucursalId = AN.SucursalId
	INNER	JOIN Analisis A
			ON	A.AnalisisId = AN.AnalisisId
	WHERE	AN.SucursalId = @sUCURSAL_ID
	SET NOCOUNT OFF
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UsuariosxSucursal') 
BEGIN
	DROP PROCEDURE [dbo].[UsuariosxSucursal] 
END
GO
CREATE PROCEDURE dbo.UsuariosxSucursal
	@sUCURSAL_ID	INT = 0
AS
BEGIN
	SET NOCOUNT ON
	SELECT	US.SucursalId, U.UsuarioId, U.Nombre, U.Usuario
	FROM	UsuariosSucursal US
	INNER	JOIN Usuarios U
			ON	US.UsuarioId = U.UsuarioId
	WHERE	US.SucursalId = @sUCURSAL_ID
	SET NOCOUNT OFF
END
GO

--IF EXISTS (SELECT * FROM sysobjects WHERE name='TecnicosxSucursal') 
--BEGIN
--	DROP PROCEDURE [dbo].[TecnicosxSucursal] 
--END
--GO
--CREATE PROCEDURE dbo.TecnicosxSucursal 1
--	@sUCURSAL_ID	INT = 0
--AS
--BEGIN
--	SET NOCOUNT ON
--	SELECT	AN.SucursalId, T.TecnicoId, T.Nombre
--	FROM	TecnicoAnalisis TA
--	INNER	JOIN AnalisisSucursal AN
--			ON TA.AnalisisSucursalId = TA.AnalisisSucursalId
--	INNER	JOIN Tecnicos T
--			ON T.TecnicoId = TA.TecnicoId
--	WHERE	AN.SucursalId = @sUCURSAL_ID
--	GROUP	BY T.TecnicoId, T.Nombre, AN.SucursalId
--	SET NOCOUNT OFF
--END
--GO



--;WITH Sucursal AS
--(
--	SELECT	A.AnalisisSucursalId, A.SucursalId, A.AnalisisId
--	FROM	AnalisisSucursal A
--	INNER	JOIN	TecnicoAnalisis T
--			ON	
--)

