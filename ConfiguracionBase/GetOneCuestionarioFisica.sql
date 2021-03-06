USE [HS_BI_WEB]
GO
/****** Object:  StoredProcedure [dbo].[GetOneCuestionarioFisica]    Script Date: 24/11/2016 08:42:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetOneCuestionarioFisica] --277
	@cLIENTE_ID	INT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @GRUPO_ID INT = (SELECT ISNULL(C.GRUPO_ID, 0)
							FROM	HS_CLIENTES C
							WHERE	C.CLIENTE_ID = @cLIENTE_ID),
			@gARANTIA_ID INT = 0

	SELECT	TOP 1
			@gARANTIA_ID = G.GARANTIA_ID
			FROM	HS_GARANTIAS G
			INNER	JOIN HS_CLIENTES C 
						ON C.CLIENTE_ID = G.CLIENTE_ID
			LEFT	JOIN HS_TIPO_CAMBIO_DIARIO T	
						ON	T.MONEDA_ID = G.MONEDA_ID 
						AND T.FECHA = (SELECT MAX(FECHA) FROM HS_TIPO_CAMBIO_DIARIO WHERE MONEDA_ID = G.MONEDA_ID)
			LEFT	JOIN HS_MONEDAS MON 
						ON G.MONEDA_ID = MON.MONEDA_ID
			LEFT	JOIN HS_TIPOS_GARANTIAS TG 
						ON TG.TIPO_GARANTIA = G.TIPO_GARANTIA
			WHERE	G.ESTATUS_GARANTIA = 'CO' 
			AND		((G.TIPO_GARANTIA = 'ESF'
					AND   G.GARANTIA_ID = (SELECT TOP 1 GARANTIA_ID FROM HS_GARANTIAS EF WHERE EF.CLIENTE_ID = G.CLIENTE_ID AND EF.TIPO_GARANTIA = 'ESF' AND EF.ESTATUS_GARANTIA = 'CO' 
					ORDER BY EF.GARANTIA_ID DESC))
					OR G.TIPO_GARANTIA != 'ESF')
			AND		EXISTS (SELECT	1
							FROM	HS_CLIENTES
							WHERE	CLIENTE_ID = G.CLIENTE_ID
							AND		CLIENTE_ID = @cLIENTE_ID
							UNION ALL
							SELECT	1
							FROM	HS_OBLIGADOS_SOLIDARIOS
							WHERE	CLIENTE_ID = @cLIENTE_ID
							AND		OBLIGADO_ID = G.CLIENTE_ID
							AND		OBLIGADO_ID != @cLIENTE_ID
							AND		@GRUPO_ID = 0
							UNION ALL
							SELECT	1
							FROM	HS_CLIENTES
							WHERE	CLIENTE_ID = G.CLIENTE_ID
							AND		CLIENTE_ID != @cLIENTE_ID
							AND		GRUPO_ID = @GRUPO_ID)
			AND		G.CLIENTE_ID = @cLIENTE_ID
			AND		G.TIPO_GARANTIA = 'ESF'
			ORDER	BY G.GARANTIA_ID DESC 

	SELECT	C.CLIENTE_ID,
			ISNULL(C.RAZON_SOCIAL, C.NOMBRE + ' '+ C.APELLIDO_PATERNO + ' '+ C.APELLIDO_MATERNO) AS 'NOMBE_CLIENTE',
			C.RFC,
			C.TELEFONO AS 'TELEFONO_OFICINA',
			'' AS 'TELEFONO_CELULAR',
			'' AS 'TELEFONO_PARTICULAR',
			C.CP AS 'CODIGO_POSTAL',
			C.CALLE + ' NUM. EXT. ' + CAST(ISNULL(C.NUMERO_EXTERIOR, 0 ) AS nvarchar) + ' NUM. INT. ' + CAST(ISNULL(C.NUMERO_INTERIOR, 0) AS nvarchar) AS 'DOMICILIO',
			C.COLONIA,
			C.DELEGACION,
			C.CIUDAD,
			E.NOMBRE AS 'NOMBRE_ESTADO',
			CASE C.NACIONALIDAD
				WHEN 'NAC' THEN 'NACIONAL'
				WHEN 'EXT' THEN 'EXTRANJERO'
			END AS 'NACIONALIDAD',
			C.EMAIL AS 'CORREO_PERSONAL',
			'' AS 'CORREO_OFICINA',
			'' AS 'DOCUMENTOS_ACREDITACION',
			'' AS 'OBTENCION_FIANZAS',
			CASE C.ESTADO_CIVIL
				WHEN 'OTR' THEN 'OTRO'
				WHEN 'SOL' THEN 'SOLTERO'
				WHEN 'CAS' THEN 'CASADO'
				WHEN 'DIV' THEN 'DIVORCIADO'
				WHEN 'VIU' THEN 'VIUDO'
				ELSE 'N/A'
			END AS 'ESTADO_CIVIL',
			CASE C.REGIMEN_PATRIMONIAL
				WHEN 'SPB' THEN 'SEPARACIÓN DE BIENES'
				WHEN 'BMC' THEN 'BIENES MANCOMUNADOS'
				ELSE 'N/A'
			END AS 'REGIMEN_PATRIMONIAL',
			ISNULL(C.NOMBRE_CONYUGE, 'N/A') AS 'NOMBRE_CONYUGE',
			ISNULL(C.PROFESION, 'N/A') AS 'PROFESION',
			ISNULL(C.EMPRESA, 'N/A') AS 'EMPRESA',
			ISNULL(C.PUESTO, 'N/A') AS 'PUESTO',
			ISNULL(C.ANTIGUEDAD, 'N/A') AS 'ANTIGUEDAD',
			ISNULL(C.DOMICILIO_EMPRESA, 'N/A') AS 'DOMICILIO_EMPRESA',
			ISNULL(C.TELEFONO_EMPRESA, 'N/A') AS 'TELEFONO_EMPRESA',
			ISNULL(C.OTRAS_ACTIVIDADES, 'N/A') AS 'OTRAS_ACTIVIDADES',
			ISNULL(C.INGRESOS, 0) AS 'INGRESOS',
			ISNULL(Z.RELACION, 'N/A') AS 'RELACION',
			'PFI' AS 'REGIMEN_FISCAL',
			@gARANTIA_ID AS 'GARANTIA_ID'
	FROM	HS_CLIENTES C
	LEFT	JOIN HS_ESTADOS E
				ON E.ESTADO_ID = C.ESTADO_ID
	LEFT	JOIN (SELECT	TOP 1 O.OBLIGADO_ID, O.RELACION
					FROM	HS_OBLIGADOS_SOLIDARIOS O
					WHERE	O.OBLIGADO_ID = @cLIENTE_ID
					AND		O.ESTATUS = 'ACT') Z
				ON Z.OBLIGADO_ID = C.CLIENTE_ID
	WHERE	C.CLIENTE_ID = @cLIENTE_ID
	SET NOCOUNT OFF
END
