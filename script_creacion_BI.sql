USE [GD1C2023]
GO

------------- LIMPIAR FUNCIONES----------------------

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_RANGO_ETARIO')
	DROP FUNCTION D_DE_DATOS.CALCULAR_RANGO_ETARIO;
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_RANGO_HORARIO')
	DROP FUNCTION D_DE_DATOS.CALCULAR_RANGO_HORARIO;
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'CALCULAR_DIA_SEMANA')
	DROP FUNCTION D_DE_DATOS.CALCULAR_DIA_SEMANA;
GO
------------- LIMPIAR TABLAS  ------------------------

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RECLAMOS_CUPON')
	DROP TABLE D_DE_DATOS.BI_RECLAMOS_CUPON;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_PEDIDOS_CUPON')
	DROP TABLE D_DE_DATOS.BI_PEDIDOS_CUPON;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_CUPONES_DESCUENTO')
	DROP TABLE D_DE_DATOS.BI_CUPONES_DESCUENTO;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_SERVICIOS_MENSAJERIA')
	DROP TABLE D_DE_DATOS.BI_SERVICIOS_MENSAJERIA;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RECLAMOS')
	DROP TABLE D_DE_DATOS.BI_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_ENVIOS')
	DROP TABLE D_DE_DATOS.BI_ENVIOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_PEDIDOS')
	DROP TABLE D_DE_DATOS.BI_PEDIDOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIPOS_RECLAMOS')
	DROP TABLE D_DE_DATOS.BI_TIPOS_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_OPERADORES')
	DROP TABLE D_DE_DATOS.BI_OPERADORES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_REPARTIDORES')
	DROP TABLE D_DE_DATOS.BI_REPARTIDORES;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_USUARIOS')
	DROP TABLE D_DE_DATOS.BI_USUARIOS;
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
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Rango_Etario')
	DROP TABLE D_DE_DATOS.BI_Rango_Etario;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Rango_Horario')
	DROP TABLE D_DE_DATOS.BI_Rango_Horario;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Dias')
	DROP TABLE D_DE_DATOS.BI_Dias;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Tiempo')
	DROP TABLE D_DE_DATOS.BI_Tiempo;
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
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_USUARIOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_USUARIOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_REPARTIDORES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_REPARTIDORES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_OPERADORES')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_OPERADORES;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPOS_RECLAMOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_PEDIDOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_ENVIOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_ENVIOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RECLAMOS')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_RECLAMOS;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_CUPONES_DESCUENTO')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_CUPONES_DESCUENTO;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_PEDIDOS_CUPON')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS_CUPON;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RECLAMOS_CUPON')
	DROP PROCEDURE D_DE_DATOS.MIGRAR_BI_RECLAMOS_CUPON;
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
    INSERT INTO D_DE_DATOS.BI_LOCALES (cod_local, nombre_local, cod_localidad, cod_tipo_local, cod_categoria_local)
		SELECT L.cod_local, L.nombre_local, L.cod_localidad, L.cod_tipo_local, L.cod_categoria_local
		FROM D_DE_DATOS.LOCALES L
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
    INSERT INTO D_DE_DATOS.BI_TIPOS_PAQUETES (cod_tipo_paquete,desc_tipo_paquete,precio_paquete)
		SELECT cod_tipo_paquete,desc_tipo_paquete,precio_paquete
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

-- Usuarios
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_USUARIOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_USUARIOS (cod_usuario, cod_rango_etario)
		SELECT U.cod_usuario, D_DE_DATOS.CALCULAR_RANGO_ETARIO(U.fecha_nacimiento_usuario)
		FROM D_DE_DATOS.USUARIOS U
  END
GO

-- Repartidores
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_REPARTIDORES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_REPARTIDORES (cod_repartidor, cod_rango_etario, cod_movilidad_repartidor)
		SELECT R.cod_repartidor,D_DE_DATOS.CALCULAR_RANGO_ETARIO(R.fecha_nacimiento_repartidor), R.cod_movilidad_repartidor
		FROM D_DE_DATOS.REPARTIDORES R
  END
GO

-- Operadores
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_OPERADORES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_OPERADORES (cod_operador, cod_rango_etario)
		SELECT O.cod_operador, D_DE_DATOS.CALCULAR_RANGO_ETARIO(O.fecha_nacimiento_operador)
		FROM D_DE_DATOS.OPERADORES O
  END
