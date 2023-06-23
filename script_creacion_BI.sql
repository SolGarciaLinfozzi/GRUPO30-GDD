USE [GD1C2023]
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

-- Provincia/Localidad
CREATE TABLE D_DE_DATOS.BI_LOCALIDADES (
	cod_localidad INT PRIMARY KEY,
	nombre_localidad NVARCHAR(255) NOT NULL,
	provincia_localidad NVARCHAR(255) NOT NULL
);

-- Rango etario usuario/repartidor/operario
CREATE TABLE D_DE_DATOS.BI_RANGO_ETARIO(
    cod_rango_etario INT PRIMARY KEY,
    desc_rango_etario NVARCHAR(50) NOT NULL
);

-- Tipo Medio de pagoX
CREATE TABLE D_DE_DATOS.BI_TIPOS_MEDIOS_PAGO (
	cod_tipo_medio_pago INT PRIMARY KEY,
	desc_tipo_medio_pago NVARCHAR(50) NOT NULL
);

-- Tipo de Local/Categoría de Local

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
    desc_local NVARCHAR(255) NOT NULL,
    direccion_local NVARCHAR(255) NOT NULL,
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
	precio_paquete DECIMAL(18,2) NOT NULL,
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

-- Estados reclamos
CREATE TABLE D_DE_DATOS.BI_ESTADOS_RECLAMOS (
	cod_estado_reclamo INT  PRIMARY KEY,
	desc_estado_reclamo NVARCHAR(50) NOT NULL
);

---------------- TABLAS EXTRAS ----------------
-- Estas tablas son FK de las tablas de hechos. Vamos a utilizarlas para hacer uso de lo que nos
-- piden en las views. Ej: monto total de los cupones utilizados por mes en función del rango etario
-- de los usuarios.

-- Usuarios
CREATE TABLE D_DE_DATOS.BI_USUARIOS (
	cod_usuario INT PRIMARY KEY,
	rango_etario INT,
	fecha_nacimiento_usuario DATE NOT NULL,
);

-- Repartidores
CREATE TABLE D_DE_DATOS.BI_REPARTIDORES (
	cod_repartidor INT PRIMARY KEY,
	rango_etario INT,
	cod_movilidad_repartidor INT NOT NULL,
);

-- Operadores 
CREATE TABLE D_DE_DATOS.BI_OPERADORES (
	cod_operador INT PRIMARY KEY,
	rango_etario INT,
	fecha_nacimiento_operador DATE NOT NULL,
);

-- Cupones
CREATE TABLE D_DE_DATOS.BI_TIPOS_CUPON (
	cod_tipo_cupon INT  PRIMARY KEY,
	desc_tipo_cupon NVARCHAR(255) NOT NULL
);

CREATE TABLE D_DE_DATOS.BI_CUPONES_DESCUENTO (
	cod_cupon INT  PRIMARY KEY,
	cod_cupon_anterior INT NULL,
	cod_usuario INT NOT NULL,
	monto_cupon DECIMAL (18,2) NOT NULL,
	fecha_alta_cupon DATETIME2(3) NOT NULL,
	fecha_vencimiento_cupon DATETIME2(3) NOT NULL,
	cod_tipo_cupon INT NOT NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_tipo_cupon) REFERENCES D_DE_DATOS.tipos_cupones
);

--Envios_mensajería

CREATE TABLE D_DE_DATOS.BI_MEDIOS_PAGO (
	cod_medio_pago INT PRIMARY KEY,
	cod_usuario INT NOT NULL,
	cod_tipo_medio_pago INT NOT NULL,
	marca_tarjeta NVARCHAR(100) NULL,
	tarjeta_nro NVARCHAR(50) NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_tipo_medio_pago) REFERENCES D_DE_DATOS.tipos_medios_pago
);



