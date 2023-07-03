USE [GD1C2023]
GO

------------- LIMPIAR FUNCIONES----------------------

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_RANGO_ETARIO')
	DROP FUNCTION D_DE_DATOS.CALCULAR_RANGO_ETARIO;
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_RANGO_HORARIO')
	DROP FUNCTION D_DE_DATOS.CALCULAR_RANGO_HORARIO;
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_DIA_SEMANA')
	DROP FUNCTION D_DE_DATOS.CALCULAR_DIA_SEMANA;
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_DESVIO_ENTREGA')
	DROP FUNCTION D_DE_DATOS.CALCULAR_DESVIO_ENTREGA;
GO
------------- LIMPIAR TABLAS  ------------------------


IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_SERVICIOS_MENSAJERIA')
	DROP TABLE D_DE_DATOS.BI_SERVICIOS_MENSAJERIA;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RECLAMOS')
	DROP TABLE D_DE_DATOS.BI_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_PEDIDOS')
	DROP TABLE D_DE_DATOS.BI_PEDIDOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIPOS_RECLAMOS')
	DROP TABLE D_DE_DATOS.BI_TIPOS_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_ESTADOS_MENSAJERIA')
	DROP TABLE D_DE_DATOS.BI_ESTADOS_MENSAJERIA;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_ESTADOS_PEDIDOS')
	DROP TABLE D_DE_DATOS.BI_ESTADOS_PEDIDOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIPOS_PAQUETES')
	DROP TABLE D_DE_DATOS.BI_TIPOS_PAQUETES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIPOS_MOVILIDAD')
	DROP TABLE D_DE_DATOS.BI_TIPOS_MOVILIDAD;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_LOCALES')
	DROP TABLE D_DE_DATOS.BI_LOCALES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_CATEGORIAS_LOCALES')
	DROP TABLE D_DE_DATOS.BI_CATEGORIAS_LOCALES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIPOS_LOCALES')
	DROP TABLE D_DE_DATOS.BI_TIPOS_LOCALES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_LOCALIDADES')
	DROP TABLE D_DE_DATOS.BI_LOCALIDADES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RANGO_ETARIO')
	DROP TABLE D_DE_DATOS.BI_RANGO_ETARIO;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RANGO_HORARIO')
	DROP TABLE D_DE_DATOS.BI_RANGO_HORARIO;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_DIAS')
	DROP TABLE D_DE_DATOS.BI_DIAS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIEMPO')
	DROP TABLE D_DE_DATOS.BI_TIEMPO;
GO

------------------LIMPIAR PROCEDURES ---------------------------

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIEMPO')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_TIEMPO;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_DIAS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_DIAS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RANGO_HORARIO')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_RANGO_HORARIO;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RANGO_ETARIO')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_RANGO_ETARIO;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_LOCALIDADES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALIDADES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPOS_LOCALES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_LOCALES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_CATEGORIAS_LOCALES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_CATEGORIAS_LOCALES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_LOCALES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPOS_MOVILIDAD')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_MOVILIDAD;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPOS_PAQUETES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_PAQUETES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_ESTADOS_PEDIDOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_ESTADOS_PEDIDOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_ESTADOS_MENSAJERIA')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_ESTADOS_MENSAJERIA;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPOS_RECLAMOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_PEDIDOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RECLAMOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_RECLAMOS;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_SERVICIOS_MENSAJERIA')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_SERVICIOS_MENSAJERIA;

---------------------- LIMPIAR VISTAS ----------------------
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'MAYOR_CANTIDAD_PEDIDOS')
	DROP VIEW D_DE_DATOS.MAYOR_CANTIDAD_PEDIDOS;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'MONTO_NO_COBRADO_LOCALES')
	DROP VIEW D_DE_DATOS.MONTO_NO_COBRADO_LOCALES;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'PROMEDIO_PRECIO_ENVIOS_POR_LOCALIDAD')
	DROP VIEW D_DE_DATOS.PROMEDIO_PRECIO_ENVIOS_POR_LOCALIDAD;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'DESVIOS_PROMEDIO')
	DROP VIEW D_DE_DATOS.DESVIOS_PROMEDIO;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'MONTO_TOTAL_CUPONES')
	DROP VIEW D_DE_DATOS.MONTO_TOTAL_CUPONES;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'PROMEDIO_CALIFICACION_MENSUAL_POR_LOCAL')
	DROP VIEW D_DE_DATOS.PROMEDIO_CALIFICACION_MENSUAL_POR_LOCAL;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'PORCENTAJE_PEDIDOS_Y_ENVIOS_ENTREGADOS')
	DROP VIEW D_DE_DATOS.PORCENTAJE_PEDIDOS_Y_ENVIOS_ENTREGADOS;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'PROMEDIO_VALOR_ASEGURADO')
	DROP VIEW D_DE_DATOS.PROMEDIO_VALOR_ASEGURADO;
	
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'CANTIDAD_RECLAMOS')
	DROP VIEW D_DE_DATOS.CANTIDAD_RECLAMOS;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'PROMEDIO_TIEMPO_SOLUCION_RECLAMOS')
	DROP VIEW D_DE_DATOS.PROMEDIO_TIEMPO_SOLUCION_RECLAMOS;
GO
IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'MONTO_CUPONES_RECLAMOS')
	DROP VIEW D_DE_DATOS.MONTO_CUPONES_RECLAMOS;
GO


---------------- FUNCIONES ----------------

--Rango Etario
CREATE FUNCTION D_DE_DATOS.CALCULAR_RANGO_ETARIO(@FECHA_NAC DATETIME2(3))
	RETURNS INT
BEGIN
	DECLARE @EDAD INT
	DECLARE @COD_RANGO_ETARIO INT

	SET @EDAD = YEAR(GETDATE()) - YEAR(@FECHA_NAC)

	IF @EDAD < 25
		SET @COD_RANGO_ETARIO = 1
    
	IF @EDAD BETWEEN 25 AND 35 
		SET @COD_RANGO_ETARIO = 2

	IF @EDAD BETWEEN 35 AND 55
		SET @COD_RANGO_ETARIO = 3

	IF @EDAD > 55
		SET @COD_RANGO_ETARIO = 4

	RETURN @COD_RANGO_ETARIO
	
