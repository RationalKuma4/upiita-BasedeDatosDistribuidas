--DROP DATABASE Medico3
CREATE DATABASE Medico3
USE Medico3


IF EXISTS (SELECT * FROM sysobjects WHERE name='Estudios') 
BEGIN
	DROP TABLE [dbo].[Estudios]
END
GO
CREATE TABLE Estudios
(
	CategoriaId	int	not null IDENTITY(1,1),
	Nombre		varchar(500) null,
	Descripcion	varchar(2000) null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (CategoriaId)
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Analisis') 
BEGIN
	DROP TABLE [dbo].[Analisis]
END
GO
CREATE TABLE Analisis
(
	AnalisisId	int not null IDENTITY(1,1),
	Nombre		varchar(500) null,
	Descripcion	varchar(2000) null,
	Requisitos	varchar(2000) null,
	CategoriaId	int not null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (AnalisisId),
	FOREIGN KEY (CategoriaId) REFERENCES Estudios
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Sucursales') 
BEGIN
	DROP TABLE [dbo].[Sucursales]
END
GO
CREATE TABLE Sucursales
(
	SucursalId	int not null IDENTITY(1,1),
	Nombre		varchar(100) null,
	Calle		varchar(100) null,
	NumeroInterior	varchar(100) null,
	NumeroExterior	varchar(100) null,
	Colonia		varchar(100) null,
	DelegacionMunicipio	varchar(100) null,
	CodigoPostal	varchar(50) null,
	Telefono	varchar(100) null,
	Horario		varchar(100) null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (SucursalId)
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='AnalisisSucursal') 
BEGIN
	DROP TABLE [dbo].[AnalisisSucursal]
END
GO
CREATE TABLE AnalisisSucursal
(
	AnalisisSucursalId	int not null IDENTITY(1,1),
	SucursalId	int not null,
	AnalisisId	int not null,
	Costo		decimal(10, 2) null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (AnalisisSucursalId),
	FOREIGN KEY (SucursalId) REFERENCES Sucursales,
	FOREIGN KEY (AnalisisId) REFERENCES Analisis
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Usuarios') 
BEGIN
	DROP TABLE [dbo].[Usuarios]
END
GO
CREATE TABLE Usuarios
(
	UsuarioId	int not null IDENTITY(1,1),
	Usuario		varchar(50) not null,
	Nombre		varchar(100) null,
	ApellidoPaterno	varchar(100) null,
	ApellidoMaterno	varchar(100) null,
	Calle		varchar(100) null,
	NumeroInterior	varchar(100) null,
	NumeroExterior	varchar(100) null,
	Colonia		varchar(100) null,
	DelegacionMunicipio	varchar(100) null,
	CodigoPostal	int null,
	Estado		varchar(100) null,
	Edad		int null,
	Sexo		varchar(3) null,
	Notas		varchar(500) null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (UsuarioId)
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='UsuariosSucursal') 
BEGIN
	DROP TABLE [dbo].[UsuariosSucursal]
END
GO
CREATE TABLE UsuariosSucursal
(
	UsuarioSucursalId int not null IDENTITY(1,1),
	UsuarioId	int not null,
	SucursalId	int not null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (UsuarioSucursalId),
	FOREIGN KEY (UsuarioId) REFERENCES Usuarios,
	FOREIGN KEY (SucursalId) REFERENCES Sucursales
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Tecnicos') 
BEGIN
	DROP TABLE [dbo].[Tecnicos]
END
GO
CREATE TABLE Tecnicos
(
	TecnicoId	int not null IDENTITY(1,1),
	Nombre		varchar(100) null,
	ApellidoPaterno	varchar(100) null,
	ApellidoMaterno	varchar(100) null,
	Calle		varchar(100) null,
	NumeroInterior	varchar(100) null,
	NumeroExterior	varchar(100) null,
	Colonia		varchar(100) null,
	DelegacionMunicipio	varchar(100) null,
	CodigoPostal	int null,
	Estado		varchar(100) null,
	Edad		int null,
	Sexo		varchar(3) null,
	Notas		varchar(500) null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (TecnicoId)
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='TecnicoAnalisis') 
BEGIN
	DROP TABLE [dbo].[TecnicoAnalisis]
END
GO
CREATE TABLE TecnicoAnalisis
(
	TecnicoAnalisisId int not null IDENTITY(1,1),
	TecnicoId	int not null,
	AnalisisSucursalId	int not null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (TecnicoAnalisisId),
	FOREIGN KEY (TecnicoId) REFERENCES Tecnicos,
	FOREIGN KEY (AnalisisSucursalId) REFERENCES AnalisisSucursal
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Clientes') 
BEGIN
	DROP TABLE [dbo].[Clientes]
END
GO
CREATE TABLE Clientes
(
	ClienteId	int not null IDENTITY(1,1),
	Nombre		varchar(100) null,
	ApellidoPaterno	varchar(100) null,
	ApellidoMaterno	varchar(100) null,
	Telefono	varchar(50) null,
	Celular		varchar(50) null,
	Calle		varchar(100) null,
	NumeroInterior	varchar(100) null,
	NumeroExterior	varchar(100) null,
	Colonia		varchar(100) null,
	DelegacionMunicipio	varchar(100) null,
	CodigoPostal	int null,
	Sexo		varchar(1) null,
	Peso		decimal(5, 2) null,
	Edad		int not null,
	Estatus		varchar(3) null default 'Act'

	PRIMARY KEY (ClienteId)
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Citas') 
BEGIN
	DROP TABLE [dbo].[Citas]
END
GO
CREATE TABLE Citas
(
	CitaId	int not null IDENTITY(1,1),
	FechaRegistro	datetime null,
	FechaEntrega	datetime null,
	FechaAplicacion	datetime null,
	HoraAplicacion	varchar(100),
	UsuarioId	int not null,
	ClienteId	int not null,
	AnalisisId	int not null,
	TecnicoAnalisisId	int not null

	PRIMARY KEY (CitaId),
	FOREIGN KEY (UsuarioId) REFERENCES Usuarios,
	FOREIGN KEY (ClienteId) REFERENCES Clientes,
	FOREIGN KEY (TecnicoAnalisisId) REFERENCES TecnicoAnalisis
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Historicos') 
BEGIN
	DROP TABLE [dbo].[Historicos]
END
GO
CREATE TABLE Historicos
(
	HistoricoId int not null IDENTITY(1,1),
	CitaId		int not null,
	FechaRegistro	datetime null

	PRIMARY KEY (HistoricoId),
	FOREIGN KEY (CitaId) REFERENCES Citas
)
GO