GO

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
	(cod_usuario,
	cod_pedido,
	cod_dia_pedido,
	cod_tiempo_pedido,
	rango_horario_pedido,
	cod_tiempo_entrega,
	cod_local,
	total_pedido,
	cod_estado_pedido,
	fecha_pedido,
	fecha_entrega_pedido,
	tiempo_entrega_estimado_pedido,
	calificacion_pedido
	)
		SELECT 
		  cod_usuario,
		  cod_pedido,
		  D.cod_dia,
		  T.cod_tiempo,
		  D_DE_DATOS.CALCULAR_RANGO_HORARIO(fecha_pedido) AS rango_horario_pedido,
		  T2.cod_tiempo,
		  cod_local,
		  total_pedido,
		  cod_estado_pedido,
		  fecha_pedido,
		  fecha_entrega_pedido,
		  tiempo_entrega_estimado_pedido,
		  calificacion_pedido
		  FROM D_DE_DATOS.PEDIDOS P
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(P.fecha_pedido) AND T.tiempo_mes = MONTH(P.fecha_pedido)
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T2 ON T2.tiempo_anio = YEAR(P.fecha_entrega_pedido) AND T2.tiempo_mes = MONTH(P.fecha_entrega_pedido)
		  INNER JOIN D_DE_DATOS.BI_DIAS D ON D.desc_dia = D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_pedido)
		  END
GO


-- Envios
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_ENVIOS
 AS
	BEGIN
    INSERT INTO D_DE_DATOS.BI_ENVIOS (cod_envio,precio_envio,cod_repartidor,cod_localidad,cod_pedido)
		SELECT cod_envio, precio_envio, cod_repartidor,cod_localidad, cod_pedido
		  FROM D_DE_DATOS.ENVIOS 
	END
GO

-- Hechos reclamos - a revisar
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RECLAMOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_RECLAMOS
	(cod_reclamo,
	cod_pedido,
	cod_tipo_reclamo,
	cod_dia_inicio_reclamo,
	cod_tiempo_inicio_reclamo,
	cod_operador,
	fecha_reclamo,
	fecha_solucion_reclamo
	)
		SELECT 
		  cod_reclamo,
		  cod_pedido,
		  cod_tipo_reclamo,
		  D.cod_dia,
		  T.cod_tiempo,
		  cod_operador,
		  fecha_reclamo,
		  fecha_solucion_reclamo
		  FROM D_DE_DATOS.RECLAMOS R
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(R.fecha_reclamo) AND T.tiempo_mes = MONTH(R.fecha_reclamo)
		  INNER JOIN D_DE_DATOS.BI_DIAS D ON D.desc_dia = D_DE_DATOS.CALCULAR_DIA_SEMANA(R.fecha_reclamo)
		  END
GO

--Hechos cupones
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_CUPONES_DESCUENTO
AS
BEGIN
	INSERT INTO D_DE_DATOS.BI_CUPONES_DESCUENTO(cod_cupon,monto_cupon,cod_tiempo_cupon)
	SELECT 
	cod_cupon,
	monto_cupon,
	T.cod_tiempo
	FROM D_DE_DATOS.CUPONES_DESCUENTO C
	INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(C.fecha_alta_cupon) AND T.tiempo_mes = MONTH(C.fecha_alta_cupon)
END
GO

CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS_CUPON
AS
BEGIN
	INSERT INTO D_DE_DATOS.BI_PEDIDOS_CUPON(cod_pedido,cod_cupon)
	SELECT cod_pedido,cod_cupon
	FROM D_DE_DATOS.PEDIDOS_CUPON
END
GO

CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RECLAMOS_CUPON
AS
BEGIN
	INSERT INTO D_DE_DATOS.BI_RECLAMOS_CUPON(cod_reclamo,cod_cupon)
	SELECT cod_reclamo,cod_cupon
	FROM D_DE_DATOS.RECLAMOS_CUPON
END
GO