END
GO

--Rango horario
CREATE FUNCTION D_DE_DATOS.CALCULAR_RANGO_HORARIO(@FECHA_HORA DATETIME2(3))
RETURNS INT
AS
BEGIN
    DECLARE @HORA TIME
    DECLARE @COD_RANGO_HORARIO INT

    SET @HORA = CONVERT(TIME, @FECHA_HORA)

    IF @hora >= '08:00' AND @hora < '10:00'
        SET @COD_RANGO_HORARIO = 1
    ELSE IF @hora >= '10:00' AND @hora < '12:00'
        SET @COD_RANGO_HORARIO = 2
    ELSE IF @hora >= '12:00' AND @hora < '14:00'
        SET @COD_RANGO_HORARIO = 3
    ELSE IF @hora >= '14:00' AND @hora < '16:00'
        SET @COD_RANGO_HORARIO = 4
    ELSE IF @hora >= '16:00' AND @hora < '18:00'
        SET @COD_RANGO_HORARIO = 5
    ELSE IF @hora >= '18:00' AND @hora < '20:00'
        SET @COD_RANGO_HORARIO = 6
    ELSE IF @hora >= '20:00' AND @hora < '22:00'
        SET @COD_RANGO_HORARIO = 7
    ELSE IF @hora >= '22:00' AND @hora < '00:00'
        SET @COD_RANGO_HORARIO = 8
    RETURN @COD_RANGO_HORARIO
END
GO

--Dia
CREATE FUNCTION D_DE_DATOS.CALCULAR_DIA_SEMANA(@FECHA_HORA DATETIME2(3))
RETURNS NVARCHAR(50) 
AS
BEGIN 
	DECLARE @DiaSemana NVARCHAR(30);
	SET @DiaSemana = CASE DATEPART(WEEKDAY, @FECHA_HORA)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miércoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sábado'
		END;
	RETURN @DiaSemana;
END;
GO

--Desvio 
--D_DE_DATOS.CALCULAR_DESVIO_ENTREGA(P.fecha_pedido,P.fecha_entrega_pedido,P.tiempo_entrega_estimado_pedido),
CREATE FUNCTION D_DE_DATOS.CALCULAR_DESVIO_ENTREGA(@FECHA_PEDIDO DATETIME2(3), @FECHA_ENTREGA DATETIME2(3), @TIEMPO_ESTIMADO DECIMAL(18,2))        
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @DESVIO DECIMAL(18,2);
	SET @DESVIO = @TIEMPO_ESTIMADO - DATEDIFF(MINUTE, @FECHA_PEDIDO, @FECHA_ENTREGA);
	RETURN @DESVIO;
END
GO


---------------------------------------------------------------------------------------

---------------- MIGRACIONES A DIMENSIONES ----------------

--Tiempo 
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIEMPO
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIEMPO (tiempo_anio,tiempo_mes)
		SELECT DISTINCT YEAR(fecha_pedido), MONTH(fecha_pedido)
		FROM D_DE_DATOS.PEDIDOS
  END
GO

--Dias
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_DIAS
AS
BEGIN 
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(1,'Domingo')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(2,'Lunes')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(3,'Martes')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(4,'Miércoles')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(5,'Jueves')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(6,'Viernes')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(7,'Sábado')
END
GO