CREATE TABLE D_DE_DATOS.BI_SERVICIOS_MENSAJERIA (
	cod_mensajeria INT PRIMARY KEY,
	cod_usuario INT NOT NULL,
	fecha_mensajeria DATETIME2(3) NOT NULL,
	direccion_origen_mensajeria NVARCHAR(255) NOT NULL,
	direccion_destino_mensajeria NVARCHAR(255) NOT NULL,
	cod_localidad INT NOT NULL,
	km_mensajeria DECIMAL(18,2) NOT NULL,
	cod_tipo_paquete INT NOT NULL,
	valor_asegurado_mensajeria DECIMAL(18,2) NOT NULL,
	observaciones_mensajeria NVARCHAR(255) NULL,
	precio_envio_mensajeria  DECIMAL(18,2) NOT NULL,
	precio_seguro_mensajeria  DECIMAL(18,2) NOT NULL,
	cod_repartidor INT NOT NULL,
	propina_mensajeria  DECIMAL(18,2) NULL,
	cod_medio_pago INT NOT NULL,
	total_mensajeria  DECIMAL(18,2) NOT NULL,
	cod_estado_mensajeria INT NOT NULL,
	tiempo_entrega_estimado_mensajeria  DECIMAL(18,2) NOT NULL,
	fecha_entrega_mensajeria DATETIME2(3) NULL,
	calificacion_mensajeria DECIMAL(18,2) NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades,
	FOREIGN KEY (cod_tipo_paquete) REFERENCES D_DE_DATOS.tipos_paquetes,
	FOREIGN KEY (cod_repartidor) REFERENCES D_DE_DATOS.repartidores,
	FOREIGN KEY (cod_medio_pago) REFERENCES D_DE_DATOS.medios_pago,
	FOREIGN KEY (cod_estado_mensajeria) REFERENCES D_DE_DATOS.estados_mensajeria
);

--------------------------------------------------------------------------------------

---------------- TABLAS DE HECHOS ----------------

-- Hechos pedidos
CREATE TABLE D_DE_DATOS.BI_PEDIDOS (
	cod_pedido DECIMAL(18,0) PRIMARY KEY,
	dia_pedido NVARCHAR(30) NOT NULL,
	cod_tiempo INT NOT NULL,
	rango_horario_pedido INT NOT NULL,
	dia_entrega INT NOT NULL,
	mes_entrega INT NOT NULL, 
	anio_entrega INT NOT NULL,
	rango_horario_entrega INT NOT NULL, 
	cod_local INT NOT NULL, 
	tarifa_servicio_pedido DECIMAL(18,2) NOT NULL,
	total_productos_pedido DECIMAL(18,2) NOT NULL,
	total_pedido DECIMAL(18,2) NOT NULL,
	total_descuentos DECIMAL(18,2) NOT NULL,
	calificacion_pedido DECIMAL(18,0) NULL,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.BI_LOCALES,
	FOREIGN KEY (cod_tiempo) REFERENCES D_DE_DATOS.BI_TIEMPO
);

-- Hechos envios
CREATE TABLE D_DE_DATOS.BI_ENVIOS (
	cod_envio INT IDENTITY(1,1) PRIMARY KEY,
	cod_direccion_usuario INT NOT NULL,
	precio_envio DECIMAL(18,2) NOT NULL,
	cod_repartidor INT NOT NULL,
	cod_localidad INT NOT NULL,
	cod_pedido DECIMAL(18,0) NOT NULL,
	FOREIGN KEY (cod_direccion_usuario) REFERENCES D_DE_DATOS.BI_DIRECCIONES_USUARIOS,
	FOREIGN KEY (cod_repartidor) REFERENCES D_DE_DATOS.BI_REPARTIDORES,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.BI_LOCALIDADES,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.BI_PEDIDOS
);

-- Hechos reclamos - a revisar
CREATE TABLE D_DE_DATOS.BI_RECLAMOS (
	cod_reclamo DECIMAL(18,0) PRIMARY KEY,
	cod_usuario INT NOT NULL,
	cod_pedido DECIMAL(18,0) NOT NULL,
	cod_tipo_reclamo INT NOT NULL,
	desc_reclamo NVARCHAR(255) NULL,
	dia_inicio_reclamo NVARCHAR(30),
	mes_inicio_reclamo INT NOT NULL,
	anio_inicio_reclamo INT NOT NULL,
	rango_horario_inicio_reclamo INT NOT NULL,
	dia_solucion NVARCHAR(30),
	mes_solucion INT NOT NULL,
	anio_solucion INT NOT NULL, 
	rango_horario_solucion INT NOT NULL,
	cod_operador INT NOT NULL,
	cod_estado_reclamo INT NOT NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.BI_USUARIOS,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.BI_PEDIDOS,
	FOREIGN KEY (cod_tipo_reclamo) REFERENCES D_DE_DATOS.BI_TIPOS_RECLAMOS,
	FOREIGN KEY (cod_operador) REFERENCES D_DE_DATOS.BI_OPERADORES,
	FOREIGN KEY (cod_estado_reclamo) REFERENCES D_DE_DATOS.BI_ESTADOS_RECLAMOS
);