-- Hechos servicios de mensajería
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_SERVICIOS_MENSAJERIA
AS
BEGIN
	INSERT INTO D_DE_DATOS.BI_SERVICIOS_MENSAJERIA (
		cod_mensajeria,
		cod_dia_mensajeria ,
		cod_tiempo_mensajeria,
		cod_localidad, 
		cod_tipo_paquete,
		valor_asegurado_mensajeria ,
		   cod_repartidor,
		    cod_estado_mensajeria,
			tiempo_entrega_estimado_mensajeria  ,
			cod_tiempo_entrega_mensajeria ,
			fecha_mensajeria,
			fecha_entrega_mensajeria  )
	SELECT 
	cod_mensajeria,
	D.cod_dia,
	T.cod_tiempo,
	cod_localidad,
	cod_tipo_paquete, 
	valor_asegurado_mensajeria , 
	cod_repartidor,   
	cod_estado_mensajeria,
	tiempo_entrega_estimado_mensajeria  , 
	T2.cod_tiempo,
	fecha_mensajeria,
	fecha_entrega_mensajeria
	FROM D_DE_DATOS.SERVICIOS_MENSAJERIA
	INNER JOIN D_DE_DATOS.BI_TIEMPO T ON T.tiempo_anio = YEAR(fecha_mensajeria) AND T.tiempo_mes = MONTH(fecha_mensajeria)
	INNER JOIN D_DE_DATOS.BI_TIEMPO T2 ON T2.tiempo_anio = YEAR(fecha_entrega_mensajeria) AND T2.tiempo_mes = MONTH(fecha_entrega_mensajeria)
	INNER JOIN D_DE_DATOS.BI_DIAS D ON D.desc_dia = D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_mensajeria)
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
    nombre_local NVARCHAR(100) NOT NULL,
    cod_localidad INT NOT NULL,
	cod_tipo_local INT NOT NULL,
    cod_categoria_local INT NULL,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades,
	FOREIGN KEY (cod_categoria_local) REFERENCES D_DE_DATOS.categorias_locales,
	FOREIGN KEY (cod_tipo_local) REFERENCES D_DE_DATOS.tipos_locales
);


-- Tipo Movilidad
CREATE TABLE D_DE_DATOS.BI_TIPOS_MOVILIDAD (
	cod_movilidad_repartidor INT PRIMARY KEY,
	desc_movilidad_repartidor NVARCHAR(50) NOT NULL
);

-- Tipo Paquete
CREATE TABLE D_DE_DATOS.BI_TIPOS_PAQUETES (
	cod_tipo_paquete INT  PRIMARY KEY,
	desc_tipo_paquete NVARCHAR(50) NOT NULL,
	precio_paquete DECIMAL(18,2) NOT NULL
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

-- Usuarios
CREATE TABLE D_DE_DATOS.BI_USUARIOS (
	cod_usuario INT PRIMARY KEY,
	cod_rango_etario INT
	FOREIGN KEY (cod_rango_etario) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO
);

-- Repartidores
CREATE TABLE D_DE_DATOS.BI_REPARTIDORES (
	cod_repartidor INT PRIMARY KEY,
	cod_rango_etario INT,
	cod_movilidad_repartidor INT NOT NULL
	FOREIGN KEY (cod_rango_etario) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO
);

-- Operadores 
CREATE TABLE D_DE_DATOS.BI_OPERADORES (
	cod_operador INT PRIMARY KEY,
	cod_rango_etario INT
	FOREIGN KEY (cod_rango_etario) REFERENCES D_DE_DATOS.BI_RANGO_ETARIO
);

-- Tipo Reclamo
CREATE TABLE D_DE_DATOS.BI_TIPOS_RECLAMOS (
	cod_tipo_reclamo INT PRIMARY KEY,
	desc_tipo_reclamo NVARCHAR(50) NOT NULL
);

--------------------------------------------------------------------------------------

---------------- TABLAS DE HECHOS ----------------

-- Hechos pedidos
CREATE TABLE D_DE_DATOS.BI_PEDIDOS (
	cod_usuario INT NOT NULL,
	cod_pedido DECIMAL(18,0) PRIMARY KEY,
	cod_dia_pedido INT NOT NULL,
	cod_tiempo_pedido INT NOT NULL,
	rango_horario_pedido INT NOT NULL,
	cod_tiempo_entrega INT NOT NULL,
	cod_local INT NOT NULL, 
	total_pedido DECIMAL(18,2) NOT NULL,
	cod_estado_pedido INT NOT NULL,
	fecha_pedido DATETIME2(3) NOT NULL,
	fecha_entrega_pedido DATETIME2(3) NULL,
	tiempo_entrega_estimado_pedido DECIMAL(18,2) NOT NULL,
	calificacion_pedido DECIMAL(18,0) NULL
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.BI_USUARIOS,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.BI_LOCALES,
	FOREIGN KEY (cod_tiempo_pedido) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_tiempo_entrega) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_dia_pedido) REFERENCES D_DE_DATOS.BI_DIAS,
	FOREIGN KEY (cod_estado_pedido) REFERENCES D_DE_DATOS.BI_ESTADOS_PEDIDOS
);