--Rango horario
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RANGO_HORARIO
AS
BEGIN 
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(1,'08:00 - 10:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(2,'10:00 - 12:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(3,'12:00 - 14:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(4,'14:00 - 16:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(5,'16:00 - 18:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(6,'18:00 - 20:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(7,'20:00 - 22:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(cod_rango_horario,desc_rango_horario)
	VALUES(8,'22:00 - 00:00')
END
GO


--Rango Etario
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RANGO_ETARIO
AS
BEGIN 
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(1,'<25')
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(2,'25-35')
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(3,'35-55')
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(4,'>55')
END
GO


-- Provincia/Localidad
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALIDADES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_LOCALIDADES (cod_localidad,nombre_localidad, provincia_localidad)
		SELECT cod_localidad, nombre_localidad, provincia_localidad
		FROM D_DE_DATOS.LOCALIDADES
  END
GO



-- Tipo de Local
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_LOCALES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIPOS_LOCALES (cod_tipo_local,desc_tipo_local)
		SELECT cod_tipo_local,desc_tipo_local
		FROM D_DE_DATOS.TIPOS_LOCALES
  END
GO

-- Categoria de Local
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_CATEGORIAS_LOCALES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_CATEGORIAS_LOCALES (cod_categoria_local,desc_categoria_local)
		SELECT cod_categoria_local,desc_categoria_local
		FROM D_DE_DATOS.CATEGORIAS_LOCALES
  END
GO


-- Local 
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_LOCALES (cod_local, nombre_local)
		SELECT cod_local, nombre_local
		FROM D_DE_DATOS.LOCALES 
  END
GO

-- Tipo Movilidad
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_MOVILIDAD
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIPOS_MOVILIDAD (cod_movilidad_repartidor,desc_movilidad_repartidor)
		SELECT cod_movilidad_repartidor,desc_movilidad_repartidor
		FROM D_DE_DATOS.TIPOS_MOVILIDAD
  END
GO

-- Tipo paquete
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_PAQUETES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIPOS_PAQUETES (cod_tipo_paquete,desc_tipo_paquete)
		SELECT cod_tipo_paquete,desc_tipo_paquete
		FROM D_DE_DATOS.TIPOS_PAQUETES
  END
GO

-- Estados pedidos
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_ESTADOS_PEDIDOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_ESTADOS_PEDIDOS (cod_estado_pedido,desc_estado_pedido)
		SELECT cod_estado_pedido,desc_estado_pedido
		FROM D_DE_DATOS.ESTADOS_PEDIDOS
  END
GO

-- Estado envíos mensajería
CREATE PROCEDURE D_DE_DATOS.MIGRAR_ESTADOS_MENSAJERIA
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_ESTADOS_MENSAJERIA (cod_estado_mensajeria,desc_estado_mensajeria)
		SELECT cod_estado_mensajeria,desc_estado_mensajeria
		FROM D_DE_DATOS.ESTADOS_MENSAJERIA
  END
GO


---------------------------------------------------------------------------------------

---------------- MIGRACIONES A TABLAS EXTRAS ----------------


-- Tipo Reclamo
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_RECLAMOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIPOS_RECLAMOS (cod_tipo_reclamo,desc_tipo_reclamo)
		SELECT cod_tipo_reclamo,desc_tipo_reclamo
		FROM D_DE_DATOS.TIPOS_RECLAMOS
  END
GO


---------------------------------------------------------------------------------------

---------------- MIGRACIONES A HECHOS ----------------


CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_PEDIDOS
	(cod_rango_etario_usuario,
	cod_rango_etario_repartidor,
	cod_movilidad_repartidor,
	cod_dia_pedido,
	cod_tiempo_pedido,
	cod_rango_horario_pedido,
	cod_local,
	cod_localidad,
	cod_tipo_local,
	cod_categoria_local,
	cod_estado_pedido,
	cantidad_pedidos,
	total_pedido,
	total_desvio_tiempo_entrega,
	total_envios,
	total_calificacion,
	total_descuentos,
	cod_tiempo_entrega
	)
		SELECT 
		D_DE_DATOS.CALCULAR_RANGO_ETARIO(U.fecha_nacimiento_usuario),
		D_DE_DATOS.CALCULAR_RANGO_ETARIO(R.fecha_nacimiento_repartidor),
		R.cod_movilidad_repartidor,
		D.cod_dia,
		T.cod_tiempo,
		D_DE_DATOS.CALCULAR_RANGO_HORARIO(P.fecha_pedido) AS cod_rango_horario_pedido,
		L.cod_local,
		L.cod_localidad,
		L.cod_tipo_local,
		L.cod_categoria_local,
		cod_estado_pedido,
		COUNT(*),
		SUM(total_pedido),
		D_DE_DATOS.CALCULAR_DESVIO_ENTREGA(P.fecha_pedido,P.fecha_entrega_pedido,P.tiempo_entrega_estimado_pedido),
		SUM(E.precio_envio),
		SUM(calificacion_pedido),
		SUM(total_descuentos),
		T2.cod_tiempo
		  FROM D_DE_DATOS.PEDIDOS P
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(P.fecha_pedido) AND T.tiempo_mes = MONTH(P.fecha_pedido)
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T2 ON T2.tiempo_anio = YEAR(P.fecha_entrega_pedido) AND T2.tiempo_mes = MONTH(P.fecha_entrega_pedido)
		  INNER JOIN D_DE_DATOS.BI_DIAS D ON D.desc_dia = D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_pedido)
		  INNER JOIN D_DE_DATOS.USUARIOS U ON U.cod_usuario = P.cod_usuario
		  INNER JOIN D_DE_DATOS.ENVIOS E ON E.cod_pedido = P.cod_pedido
		  INNER JOIN D_DE_DATOS.REPARTIDORES R ON R.cod_repartidor = E.cod_repartidor
		  INNER JOIN D_DE_DATOS.LOCALES L ON L.cod_local = P.cod_local
		  GROUP BY
			D_DE_DATOS.CALCULAR_RANGO_ETARIO(U.fecha_nacimiento_usuario),
			D_DE_DATOS.CALCULAR_RANGO_ETARIO(R.fecha_nacimiento_repartidor),
			R.cod_movilidad_repartidor,
			D.cod_dia,
			T.cod_tiempo,
			D_DE_DATOS.CALCULAR_RANGO_HORARIO(P.fecha_pedido),
			L.cod_local,
			L.cod_localidad,
			L.cod_tipo_local,
			L.cod_categoria_local,
			cod_estado_pedido,
			D_DE_DATOS.CALCULAR_DESVIO_ENTREGA(P.fecha_pedido,P.fecha_entrega_pedido,P.tiempo_entrega_estimado_pedido),
			T2.cod_tiempo
		  END
GO



-- Hechos reclamos 
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RECLAMOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_RECLAMOS
	(
	cod_tipo_reclamo,
	cod_dia_inicio_reclamo,
	cod_tiempo_inicio_reclamo,
	cod_rango_etario_operador,
	cod_local,
	cantidad_reclamos,
	total_cupones,	
	total_tiempo_resolucion,
	cod_rango_horario_reclamo
	)
		SELECT 
		  cod_tipo_reclamo,
		  D.cod_dia,
		  T.cod_tiempo,
		  D_DE_DATOS.CALCULAR_RANGO_ETARIO(O.fecha_nacimiento_operador),
		  L.cod_local,
		  COUNT(*),
		  SUM(C.monto_cupon),
		  sum(   DATEDIFF    (minute, fecha_reclamo, fecha_solucion_reclamo)       ),
		  D_DE_DATOS.CALCULAR_RANGO_HORARIO(R.fecha_reclamo) AS cod_rango_horario_reclamo
		  FROM D_DE_DATOS.RECLAMOS R
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(R.fecha_reclamo) AND T.tiempo_mes = MONTH(R.fecha_reclamo)
		  INNER JOIN D_DE_DATOS.BI_DIAS D ON D.desc_dia = D_DE_DATOS.CALCULAR_DIA_SEMANA(R.fecha_reclamo)
		  INNER JOIN D_DE_DATOS.OPERADORES O ON O.cod_operador = R.cod_operador
		  INNER JOIN D_DE_DATOS.PEDIDOS P ON P.cod_pedido = R.cod_pedido
		  INNER JOIN D_DE_DATOS.LOCALES L ON L.cod_local = P.cod_local
		  INNER JOIN D_DE_DATOS.RECLAMOS_CUPON RC ON RC.cod_reclamo = R.cod_reclamo
		  INNER JOIN D_DE_DATOS.CUPONES_DESCUENTO C ON RC.cod_cupon = C.cod_cupon
		  GROUP BY
		  cod_tipo_reclamo,
		  D.cod_dia,
		  T.cod_tiempo,
		  D_DE_DATOS.CALCULAR_RANGO_ETARIO(O.fecha_nacimiento_operador),
		  D_DE_DATOS.CALCULAR_RANGO_HORARIO(R.fecha_reclamo),
		  L.cod_local
		  END
GO



-- Hechos servicios de mensajería
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_SERVICIOS_MENSAJERIA
AS
BEGIN
	INSERT INTO D_DE_DATOS.BI_SERVICIOS_MENSAJERIA (
		cod_dia_mensajeria ,
		cod_tiempo_mensajeria,
		cod_localidad, 
		cod_tipo_paquete,
		cod_rango_etario_repartidor,
		cod_estado_mensajeria,
		total_valor_asegurado_mensajeria,
		total_desvio_tiempo_entrega,
		cod_movilidad_repartidor,
		cod_tiempo_entrega_mensajeria
		)
	SELECT 
	D.cod_dia,
	T.cod_tiempo,
	S.cod_localidad,
	cod_tipo_paquete, 
	D_DE_DATOS.CALCULAR_RANGO_ETARIO(R.fecha_nacimiento_repartidor), 
	cod_estado_mensajeria,
	SUM(valor_asegurado_mensajeria),
	D_DE_DATOS.CALCULAR_DESVIO_ENTREGA(S.fecha_mensajeria, S.fecha_entrega_mensajeria, S.tiempo_entrega_estimado_mensajeria),
	R.cod_movilidad_repartidor,
	T2.cod_tiempo
	FROM D_DE_DATOS.SERVICIOS_MENSAJERIA S
	INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(fecha_mensajeria) AND T.tiempo_mes = MONTH(fecha_mensajeria)
	INNER JOIN D_DE_DATOS.BI_TIEMPO T2 ON T2.tiempo_anio = YEAR(fecha_entrega_mensajeria) AND T2.tiempo_mes = MONTH(fecha_entrega_mensajeria)
	INNER JOIN D_DE_DATOS.BI_DIAS D ON D.desc_dia = D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_mensajeria)
	INNER JOIN D_DE_DATOS.REPARTIDORES R ON R.cod_repartidor = S.cod_repartidor
	GROUP BY
	D.cod_dia,
	T.cod_tiempo,
	S.cod_localidad,
	cod_tipo_paquete, 
	D_DE_DATOS.CALCULAR_RANGO_ETARIO(R.fecha_nacimiento_repartidor), 
	cod_estado_mensajeria,
	D_DE_DATOS.CALCULAR_DESVIO_ENTREGA(S.fecha_mensajeria, S.fecha_entrega_mensajeria, S.tiempo_entrega_estimado_mensajeria),
	R.cod_movilidad_repartidor,
	T2.cod_tiempo
END
GO

---------------- TABLAS DIMENSIONALES ----------------

-- Tiempo (año, mes)
CREATE TABLE D_DE_DATOS.BI_TIEMPO(
	cod_tiempo INT IDENTITY(1,1) PRIMARY KEY,
	tiempo_anio INT,
	tiempo_mes INT
);

-- Día (Se corresponde con los días de la semana: L-M-M-J-V-S-D)
CREATE TABLE D_DE_DATOS.BI_DIAS (
    cod_dia INT PRIMARY KEY,
	desc_dia NVARCHAR(50) NOT NULL
);

-- Rango horario (De 8 a 00 cada 2 horas)
CREATE TABLE D_DE_DATOS.BI_RANGO_HORARIO(
    cod_rango_horario INT  PRIMARY KEY,
    desc_rango_horario NVARCHAR(50) NOT NULL
);

-- Rango etario usuario/repartidor/operario
CREATE TABLE D_DE_DATOS.BI_RANGO_ETARIO(
    cod_rango_etario INT PRIMARY KEY,
    desc_rango_etario NVARCHAR(50) NOT NULL
);

-- Provincia/Localidad
CREATE TABLE D_DE_DATOS.BI_LOCALIDADES (
	cod_localidad INT PRIMARY KEY,
	nombre_localidad NVARCHAR(255) NOT NULL,
	provincia_localidad NVARCHAR(255) NOT NULL
);

-- Tipo de Local
CREATE TABLE D_DE_DATOS.BI_TIPOS_LOCALES (
    cod_tipo_local INT PRIMARY KEY,
	desc_tipo_local NVARCHAR(50) NOT NULL
);

-- Categoria de Local
CREATE TABLE D_DE_DATOS.BI_CATEGORIAS_LOCALES (
    cod_categoria_local INT PRIMARY KEY,
	desc_categoria_local NVARCHAR(50) NOT NULL
);

-- Local
CREATE TABLE D_DE_DATOS.BI_LOCALES (
	cod_local INT PRIMARY KEY,
    nombre_local NVARCHAR(100) NOT NULL
);


-- Tipo Movilidad
CREATE TABLE D_DE_DATOS.BI_TIPOS_MOVILIDAD (
	cod_movilidad_repartidor INT PRIMARY KEY,
	desc_movilidad_repartidor NVARCHAR(50) NOT NULL
);

-- Tipo Paquete
CREATE TABLE D_DE_DATOS.BI_TIPOS_PAQUETES (
	cod_tipo_paquete INT  PRIMARY KEY,
	desc_tipo_paquete NVARCHAR(50) NOT NULL
);

-- Estados pedidos
CREATE TABLE D_DE_DATOS.BI_ESTADOS_PEDIDOS (
    cod_estado_pedido INT  PRIMARY KEY,
	desc_estado_pedido NVARCHAR(50) NOT NULL
);

-- Estado envíos mensajería
CREATE TABLE D_DE_DATOS.BI_ESTADOS_MENSAJERIA (
	cod_estado_mensajeria INT  PRIMARY KEY,
	desc_estado_mensajeria NVARCHAR(50) NOT NULL
);



---------------- TABLAS EXTRAS ----------------
-- Estas tablas son FK de las tablas de hechos. Vamos a utilizarlas para hacer uso de lo que nos
-- piden en las views. Ej: monto total de los cupones utilizados por mes en función del rango etario
-- de los usuarios.


-- Tipo Reclamo
CREATE TABLE D_DE_DATOS.BI_TIPOS_RECLAMOS (
	cod_tipo_reclamo INT PRIMARY KEY,
	desc_tipo_reclamo NVARCHAR(50) NOT NULL
);



--------------------------------------------------------------------------------------

---------------- TABLAS DE HECHOS ----------------

-- Hechos pedidos
CREATE TABLE D_DE_DATOS.BI_PEDIDOS (
	cod_rango_etario_usuario INT NOT NULL, --
	cod_rango_etario_repartidor INT NOT NULL, --
	cod_movilidad_repartidor INT NOT NULL, --
	cod_dia_pedido INT NOT NULL, --
	cod_tiempo_pedido INT NOT NULL, --
	cod_rango_horario_pedido INT NOT NULL, --
	cod_local INT NOT NULL, --
	cod_localidad INT NOT NULL, --
	cod_tipo_local INT NOT NULL, --
	cod_categoria_local INT NULL, --
	cod_estado_pedido INT NOT NULL, --
	cantidad_pedidos INT  NULL, --
	total_pedido DECIMAL(18,2)  NULL,
	total_desvio_tiempo_entrega DECIMAL(18, 2)  NULL, --
	total_envios DECIMAL(18,0) NULL, --
	total_calificacion DECIMAL(18,0) NULL, --
	total_descuentos DECIMAL(18,2) NULL, --
	cod_tiempo_entrega INT NOT NULL --
	FOREIGN KEY (cod_rango_etario_usuario) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO,
	FOREIGN KEY (cod_rango_etario_repartidor) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO,
	FOREIGN KEY (cod_movilidad_repartidor) REFERENCES D_DE_DATOS.BI_TIPOS_MOVILIDAD,
	FOREIGN KEY (cod_dia_pedido) REFERENCES D_DE_DATOS.BI_DIAS,
	FOREIGN KEY (cod_tiempo_pedido) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_tiempo_entrega) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_rango_horario_pedido) REFERENCES D_DE_DATOS.BI_RANGO_HORARIO,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.BI_LOCALES,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.BI_LOCALIDADES,
	FOREIGN KEY (cod_tipo_local) REFERENCES D_DE_DATOS.BI_TIPOS_LOCALES,
	FOREIGN KEY (cod_categoria_local) REFERENCES D_DE_DATOS.BI_CATEGORIAS_LOCALES,
	FOREIGN KEY (cod_estado_pedido) REFERENCES D_DE_DATOS.BI_ESTADOS_PEDIDOS
);