-------------------------------------------------------------------------------------------

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
	VALUES(4,'Miercoles')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(5,'Jueves')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(6,'Viernes')
INSERT INTO D_DE_DATOS.BI_DIAS(cod_dia,desc_dia)
	VALUES(7,'Sabado')
END
GO

-- Localidades
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALIDADES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_LOCALIDADES (cod_localidad,nombre_localidad, provincia_localidad)
		SELECT cod_localidad, nombre_localidad, provincia_localidad
		FROM D_DE_DATOS.LOCALIDADES
  END
GO

-- Locales
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_LOCALES (cod_local, nombre_local, desc_local, cod_localidad, cod_tipo_local, cod_categoria_local,direccion_local)
		SELECT L.cod_local, L.nombre_local, L.desc_local, L.cod_localidad, L.cod_tipo_local, L.cod_categoria_local, L.direccion_local
		FROM D_DE_DATOS.LOCALES L
  END
GO

-- Tipo paquete
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_PAQUETES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIPOS_PAQUETES (cod_tipo_paquete,precio_paquete)
		SELECT cod_tipo_paquete, precio_paquete FROM D_DE_DATOS.TIPOS_PAQUETES
  END
GO

--Tiempo 
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIEMPO
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIEMPO (tiempo_anio,tiempo_mes)
		SELECT DISTINCT YEAR(fecha_pedido), MONTH(fecha_pedido)
		FROM D_DE_DATOS.PEDIDOS
  END
GO


---------------------------------------------------------------------------------------

---------------- MIGRACIONES A TABLAS EXTRAS ----------------

-- Repartidores
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_REPARTIDORES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_REPARTIDORES (cod_repartidor, rango_etario, cod_movilidad_repartidor)
		SELECT R.cod_repartidor,D_DE_DATOS.CALCULAR_RANGO_ETARIO(R.fecha_nacimiento_repartidor), R.cod_movilidad_repartidor
		FROM D_DE_DATOS.REPARTIDORES R
  END
GO

-- Usuarios
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_USUARIOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_USUARIOS (cod_usuario, rango_etario, fecha_nacimiento_usuario)
		SELECT U.cod_usuario, D_DE_DATOS.CALCULAR_RANGO_ETARIO(U.fecha_nacimiento_usuario), U.fecha_nacimiento_usuario
		FROM D_DE_DATOS.USUARIOS U
  END
GO

-- Operadores
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_OPERADORES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_OPERADORES (cod_operador, rango_etario, fecha_nacimiento_operador)
		SELECT O.cod_operador, D_DE_DATOS.CALCULAR_RANGO_ETARIO(O.fecha_nacimiento_operador), O.fecha_nacimiento_operador
		FROM D_DE_DATOS.OPERADORES O
  END
GO


---------------------------------------------------------------------------------------

---------------- MIGRACIONES A HECHOS ----------------

CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_PEDIDOS 
	(cod_pedido,
	dia_pedido,
	cod_tiempo,
	rango_horario_pedido,
	dia_entrega,
	mes_entrega,
	anio_entrega,
	rango_horario_entrega,
	cod_local,
	tarifa_servicio_pedido,
	total_productos_pedido,
	total_pedido,
	total_descuentos,
	calificacion_pedido
	)
		SELECT cod_pedido,
		  D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_pedido) AS dia_pedido,
		  T.cod_tiempo,
		  D_DE_DATOS.CALCULAR_RANGO_HORARIO(fecha_pedido) AS rango_horario_pedido,
		  D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_entrega_pedido) AS dia_entrega,
		  YEAR(fecha_entrega_pedido) AS anio_entrega,
    	  MONTH(fecha_entrega_pedido) AS mes_entrega,
		  D_DE_DATOS.CALCULAR_RANGO_HORARIO(fecha_entrega_pedido) AS rango_horario_entrega,
		  cod_local,
		  tarifa_servicio_pedido,
		  total_productos_pedido,
		  total_pedido,
		  total_descuentos,
		  calificacion_pedido
		  FROM D_DE_DATOS.PEDIDOS P
		  INNER JOIN D_DE_DATOS.BI_TIEMPO T ON (T.tiempo_anio = YEAR(P.fecha_pedido) AND T.tiempo_mes = MONTH(P.fecha_pedido))
		  END