-- Hechos envios
CREATE TABLE D_DE_DATOS.BI_ENVIOS (
	cod_envio INT PRIMARY KEY,
	precio_envio DECIMAL(18,2) NOT NULL,
	cod_repartidor INT NOT NULL,
	cod_localidad INT NOT NULL,
	cod_pedido DECIMAL(18,0) NOT NULL,
	FOREIGN KEY (cod_repartidor) REFERENCES D_DE_DATOS.BI_REPARTIDORES,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.BI_LOCALIDADES,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.BI_PEDIDOS
);

-- Hechos reclamos - a revisar
CREATE TABLE D_DE_DATOS.BI_RECLAMOS (
	cod_reclamo DECIMAL(18,0) PRIMARY KEY,
	cod_pedido DECIMAL(18,0) NOT NULL,
	cod_tipo_reclamo INT NOT NULL,
	cod_dia_inicio_reclamo INT NULL,
	cod_tiempo_inicio_reclamo INT NOT NULL,
	cod_operador INT NOT NULL,
	fecha_reclamo DATETIME2(3) NOT NULL,
	fecha_solucion_reclamo DATETIME2(3) NULL
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.BI_PEDIDOS,
	FOREIGN KEY (cod_tipo_reclamo) REFERENCES D_DE_DATOS.BI_TIPOS_RECLAMOS,
	FOREIGN KEY (cod_operador) REFERENCES D_DE_DATOS.BI_OPERADORES,
	FOREIGN KEY (cod_dia_inicio_reclamo) REFERENCES D_DE_DATOS.BI_DIAS,
	FOREIGN KEY (cod_tiempo_inicio_reclamo) REFERENCES D_DE_DATOS.BI_TIEMPO,

);

--Hechos servicios de mensajería - a revisar
CREATE TABLE D_DE_DATOS.BI_SERVICIOS_MENSAJERIA (
	cod_mensajeria INT PRIMARY KEY,
	cod_dia_mensajeria INT NULL,
	cod_tiempo_mensajeria INT NOT NULL,
	cod_localidad INT NOT NULL,
	cod_tipo_paquete INT NOT NULL,
	valor_asegurado_mensajeria DECIMAL(18,2) NOT NULL,
	cod_repartidor INT NOT NULL,
	cod_estado_mensajeria INT NOT NULL,
	tiempo_entrega_estimado_mensajeria  DECIMAL(18,2) NOT NULL,
	cod_tiempo_entrega_mensajeria INT NOT NULL,
	fecha_mensajeria DATETIME2(3),
	fecha_entrega_mensajeria DATETIME2(3)
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades,
	FOREIGN KEY (cod_tipo_paquete) REFERENCES D_DE_DATOS.tipos_paquetes,
	FOREIGN KEY (cod_repartidor) REFERENCES D_DE_DATOS.repartidores,
	FOREIGN KEY (cod_estado_mensajeria) REFERENCES D_DE_DATOS.estados_mensajeria,
	FOREIGN KEY (cod_tiempo_mensajeria) REFERENCES D_DE_DATOS.BI_TIEMPO,
	FOREIGN KEY (cod_tiempo_entrega_mensajeria) REFERENCES D_DE_DATOS.BI_TIEMPO
);

--Hechos cupones - a revisar
CREATE TABLE D_DE_DATOS.BI_CUPONES_DESCUENTO (
	cod_cupon INT  PRIMARY KEY,
	monto_cupon DECIMAL (18,2) NOT NULL,
	cod_tiempo_cupon INT NOT NULL
	FOREIGN KEY (cod_tiempo_cupon) REFERENCES D_DE_DATOS.BI_TIEMPO
);

CREATE TABLE D_DE_DATOS.BI_PEDIDOS_CUPON (
	cod_pedido DECIMAL(18,0) NOT NULL,
	cod_cupon INT NOT NULL,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.pedidos,
	FOREIGN KEY (cod_cupon) REFERENCES D_DE_DATOS.cupones_descuento,
	PRIMARY KEY (cod_pedido, cod_cupon)
);