-- Hechos reclamos 
CREATE TABLE D_DE_DATOS.BI_RECLAMOS (
	cod_tipo_reclamo INT NOT NULL,
	cod_dia_inicio_reclamo INT NULL,
	cod_tiempo_inicio_reclamo INT NOT NULL,
	cod_rango_etario_operador INT NOT NULL,
	cod_local INT NOT NULL,
	cantidad_reclamos INT  NULL,
	total_cupones INT  NULL,
	total_tiempo_resolucion DECIMAL(18,2)  NULL,
	cod_rango_horario_reclamo INT NOT NULL
	FOREIGN KEY (cod_rango_etario_operador) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO,
	FOREIGN KEY (cod_rango_horario_reclamo) REFERENCES D_DE_DATOS.BI_RANGO_HORARIO,
	FOREIGN KEY (cod_tipo_reclamo) REFERENCES D_DE_DATOS.BI_TIPOS_RECLAMOS,
	FOREIGN KEY (cod_dia_inicio_reclamo) REFERENCES D_DE_DATOS.BI_DIAS,
	FOREIGN KEY (cod_tiempo_inicio_reclamo) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.BI_LOCALES
);

--Hechos servicios de mensajería - a revisar
CREATE TABLE D_DE_DATOS.BI_SERVICIOS_MENSAJERIA (
	cod_dia_mensajeria INT NULL,
	cod_tiempo_mensajeria INT NOT NULL,
	cod_localidad INT NOT NULL,
	cod_tipo_paquete INT NOT NULL,
	cod_rango_etario_repartidor INT NOT NULL,
	cod_estado_mensajeria INT NOT NULL,
	cod_tiempo_entrega_mensajeria INT NOT NULL,
	total_valor_asegurado_mensajeria DECIMAL(18,2) NOT NULL,
	total_desvio_tiempo_entrega DECIMAL(18,2) NOT NULL,
	cod_movilidad_repartidor INT NOT NULL
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades,
	FOREIGN KEY (cod_tipo_paquete) REFERENCES D_DE_DATOS.tipos_paquetes,
	FOREIGN KEY (cod_rango_etario_repartidor) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO,
	FOREIGN KEY (cod_estado_mensajeria) REFERENCES D_DE_DATOS.estados_mensajeria,
	FOREIGN KEY (cod_tiempo_mensajeria) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_movilidad_repartidor) REFERENCES D_DE_DATOS.BI_TIPOS_MOVILIDAD,
	FOREIGN KEY (cod_tiempo_entrega_mensajeria) REFERENCES D_DE_DATOS.BI_TIEMPO
);