GO


-- Envios

CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_ENVIOS
 AS
	BEGIN
    INSERT INTO D_DE_DATOS.BI_ENVIOS (
	cod_direccion_usuario,
	precio_envio,
	cod_repartidor,
	cod_localidad,
	cod_pedido)
		SELECT E.cod_direccion_usuario, E.precio_envio, E.cod_repartidor,E.cod_localidad, E.cod_pedido
		  FROM D_DE_DATOS.ENVIOS E
	END
GO

-- Faltan migraciones a pedidos, envios y entiendo que a servicios_mensajeria




---------------------------------------------------------------------------------

--Creación de vistas

-- ● Día de la semana y franja horaria con mayor cantidad de pedidos según la
-- localidad y categoría del local, para cada mes de cada año.
CREATE VIEW BI_D_DE_DATOS_MAYOR_CANTIDAD_PEDIDOS
AS
SELECT T.tiempo_mes, L.nombre_localidad, CL.desc_categoria_local,
(SELECT COUNT(*) FROM P) cantidadPedidos
FROM D_DE_DATOS.BI_PEDIDOS P
	JOIN D_DE_DATOS.BI_LOCALES LO ON P.cod_local = LO.cod_local
	JOIN D_DE_DATOS.BI_ENVIOS E ON P.cod_pedido = E.cod_pedido
	JOIN D_DE_DATOS.BI_LOCALIDADES L ON E.cod_localidad = L.cod_localidad
	JOIN D_DE_DATOS.BI_CATEGORIAS_LOCALES CL ON LO.cod_categoria_local = CL.cod_categoria_local
	JOIN D_DE_DATOS.BI_TIEMPO T ON P.mes_pedido = T.tiempo_mes
GROUP BY T.tiempo_mes, L.nombre_localidad, CL.desc_categoria_local
GO

-- ● Monto total no cobrado por cada local en función de los pedidos
-- cancelados según el día de la semana y la franja horaria (cuentan como
-- pedidos cancelados tanto los que cancela el usuario como el local).
CREATE VIEW BI_D_DE_DATOS_MONTO_NO_COBRADO
AS
	SELECT D.desc_dia, R.desc_rango_horario, L.nombre_local,
	(SELECT SUM(total_pedido) FROM P WHERE dia_entrega IS NULL) totalPedidosEnregados
	FROM D_DE_DATOS.BI_PEDIDOS P
	JOIN D_DE_DATOS.BI_DIAS D ON P.dia_pedido = D.desc_dia
	JOIN D_DE_DATOS.BI_LOCALES L ON P.cod_local = L.cod_local
	JOIN D_DE_DATOS.BI_RANGO_HORARIO R ON P.rango_horario_pedido = R.desc_rango_horario
	GROUP BY D.desc_dia, R.desc_rango_horario, L.nombre_local
GO
-- ● Valor promedio mensual que tienen los envíos de pedidos en cada
-- localidad.
-- mes | localidad | promedioPrecioEnvios
 CREATE VIEW BI_D_DE_DATOS.PROMEDIO_PRECIO_ENVIOS_POR_LOCALIDAD
 AS  
    SELECT T.tiempo_mes, L.nombre_localidad,
    (SUM(E.precio_envio) / (SELECT COUNT(*) FROM E)) promedioPrecioEnvios

     FROM D_DE_DATOS.BI_ENVIOS E
     JOIN D_DE_DATOS.BI_LOCALIDADES L ON E.cod_localidad = L.cod_localidad
     JOIN D_DE_DATOS.BI_PEDIDOS P ON E.cod_pedido = P.cod_pedido
     JOIN D_DE_DATOS.BI_TIEMPO T ON P.mes_entrega = T.tiempo_mes
	 GROUP BY T.tiempo_mes, L.nombre_localidad
 GO