CREATE TABLE D_DE_DATOS.BI_RECLAMOS_CUPON (
	cod_reclamo DECIMAL(18,0) NOT NULL,
	cod_cupon INT NOT NULL,
	FOREIGN KEY (cod_reclamo) REFERENCES D_DE_DATOS.reclamos,
	FOREIGN KEY (cod_cupon) REFERENCES D_DE_DATOS.cupones_descuento,
	PRIMARY KEY (cod_reclamo, cod_cupon)
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
EXECUTE D_DE_DATOS.MIGRAR_BI_USUARIOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_REPARTIDORES;
EXECUTE D_DE_DATOS.MIGRAR_BI_OPERADORES;
EXECUTE D_DE_DATOS.MIGRAR_BI_TIPOS_RECLAMOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_PEDIDOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_ENVIOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_RECLAMOS;
EXECUTE D_DE_DATOS.MIGRAR_BI_CUPONES_DESCUENTO;
EXECUTE D_DE_DATOS.MIGRAR_BI_PEDIDOS_CUPON;
EXECUTE D_DE_DATOS.MIGRAR_BI_RECLAMOS_CUPON;
EXECUTE D_DE_DATOS.MIGRAR_BI_SERVICIOS_MENSAJERIA;

PRINT 'Migracion finalizada exitosamente'
GO 

---------------------------------------------------------------------------------

--Creación de vistas


--VISTA 1
-- Día de la semana y franja horaria 
-- con mayor cantidad de pedidos 
-- según la localidad y categoría del local
-- para cada mes de cada año.

CREATE VIEW D_DE_DATOS.MAYOR_CANTIDAD_PEDIDOS
AS
SELECT TOP 1 WITH TIES
    D.desc_dia AS Dia,
    T.tiempo_mes AS Mes,
    T.tiempo_anio AS Anio,
    R.desc_rango_horario AS FranjaHoraria,
    LO.nombre_localidad AS Localidad,
    LO.provincia_localidad AS Provincia,
    C.desc_categoria_local AS CategoriaLocal,
    TL.desc_tipo_local AS TipoLocal,
    COUNT(P.cod_pedido) AS CantidadPedidos
FROM D_DE_DATOS.BI_PEDIDOS P
LEFT JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
LEFT JOIN D_DE_DATOS.BI_DIAS D ON P.cod_dia_pedido = D.cod_dia
LEFT JOIN D_DE_DATOS.BI_RANGO_HORARIO R ON P.rango_horario_pedido = R.cod_rango_horario
LEFT JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
LEFT JOIN D_DE_DATOS.BI_LOCALIDADES LO ON L.cod_localidad = LO.cod_localidad
LEFT JOIN D_DE_DATOS.BI_CATEGORIAS_LOCALES C ON L.cod_categoria_local = C.cod_categoria_local
LEFT JOIN D_DE_DATOS.BI_TIPOS_LOCALES TL ON L.cod_tipo_local = TL.cod_tipo_local
GROUP BY
    D.desc_dia,
    T.tiempo_mes,
    T.tiempo_anio,
    R.desc_rango_horario,
    LO.nombre_localidad,
    LO.provincia_localidad,
    C.desc_categoria_local,
    TL.desc_tipo_local
ORDER BY
    ROW_NUMBER() OVER (PARTITION BY T.tiempo_mes, T.tiempo_anio ORDER BY COUNT(P.cod_pedido) DESC);
GO

-------------------------------------------------------

--VISTA 2
-- Monto total no cobrado por cada local en función de los pedidos
-- cancelados según el día de la semana y la franja horaria (cuentan como
-- pedidos cancelados tanto los que cancela el usuario como el local).

CREATE VIEW D_DE_DATOS.MONTO_NO_COBRADO_LOCALES
AS
SELECT 
	D.desc_dia AS Dia,
	R.desc_rango_horario AS FranjaHoraria,
    L.nombre_local AS NombreLocal,
	COUNT(P.cod_pedido) AS PedidosCancelados, 
    SUM(P.total_pedido) AS MontoTotal
FROM D_DE_DATOS.BI_PEDIDOS P
INNER JOIN D_DE_DATOS.BI_DIAS D ON P.cod_dia_pedido = D.cod_dia
INNER JOIN D_DE_DATOS.BI_RANGO_HORARIO R ON P.rango_horario_pedido = R.cod_rango_horario
INNER JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
WHERE P.cod_estado_pedido = 2
GROUP BY
    D.desc_dia,
    R.desc_rango_horario,
    L.nombre_local
GO

-------------------------------------------------------

--VISTA 3
-- Valor promedio mensual que tienen los envíos de pedidos en cada
-- localidad.
-- mes | localidad | promedioPrecioEnvios

 CREATE VIEW D_DE_DATOS.PROMEDIO_PRECIO_ENVIOS_POR_LOCALIDAD
 AS  
    SELECT 
	T.tiempo_mes AS Mes, 
	L.nombre_localidad AS Localidad,
	AVG(precio_envio) AS ValorPromedioEnvios
    FROM D_DE_DATOS.BI_ENVIOS E
    JOIN D_DE_DATOS.BI_LOCALIDADES L ON E.cod_localidad = L.cod_localidad
    JOIN D_DE_DATOS.BI_PEDIDOS P ON E.cod_pedido = P.cod_pedido
    JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_entrega = T.cod_tiempo
	GROUP BY 
	T.tiempo_mes, 
	L.nombre_localidad
 GO

 -------------------------------------------------------

--VISTA 4
-- Desvío promedio en tiempo de entrega según el tipo de movilidad, el día
-- de la semana y la franja horaria.
-- El desvío debe calcularse en minutos y representa la diferencia entre la
-- fecha/hora en que se realizó el pedido y la fecha/hora que se entregó en
-- comparación con los minutos de tiempo estimados.
-- Este indicador debe tener en cuenta todos los envíos, es decir, sumar tanto
-- los envíos de pedidos como los de mensajería.



CREATE VIEW D_DE_DATOS.DESVIOS_PROMEDIO AS
SELECT
    tipo_movilidad,
    dia_semana,
    franja_horaria,
    AVG(desvio_promedio) AS desvio_promedio_total
FROM
(
    SELECT
        TM.desc_movilidad_repartidor AS tipo_movilidad,
        dia_pedido.desc_dia AS dia_semana,
        rango_horario_pedido.desc_rango_horario AS franja_horaria,
        AVG(pedido.tiempo_entrega_estimado_pedido - DATEDIFF(MINUTE, pedido.fecha_pedido, pedido.fecha_entrega_pedido)) AS desvio_promedio
    FROM D_DE_DATOS.BI_PEDIDOS AS pedido
    JOIN D_DE_DATOS.BI_ENVIOS E ON E.cod_pedido = pedido.cod_pedido
    JOIN D_DE_DATOS.BI_REPARTIDORES R ON R.cod_repartidor = E.cod_repartidor
    JOIN D_DE_DATOS.BI_TIPOS_MOVILIDAD TM ON TM.cod_movilidad_repartidor = R.cod_movilidad_repartidor
    JOIN D_DE_DATOS.BI_DIAS AS dia_pedido ON pedido.cod_dia_pedido = dia_pedido.cod_dia
    JOIN D_DE_DATOS.BI_RANGO_HORARIO AS rango_horario_pedido ON pedido.rango_horario_pedido = rango_horario_pedido.cod_rango_horario
    GROUP BY TM.desc_movilidad_repartidor, dia_pedido.desc_dia, rango_horario_pedido.desc_rango_horario

    UNION

    SELECT
        TM.desc_movilidad_repartidor AS tipo_movilidad,
        dia_mensajeria.desc_dia AS dia_semana,
        rango_horario_mensajeria.desc_rango_horario AS franja_horaria,
        AVG(mensajeria.tiempo_entrega_estimado_mensajeria - DATEDIFF(MINUTE, mensajeria.fecha_mensajeria, mensajeria.fecha_entrega_mensajeria)) AS desvio_promedio
    FROM D_DE_DATOS.BI_SERVICIOS_MENSAJERIA AS mensajeria
    JOIN D_DE_DATOS.BI_REPARTIDORES AS R ON R.cod_repartidor = mensajeria.cod_repartidor
    JOIN D_DE_DATOS.BI_TIPOS_MOVILIDAD AS TM ON TM.cod_movilidad_repartidor = R.cod_movilidad_repartidor
    JOIN D_DE_DATOS.BI_DIAS AS dia_mensajeria ON mensajeria.cod_dia_mensajeria = dia_mensajeria.cod_dia
    JOIN D_DE_DATOS.BI_RANGO_HORARIO AS rango_horario_mensajeria ON mensajeria.cod_tiempo_mensajeria = rango_horario_mensajeria.cod_rango_horario
    GROUP BY TM.desc_movilidad_repartidor, dia_mensajeria.desc_dia, rango_horario_mensajeria.desc_rango_horario
) AS subquery
GROUP BY tipo_movilidad, dia_semana, franja_horaria;
GO
    


-------------------------------------------------------

--VISTA 5
-- Monto total de los cupones utilizados por mes en función del rango etario
-- de los usuarios. 

CREATE VIEW D_DE_DATOS.MONTO_TOTAL_CUPONES
AS
	SELECT 
	T.tiempo_mes AS Mes, 
	RE.desc_rango_etario AS RangoEtario, 
	SUM(C.monto_cupon) montoTotalCupones
	FROM D_DE_DATOS.BI_PEDIDOS_CUPON PC
	JOIN D_DE_DATOS.BI_PEDIDOS P ON PC.cod_pedido = P.cod_pedido
	JOIN D_DE_DATOS.BI_CUPONES_DESCUENTO C ON PC.cod_cupon = C.cod_cupon
	JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
	JOIN D_DE_DATOS.BI_USUARIOS U ON P.cod_usuario = U.cod_usuario
	JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON U.cod_rango_etario = RE.cod_rango_etario
	GROUP BY 
	T.tiempo_mes, 
	RE.desc_rango_etario
GO

-------------------------------------------------------

--VISTA 6
-- Promedio de calificación mensual por local.
-- mes | local | promedio calificacion

CREATE VIEW D_DE_DATOS.PROMEDIO_CALIFICACION_MENSUAL_POR_LOCAL
AS
	SELECT 
	T.tiempo_mes AS Mes, 
	L.nombre_local AS NombreLocal,
	AVG(calificacion_pedido) AS PromedioCalificacion
	FROM D_DE_DATOS.BI_PEDIDOS P
	JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_pedido = T.cod_tiempo
	JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
	GROUP BY 
	T.tiempo_mes, 
	L.nombre_local
GO

-------------------------------------------------------

--VISTA 7
-- Porcentaje de pedidos y mensajería entregados mensualmente 
-- según el rango etario de los repartidores y la localidad

-- Este indicador se debe tener en cuenta y sumar tanto los envíos de pedidos
-- como los de mensajería.

-- El porcentaje se calcula en función del total general de pedidos y envíos
-- mensuales entregados. 

CREATE VIEW D_DE_DATOS.PORCENTAJE_PEDIDOS_Y_ENVIOS_ENTREGADOS
AS
SELECT 
    Mes, 
    Localidad,
    RangoEtario,
    SUM(totalPedidosServicios) AS totalPedidosServicios,
    SUM(entregasRealizadas) AS entregasRealizadas,
    100 * SUM(entregasRealizadas) / SUM(totalPedidosServicios) AS PorcentajeEntregados
FROM
(
    SELECT 
        T.tiempo_mes AS Mes, 
        L.nombre_localidad AS Localidad,
        RE.desc_rango_etario AS RangoEtario,
        COUNT(*) AS totalPedidosServicios,
        COUNT(CASE WHEN cod_estado_pedido = 1 THEN 1 END) AS entregasRealizadas
    FROM D_DE_DATOS.BI_PEDIDOS P
    JOIN D_DE_DATOS.BI_ENVIOS E ON E.cod_pedido = P.cod_pedido
    JOIN D_DE_DATOS.BI_LOCALIDADES L ON E.cod_localidad = L.cod_localidad
    JOIN D_DE_DATOS.BI_REPARTIDORES R ON R.cod_repartidor = E.cod_repartidor
    JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON R.cod_rango_etario = RE.cod_rango_etario
    JOIN D_DE_DATOS.BI_TIEMPO T ON P.cod_tiempo_entrega = T.cod_tiempo
    GROUP BY  
        T.tiempo_mes, 
        L.nombre_localidad,
        RE.desc_rango_etario
    
    UNION ALL
    
    SELECT 
        T.tiempo_mes AS Mes, 
        L.nombre_localidad AS Localidad,
        RE.desc_rango_etario AS RangoEtario,
        COUNT(*) AS totalPedidosServicios,
        COUNT(CASE WHEN cod_tiempo_entrega_mensajeria IS NOT NULL THEN 1 END) AS entregasRealizadas
    FROM D_DE_DATOS.BI_SERVICIOS_MENSAJERIA M
    JOIN D_DE_DATOS.BI_TIEMPO T ON M.cod_tiempo_entrega_mensajeria = T.cod_tiempo
    JOIN D_DE_DATOS.BI_LOCALIDADES L ON M.cod_localidad = L.cod_localidad
    JOIN D_DE_DATOS.BI_REPARTIDORES R ON M.cod_repartidor = R.cod_repartidor
    JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON R.cod_rango_etario = RE.cod_rango_etario
    GROUP BY  
        T.tiempo_mes, 
        L.nombre_localidad,
        RE.desc_rango_etario
) AS subquery
GROUP BY Mes, Localidad, RangoEtario;
GO


-------------------------------------------------------

--VISTA 8
-- Promedio mensual del valor asegurado (valor declarado por el usuario) de los paquetes enviados
-- a través del servicio de mensajería en función del tipo de paquete. 

CREATE VIEW D_DE_DATOS.PROMEDIO_VALOR_ASEGURADO
AS
SELECT 
	T.tiempo_mes AS Mes,
	TP.desc_tipo_paquete AS TipoPaquete,
	AVG(valor_asegurado_mensajeria) AS promedioValorAsegurado
	FROM D_DE_DATOS.BI_SERVICIOS_MENSAJERIA M
	JOIN D_DE_DATOS.BI_TIPOS_PAQUETES TP ON M.cod_tipo_paquete = TP.cod_tipo_paquete
	JOIN D_DE_DATOS.BI_TIEMPO T ON M.cod_tiempo_mensajeria = T.cod_tiempo
	GROUP BY 
	T.tiempo_mes,
	TP.desc_tipo_paquete
GO

-------------------------------------------------------

--VISTA 9
-- Cantidad de reclamos mensuales 
-- recibidos por cada local en función del día de la semana y rango horario.
-- mes | local | diaSemana | rangoHorario | cantidadReclamos



 CREATE VIEW D_DE_DATOS.CANTIDAD_RECLAMOS
 AS
    SELECT  
	T.tiempo_mes AS Mes,
	L.nombre_local AS Local,
	D.desc_dia AS DiaSemana,
	RH.desc_rango_horario AS RangoHorario,
    COUNT(*) cantidadReclamos
    FROM D_DE_DATOS.BI_RECLAMOS R
	JOIN D_DE_DATOS.BI_DIAS D ON R.cod_dia_inicio_reclamo = D.cod_dia
	JOIN D_DE_DATOS.BI_TIEMPO T ON R.cod_tiempo_inicio_reclamo = T.cod_tiempo
    JOIN D_DE_DATOS.BI_PEDIDOS P ON R.cod_pedido = P.cod_pedido
	JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
	JOIN D_DE_DATOS.BI_RANGO_HORARIO RH ON P.rango_horario_pedido = RH.cod_rango_horario
	GROUP BY 
	T.tiempo_mes,
	L.nombre_local, 
	D.desc_dia, 
	RH.desc_rango_horario
 GO

 -------------------------------------------------------

--VISTA 10
-- Tiempo promedio de resolución de reclamos mensual según cada tipo de
-- reclamo y rango etario de los operadores.
-- El tiempo de resolución debe calcularse en minutos y representa la
-- diferencia entre la fecha/hora en que se realizó el reclamo y la fecha/hora
-- que se resolvió. 

CREATE VIEW D_DE_DATOS.PROMEDIO_TIEMPO_SOLUCION_RECLAMOS
AS
	SELECT 
	T.tiempo_mes AS Mes, 
	TR.desc_tipo_reclamo AS TipoReclamo,
	RE.desc_rango_etario AS RangoEtarioOperador,
	AVG (DATEDIFF(minute, fecha_reclamo, fecha_solucion_reclamo)) TiempoPromedioResolucion
	FROM D_DE_DATOS.BI_RECLAMOS R
	JOIN D_DE_DATOS.BI_TIEMPO T ON R.cod_tiempo_inicio_reclamo = T.cod_tiempo
	JOIN D_DE_DATOS.BI_TIPOS_RECLAMOS TR ON R.cod_tipo_reclamo = TR.cod_tipo_reclamo
	JOIN D_DE_DATOS.BI_OPERADORES O ON R.cod_operador = O.cod_operador
	JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON O.cod_rango_etario = RE.cod_rango_etario
	GROUP BY 
	T.tiempo_mes, 
	TR.desc_tipo_reclamo,
	RE.desc_rango_etario
GO

-------------------------------------------------------

--VISTA 11
-- Monto mensual generado en cupones a partir de reclamos. /*NOS FALTAN CUPONES*/

CREATE VIEW D_DE_DATOS.MONTO_CUPONES_RECLAMOS
AS
	SELECT 
	T.tiempo_mes,
	SUM(D.monto_cupon) MontoTotalCuponesReclamos
	FROM D_DE_DATOS.BI_RECLAMOS_CUPON RC
	JOIN D_DE_DATOS.BI_CUPONES_DESCUENTO D ON RC.cod_cupon = D.cod_cupon
	JOIN D_DE_DATOS.BI_TIEMPO T ON D.cod_tiempo_cupon = T.cod_tiempo
	GROUP BY T.tiempo_mes
 GO

 ------------------------------------------------------------------------------------------------------------

 --SELECTS DE LAS VISTAS
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