-------------------------------------------------------------------------------------------

EXECUTE D_DE_DATOS.MIGRAR_BI_TIEMPO;
EXECUTE D_DE_DATOS.MIGRAR_BI_DIAS;
EXECUTE D_DE_DATOS.MIGRAR_BI_RANGO_HORARIO;
EXECUTE D_DE_DATOS.MIGRAR_BI_RANGO_ETARIO;
EXECUTE D_DE_DATOS.MIGRAR_BI_LOCALIDADES;
EXECUTE D_DE_DATOS.MIGRAR_BI_TIPOS_LOCALES;
EXECUTE D_DE_DATOS.MIGRAR_BI_CATEGORIAS_LOCALES;
EXECUTE D_DE_DATOS.MIGRAR_BI_LOCALES;
EXECUTE D_DE_DATOS.MIGRAR_BI_TIPOS_MOVILIDAD;
EXECUTE D_DE_DATOS.MIGRAR_BI_TIPOS_PAQUETES;
EXECUTE D_DE_DATOS.MIGRAR_BI_ESTADOS_PEDIDOS;
EXECUTE D_DE_DATOS.MIGRAR_ESTADOS_MENSAJERIA;
EXECUTE D_DE_DATOS.MIGRAR_BI_TIPOS_RECLAMOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_PEDIDOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_RECLAMOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_SERVICIOS_MENSAJERIA;