-- ● Desvío promedio en tiempo de entrega según el tipo de movilidad, el día
-- de la semana y la franja horaria.
-- El desvío debe calcularse en minutos y representa la diferencia entre la
-- fecha/hora en que se realizó el pedido y la fecha/hora que se entregó en
-- comparación con los minutos de tiempo estimados.
-- Este indicador debe tener en cuenta todos los envíos, es decir, sumar tanto
-- los envíos de pedidos como los de mensajería.
-- ● Monto total de los cupones utilizados por mes en función del rango etario
-- de los usuarios. /*NOS FALTAN CUPONES*/
CREATE VIEW BI_D_DE_DATOS_MONTO_TOTAL_CUPONES
AS
	SELECT T.tiempo_mes, RE.desc_rango_etario, SUM(C.monto_cupon) sumaMontoCupones
	FROM D_DE_DATOS.BI_USUARIOS U
	JOIN D_DE_DATOS.BI_CUPONES C ON U.cod_usuario = C.cod_usuario
	JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON U.rango_etario = RE.cod_rango_etario
	JOIN D_DE_DATOS.BI_TIEMPO T ON C.mes_alta_cupon = T.tiempo_mes
	GROUP BY T.tiempo_mes, RE.desc_rango_etario
GO
-- ● Promedio de calificación mensual por local.
-- mes | local | promedio calificacion
CREATE VIEW BI_D_DE_DATOS.PROMEDIO_CALIFICACION_MENSUAL_POR_LOCAL
 AS
     SELECT T.tiempo_mes, L.desc_local, 
     (SUM(P.calificacion_pedido) / (SELECT COUNT(*) FROM P)) promedioCalificaciones

     FROM D_DE_DATOS.BI_LOCALES L
     JOIN D_DE_DATOS.BI_PEDIDOS P ON L.cod_local = P.cod_local
    JOIN D_DE_DATOS.BI_TIEMPO T ON P.mes_pedido = T.tiempo_mes
    GROUP BY T.tiempo_mes, L.desc_local
 GO
-- ● Porcentaje de pedidos y mensajería entregados mensualmente según el
-- rango etario de los repartidores y la localidad.
-- Este indicador se debe tener en cuenta y sumar tanto los envíos de pedidos
-- como los de mensajería.
-- El porcentaje se calcula en función del total general de pedidos y envíos
-- mensuales entregados. /*HECHO SOLO PARA PEDIDOS*/
CREATE VIEW BI_D_DE_DATOS_PORCENTAJE_PEDIDOS_Y_ENVIOS_ENTREGADOS
AS
	SELECT T.tiempo_mes, L.desc_localidad, RE.desc_rango_etario,
	(SELECT COUNT(*) FROM P WHERE dia_entrega IS NOT NULL /*pedidos entregados*/) / (SELECT COUNT(*) FROM P /*pedidos totales*/) porcentaje
	FROM D_DE_DATOS.BI_PEDIDOS P
	JOIN D_DE_DATOS.BI_ENVIO E ON P.cod_pedido = E.cod_envio
JOIN D_DE_DATOS.BI_LOCALIDADES L ON E.cod_localidad = L.cod_localidad
	JOIN D_DE_DATOS.BI_REPARTIDORES R ON E.cod_repartidor = R.cod_repartidor
	JOIN D_DE_DATOS.BI_RANGO_ETARIO RE ON R.rango_etario = RE.cod_rango_etario
	JOIN D_DE_DATOS.BI_TIEMPO T ON P.mes_pedido = T.tiempo_mes
	GROUP BY T.tiempo_mes, L.desc_localidad, RE.desc_rango_etario
GO
-- ● Promedio mensual del valor asegurado (valor declarado por el usuario) de
-- los paquetes enviados a través del servicio de mensajería en función del
-- tipo de paquete. /*NOS FALTA ENVIO MENSAJERIA, LO HAGO COMO SI LO TUVIERAMOS */
CREATE VIEW BI_D_DE_DATOS_PROMEDIO_VALOR_ASEGURADO
AS
SELECT T.tiempo_mes, TP.cod_tipo_paquete /*como no tenemos desc_tipo_paquete no sabia si iba esto
	o el precio*/, 
	((SELECT SUM(valor_asegurado_mensajeria) FROM EM) / (SELECT COUNT(*) FROM EM)) promedio
	FROM D_DE_DATOS.BI_ENVIOS_MENSAJERIA EM
	JOIN D_DE_DATOS.BI_TIPOS_PAQUETES TP ON EM.cod_tipo_paquete = TP.cod_tipo_paquete
JOIN D_DE_DATOS.BI_TIEMPO T ON EM.mes_envio_mensajeria = T.tiempo_mes
	GROUP BY T.tiempo_mes, TP.cod_tipo_paquete
GO
-- ● Cantidad de reclamos mensuales recibidos por cada local en función del
-- día de la semana y rango horario.
-- mes | local | diaSemana | rangoHorario | cantidadReclamos
 CREATE VIEW BI_D_DE_DATOS.CANTIDAD_RECLAMOS
 AS
     SELECT T.tiempo_mes, L.desc_local, R.dia_inicio_reclamo, R.rango_horario_inicio_reclamo,
     (SELECT COUNT(*) FROM R) cantidadReclamos

     FROM D_DE_DATOS.BI_LOCALES L
     JOIN D_DE_DATOS.BI_PEDIDOS P ON L.cod_local = P.cod_local
    JOIN D_DE_DATOS.BI_RECLAMOS R ON P.cod_pedido = R.cod_pedido
    JOIN D_DE_DATOS.BI_TIEMPO T ON R.mes_inicio_reclamo = T.tiempo_mes
	GROUP BY T.tiempo_mes, L.desc_local, R.dia_inicio_reclamo, R.rango_horario_inicio_reclamo
 GO
-- ● Tiempo promedio de resolución de reclamos mensual según cada tipo de
-- reclamo y rango etario de los operadores.
-- El tiempo de resolución debe calcularse en minutos y representa la
-- diferencia entre la fecha/hora en que se realizó el reclamo y la fecha/hora
-- que se resolvió. /*NOS FALTA TIPO RECLAMO. PARA RESOLVER COMO PIDE NECESITARIAMOS LA HORA EXACTA DE INICIO Y 
/*RESOLUCION DEL RECLAMO. POR AHORA SOLO TENEMOS EL RANGO HORARIO */
CREATE VIEW BI_D_DE_DATOS_PROMEDIO_TIEMPO_SOLUCION_RECLAMOS
AS
	SELECT T.tiempo_mes, TR.desc_tipo_reclamo, RE.desc_rango_etario, 
	((SELECT SUM(hora_fin_reclamo - hora_inicio_reclamo) FROM R) / (SELECT COUNT(*) FROM R)) promedio
	FROM D_DE_DATOS.BI_ENVIOS_RECLAMOS R
JOIN D_DE_DATOS.BI_ENVIOS_TIPOS_RECLAMOS TR ON R.cod_tipo_reclamo = TR.cod_tipo_reclamo
	JOIN D_DE_DATOS.BI_ENVIOS_OPERADORES O ON R.cod_operador = O.cod_operador
	JOIN D_DE_DATOS.BI_ENVIOS_RANGO_ETARIO RE ON O.rengo_etario = RE.cod_rango_etario
JOIN D_DE_DATOS.BI_ENVIOS_TIEMPO T ON R.mes_inicio_reclamo = T.tiempo_mes	GROUP BY T.tiempo_mes, TR.desc_tipo_reclamo, RE.desc_rango_etario
GO
-- ● Monto mensual generado en cupones a partir de reclamos. /*NOS FALTAN CUPONES*/
CREATE VIEW BI_D_DE_DATOS_CUPONES_RECLAMOS
AS
	SELECT T.tiempo_mes, SUM(C.monto_cupon) sumaMontoCupones
	FROM D_DE_DATOS.BI_CUPONES C
	JOIN D_DE_DATOS.BI_TIPOS_CUPONES TC ON C.cod_tipo_cupon = TC.cod_tipo_cupon
	WHERE TC.desc_tipo_cupon = /*acá va cupón de reclamo*/
	GROUP BY T.tiempo_mes
 GO