PRINT 'Migracion finalizada exitosamente'
GO 


---------------------------------------------------------------------------------

----Creación de vistas


----VISTA 1
---- Día de la semana y franja horaria 
---- con mayor cantidad de pedidos 
---- según la localidad y categoría del local
---- para cada mes de cada año.

CREATE VIEW D_DE_DATOS.MAYOR_CANTIDAD_PEDIDOS
 AS
	SELECT TOP 1 WITH TIES
    	LO.nombre_localidad + ', ' + LO.provincia_localidad AS Localidad,
    	TL.desc_tipo_local AS TipoLocal,
    	T.tiempo_mes AS Mes,
    	T.tiempo_anio AS Anio,
    	D.desc_dia AS Dia,
    	RH.desc_rango_horario AS FranjaHoraria,
    	COUNT(*) AS CantidadPedidos
	FROM D_DE_DATOS.BI_PEDIDOS P
	LEFT JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
	LEFT JOIN D_DE_DATOS.BI_DIAS D ON P.cod_dia_pedido = D.cod_dia
	LEFT JOIN D_DE_DATOS.BI_RANGO_HORARIO RH ON P.cod_rango_horario_pedido = RH.cod_rango_horario
	LEFT JOIN D_DE_DATOS.BI_LOCALIDADES LO ON P.cod_localidad = LO.cod_localidad
	LEFT JOIN D_DE_DATOS.BI_TIPOS_LOCALES TL ON P.cod_tipo_local = TL.cod_tipo_local
	GROUP BY
    	LO.nombre_localidad + ', ' + LO.provincia_localidad,
    	TL.desc_tipo_local,
    	T.tiempo_mes,
    	T.tiempo_anio,
    	D.desc_dia,
    	RH.desc_rango_horario
	ORDER BY
    	ROW_NUMBER() OVER (PARTITION BY T.tiempo_mes, T.tiempo_anio, LO.nombre_localidad + ', ' + LO.provincia_localidad, TL.desc_tipo_local ORDER BY COUNT(*) DESC);
 GO


---------------------------------------------------------

----VISTA 2
---- Monto total no cobrado por cada local en función de los pedidos
---- cancelados según el día de la semana y la franja horaria (cuentan como
---- pedidos cancelados tanto los que cancela el usuario como el local).

CREATE VIEW D_DE_DATOS.MONTO_NO_COBRADO_LOCALES
AS
SELECT
	D.desc_dia,
	RH.desc_rango_horario,
    L.nombre_local,
	COUNT(P.total_pedido) AS pedidos_cancelados,
    SUM(P.total_pedido) AS monto_no_cobrado
FROM
    D_DE_DATOS.BI_PEDIDOS P
    INNER JOIN D_DE_DATOS.BI_DIAS D ON P.cod_dia_pedido = D.cod_dia
    INNER JOIN D_DE_DATOS.BI_RANGO_HORARIO RH ON P.cod_rango_horario_pedido = RH.cod_rango_horario
	INNER JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
WHERE
    P.cod_estado_pedido = 2
GROUP BY
    D.desc_dia,
	RH.desc_rango_horario,
    L.nombre_local;
GO

---------------------------------------------------------

----VISTA 3
---- Valor promedio mensual que tienen los envíos de pedidos en cada
---- localidad.
---- mes | localidad | promedioPrecioEnvios

CREATE VIEW D_DE_DATOS.PROMEDIO_PRECIO_ENVIOS_POR_LOCALIDAD
AS  
SELECT
    	L.nombre_localidad + ', ' + L.provincia_localidad AS localidad,
		T.tiempo_mes AS mes,
    	T.tiempo_anio AS año,
    	AVG(P.total_envios) AS valor_promedio_envios
	FROM
    	D_DE_DATOS.BI_PEDIDOS P
    	INNER JOIN D_DE_DATOS.BI_LOCALIDADES L ON P.cod_localidad = L.cod_localidad
    	INNER JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
	GROUP BY 
    	L.nombre_localidad + ', ' + L.provincia_localidad,
		T.tiempo_mes,
    	T.tiempo_anio;
GO
-- -------------------------------------------------------

----VISTA 4
---- Desvío promedio en tiempo de entrega según el tipo de movilidad, el día
---- de la semana y la franja horaria.
---- El desvío debe calcularse en minutos y representa la diferencia entre la
---- fecha/hora en que se realizó el pedido y la fecha/hora que se entregó en
---- comparación con los minutos de tiempo estimados.
---- Este indicador debe tener en cuenta todos los envíos, es decir, sumar tanto
---- los envíos de pedidos como los de mensajería.

CREATE VIEW D_DE_DATOS.DESVIOS_PROMEDIO AS
	SELECT
    	tipo_movilidad,
    	dia_semana,
    	rango_horario,
   		AVG(desvio_promedio) AS desvio_promedio_total
	FROM
	(
    	SELECT
       		TM.desc_movilidad_repartidor AS tipo_movilidad,
       		D.desc_dia AS dia_semana,
        	RH.desc_rango_horario AS rango_horario,
        	AVG(P.total_desvio_tiempo_entrega) AS desvio_promedio
    	FROM D_DE_DATOS.BI_PEDIDOS P
   		JOIN D_DE_DATOS.BI_TIPOS_MOVILIDAD TM ON TM.cod_movilidad_repartidor = P.cod_movilidad_repartidor
    	JOIN D_DE_DATOS.BI_DIAS D ON P.cod_dia_pedido = D.cod_dia
    	JOIN D_DE_DATOS.BI_RANGO_HORARIO RH ON P.cod_rango_horario_pedido = RH.cod_rango_horario
    	GROUP BY TM.desc_movilidad_repartidor, D.desc_dia, RH.desc_rango_horario

    	UNION
    	SELECT
        	TM.desc_movilidad_repartidor AS tipo_movilidad,
        	D.desc_dia AS dia_semana,
        	RH.desc_rango_horario AS rango_horario,
        	AVG(M.total_desvio_tiempo_entrega) AS desvio_promedio
    	FROM D_DE_DATOS.BI_SERVICIOS_MENSAJERIA M
    	JOIN D_DE_DATOS.BI_TIPOS_MOVILIDAD TM ON TM.cod_movilidad_repartidor = M.cod_movilidad_repartidor
    	JOIN D_DE_DATOS.BI_DIAS D ON M.cod_dia_mensajeria = D.cod_dia
    	JOIN D_DE_DATOS.BI_RANGO_HORARIO RH ON M.cod_tiempo_mensajeria = RH.cod_rango_horario
    	GROUP BY TM.desc_movilidad_repartidor, D.desc_dia, RH.desc_rango_horario
	) AS subquery
	GROUP BY tipo_movilidad, dia_semana, rango_horario;
GO

    


---------------------------------------------------------

----VISTA 5
---- Monto total de los cupones utilizados por mes en función del rango etario
---- de los usuarios. 

CREATE VIEW D_DE_DATOS.MONTO_TOTAL_CUPONES
AS
SELECT 
	RE.desc_rango_etario AS rango_etario, 
	T.tiempo_mes AS mes, 
	T.tiempo_anio AS año,
	SUM(P.total_descuentos) monto_total_cupones
	FROM D_DE_DATOS.BI_PEDIDOS P
	JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
	JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON P.cod_rango_etario_usuario = RE.cod_rango_etario
	GROUP BY 
	RE.desc_rango_etario,
	T.tiempo_mes, 
	T.tiempo_anio;
GO


---------------------------------------------------------

----VISTA 6
---- Promedio de calificación mensual por local.
---- mes | local | promedio calificacion

CREATE VIEW D_DE_DATOS.PROMEDIO_CALIFICACION_MENSUAL_POR_LOCAL
AS
	SELECT 
		L.nombre_local AS NombreLocal,
		T.tiempo_mes AS Mes, 
		T.tiempo_anio AS Año,
		AVG(P.total_calificacion) AS PromedioCalificacion
		FROM D_DE_DATOS.BI_PEDIDOS P
		JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
		JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
		GROUP BY 
		L.nombre_local,
		T.tiempo_mes, 
		T.tiempo_anio
GO	
	
---------------------------------------------------------

----VISTA 7
---- Porcentaje de pedidos y mensajería entregados mensualmente 
---- según el rango etario de los repartidores y la localidad

---- Este indicador se debe tener en cuenta y sumar tanto los envíos de pedidos
---- como los de mensajería.

---- El porcentaje se calcula en función del total general de pedidos y envíos
---- mensuales entregados. 

 CREATE VIEW D_DE_DATOS.PORCENTAJE_PEDIDOS_Y_ENVIOS_ENTREGADOS
 AS
 SELECT 
     Mes, 
	 Anio,
     Localidad,
     RangoEtario,
     SUM(totalPedidosServicios) AS totalPedidosServicios,
     SUM(entregasRealizadas) AS entregasRealizadas,
     100 * SUM(entregasRealizadas) / SUM(totalPedidosServicios) AS PorcentajeEntregados
 FROM
 (
     SELECT 
         T.tiempo_mes AS Mes, 
		 T.tiempo_anio AS Anio,
         L.nombre_localidad AS Localidad,
         RE.desc_rango_etario AS RangoEtario,
         COUNT(*) AS totalPedidosServicios,
         COUNT(CASE WHEN cod_estado_pedido = 1 THEN 1 END) AS entregasRealizadas
     FROM D_DE_DATOS.BI_PEDIDOS P
     JOIN D_DE_DATOS.BI_LOCALIDADES L ON P.cod_localidad = L.cod_localidad
     JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON RE.cod_rango_etario = p.cod_rango_etario_repartidor
     JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_entrega = T.cod_tiempo
     GROUP BY  
         T.tiempo_mes, 
		 T.tiempo_anio,
         L.nombre_localidad,
         RE.desc_rango_etario
   
     UNION ALL
    
     SELECT 
         T.tiempo_mes AS Mes, 
		 T.tiempo_anio AS Anio,
         L.nombre_localidad AS Localidad,
         RE.desc_rango_etario AS RangoEtario,
         COUNT(*) AS totalPedidosServicios,
         COUNT(CASE WHEN cod_tiempo_entrega_mensajeria IS NOT NULL THEN 1 END) AS entregasRealizadas
     FROM D_DE_DATOS.BI_SERVICIOS_MENSAJERIA M
     JOIN D_DE_DATOS.BI_TIEMPO T ON M.cod_tiempo_entrega_mensajeria = T.cod_tiempo
     JOIN D_DE_DATOS.BI_LOCALIDADES L ON M.cod_localidad = L.cod_localidad
     JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON M.cod_rango_etario_repartidor = RE.cod_rango_etario
     GROUP BY  
         T.tiempo_mes, 
		 T.tiempo_anio,
         L.nombre_localidad,
         RE.desc_rango_etario
 ) AS subquery
 GROUP BY Mes,Anio, Localidad, RangoEtario;
 GO


---------------------------------------------------------

----VISTA 8
---- Promedio mensual del valor asegurado (valor declarado por el usuario) de los paquetes enviados
---- a través del servicio de mensajería en función del tipo de paquete. 

CREATE VIEW D_DE_DATOS.PROMEDIO_VALOR_ASEGURADO
AS
	SELECT 
		TP.desc_tipo_paquete AS TipoPaquete,
		T.tiempo_mes AS Mes,
		T.tiempo_anio AS Año,
		AVG(M.total_valor_asegurado_mensajeria) AS promedioValorAsegurado
	FROM D_DE_DATOS.BI_SERVICIOS_MENSAJERIA M
	JOIN D_DE_DATOS.BI_TIPOS_PAQUETES TP ON M.cod_tipo_paquete = TP.cod_tipo_paquete
	JOIN D_DE_DATOS.BI_TIEMPO T ON M.cod_tiempo_mensajeria = T.cod_tiempo
	GROUP BY 
		TP.desc_tipo_paquete,
		T.tiempo_mes,
		T.tiempo_anio
GO

---------------------------------------------------------

----VISTA 9
---- Cantidad de reclamos mensuales 
---- recibidos por cada local en función del día de la semana y rango horario.
---- mes | local | diaSemana | rangoHorario | cantidadReclamos




  CREATE VIEW D_DE_DATOS.CANTIDAD_RECLAMOS
  AS
     SELECT  
 	T.tiempo_mes AS Mes,
 	T.tiempo_anio AS Anio,
 	L.nombre_local AS Local,
 	D.desc_dia AS DiaSemana,
 	RH.desc_rango_horario AS RangoHorario,
     SUM(cantidad_reclamos) cantidadReclamos
     FROM D_DE_DATOS.BI_RECLAMOS R
 	JOIN D_DE_DATOS.BI_DIAS D ON R.cod_dia_inicio_reclamo = D.cod_dia
 	JOIN D_DE_DATOS.BI_TIEMPO T ON R.cod_tiempo_inicio_reclamo = T.cod_tiempo
 	JOIN D_DE_DATOS.BI_LOCALES L ON R.cod_local = L.cod_local
 	JOIN D_DE_DATOS.BI_RANGO_HORARIO RH ON R.cod_rango_horario_reclamo = RH.cod_rango_horario
 	GROUP BY 
 	T.tiempo_mes,
 	T.tiempo_anio,
 	L.nombre_local, 
 	D.desc_dia, 
 	RH.desc_rango_horario
  GO

-- -------------------------------------------------------

----VISTA 10
---- Tiempo promedio de resolución de reclamos mensual según cada tipo de
---- reclamo y rango etario de los operadores.
---- El tiempo de resolución debe calcularse en minutos y representa la
---- diferencia entre la fecha/hora en que se realizó el reclamo y la fecha/hora
---- que se resolvió. 

CREATE VIEW D_DE_DATOS.PROMEDIO_TIEMPO_SOLUCION_RECLAMOS
AS
	SELECT 
	TR.desc_tipo_reclamo AS TipoReclamo,
	RE.desc_rango_etario AS RangoEtarioOperador,
	T.tiempo_mes AS Mes, 
	T.tiempo_anio AS Año,
	AVG (R.total_tiempo_resolucion) TiempoPromedioResolucion
	FROM D_DE_DATOS.BI_RECLAMOS R
	JOIN D_DE_DATOS.BI_TIEMPO T ON R.cod_tiempo_inicio_reclamo = T.cod_tiempo
	JOIN D_DE_DATOS.BI_TIPOS_RECLAMOS TR ON R.cod_tipo_reclamo = TR.cod_tipo_reclamo
	JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON R.cod_rango_etario_operador = RE.cod_rango_etario
	GROUP BY 
	TR.desc_tipo_reclamo,
	RE.desc_rango_etario,
	T.tiempo_mes, 
	T.tiempo_anio
GO

---------------------------------------------------------

----VISTA 11
---- Monto mensual generado en cupones a partir de reclamos. /*NOS FALTAN CUPONES*/

CREATE VIEW D_DE_DATOS.MONTO_CUPONES_RECLAMOS
AS
	SELECT 
	T.tiempo_mes AS Mes,
	T.tiempo_anio AS Anio,
	SUM(R.total_cupones) MontoTotal
	FROM D_DE_DATOS.BI_RECLAMOS R
	JOIN D_DE_DATOS.BI_TIEMPO T ON R.cod_tiempo_inicio_reclamo = T.cod_tiempo
	GROUP BY T.tiempo_mes, T.tiempo_anio
 GO

 ------------------------------------------------------------------------------------------------------------

-- --SELECTS DE LAS VISTAS
SELECT * FROM D_DE_DATOS.MAYOR_CANTIDAD_PEDIDOS;
SELECT * FROM D_DE_DATOS.MONTO_NO_COBRADO_LOCALES;
SELECT * FROM D_DE_DATOS.PROMEDIO_PRECIO_ENVIOS_POR_LOCALIDAD;
SELECT * FROM D_DE_DATOS.DESVIOS_PROMEDIO;
SELECT * FROM D_DE_DATOS.MONTO_TOTAL_CUPONES;
SELECT * FROM D_DE_DATOS.PROMEDIO_CALIFICACION_MENSUAL_POR_LOCAL;
SELECT * FROM D_DE_DATOS.PORCENTAJE_PEDIDOS_Y_ENVIOS_ENTREGADOS;
SELECT * FROM D_DE_DATOS.PROMEDIO_VALOR_ASEGURADO;
SELECT * FROM D_DE_DATOS.CANTIDAD_RECLAMOS;
SELECT * FROM D_DE_DATOS.PROMEDIO_TIEMPO_SOLUCION_RECLAMOS;
SELECT * FROM D_DE_DATOS.MONTO_CUPONES_RECLAMOS;
GO