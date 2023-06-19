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
    cod_dia INT IDENTITY(1,1) PRIMARY KEY,
	desc_dia NVARCHAR(50) NOT NULL
);

-- Rango horario (De 8 a 00 cada 2 horas)
CREATE TABLE D_DE_DATOS.BI_RANGO_HORARIO(
    cod_rango_horario INT IDENTITY(1,1) PRIMARY KEY,
    desc_rango_horario NVARCHAR(50) NOT NULL
);

-- Provincia/Localidad
CREATE TABLE D_DE_DATOS.BI_LOCALIDADES (
	cod_localidad INT IDENTITY(1,1) PRIMARY KEY,
	nombre_localidad NVARCHAR(255) NOT NULL,
	provincia_localidad NVARCHAR(255) NOT NULL
);

-- Rango etario usuario/repartidor/operario
CREATE TABLE D_DE_DATOS.BI_RANGO_ETARIO(
    cod_rango_etario INT IDENTITY(1,1) PRIMARY KEY,
    desc_rango_etario NVARCHAR(50) NOT NULL
);

-- Tipo Medio de pagoX
CREATE TABLE D_DE_DATOS.BI_TIPOS_MEDIOS_PAGO (
	cod_tipo_medio_pago INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_medio_pago NVARCHAR(50) NOT NULL
);

-- Local
CREATE TABLE D_DE_DATOS.BI_LOCALES (
    cod_local INT IDENTITY(1,1) PRIMARY KEY,
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


-- Tipo de Local/Categoría de Local

-- Tipo de Local
CREATE TABLE D_DE_DATOS.BI_TIPOS_LOCALES (
    cod_tipo_local INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_local NVARCHAR(50) NOT NULL
);

-- Categoria de Local
CREATE TABLE D_DE_DATOS.BI_CATEGORIAS_LOCALES (
    cod_categoria_local INT IDENTITY(1,1) PRIMARY KEY,
	desc_categoria_local NVARCHAR(50) NOT NULL
);

-- Tipo Movilidad
CREATE TABLE D_DE_DATOS.BI_TIPOS_MOVILIDAD (
	cod_movilidad_repartidor INT IDENTITY(1,1) PRIMARY KEY,
	desc_movilidad_repartidor NVARCHAR(50) NOT NULL
);

-- Tipo Paquete
CREATE TABLE D_DE_DATOS.BI_TIPOS_PAQUETES (
	cod_tipo_paquete INT IDENTITY(1,1) PRIMARY KEY,
	precio_paquete DECIMAL(18,2) NOT NULL,
);

-- Estados pedidos
CREATE TABLE D_DE_DATOS.BI_ESTADOS_PEDIDOS (
    cod_estado_pedido INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_pedido NVARCHAR(50) NOT NULL
);

-- Estado envíos mensajería
CREATE TABLE D_DE_DATOS.BI_ESTADOS_MENSAJERIA (
	cod_estado_mensajeria INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_mensajeria NVARCHAR(50) NOT NULL
);

-- Estados reclamos
CREATE TABLE D_DE_DATOS.BI_ESTADOS_RECLAMOS (
	cod_estado_reclamo INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_reclamo NVARCHAR(50) NOT NULL
);

---------------- TABLAS EXTRAS ----------------
-- Estas tablas son FK de las tablas de hechos. Vamos a utilizarlas para hacer uso de lo que nos
-- piden en las views. Ej: monto total de los cupones utilizados por mes en función del rango etario
-- de los usuarios.

-- Usuarios
CREATE TABLE D_DE_DATOS.BI_USUARIOS (
	cod_usuario INT IDENTITY(1,1),
	rango_etario INT,
	fecha_nacimiento_usuario DATE NOT NULL,
);

-- Repartidores
CREATE TABLE D_DE_DATOS.BI_REPARTIDORES (
	cod_repartidor INT IDENTITY(1,1) PRIMARY KEY,
	rango_etario INT,
	cod_movilidad_repartidor INT NOT NULL,
);


-- Operadores 
CREATE TABLE D_DE_DATOS.BI_OPERADORES (
	cod_operador INT IDENTITY(1,1) PRIMARY KEY,
	rango_etario INT,
	fecha_nacimiento_operador DATE NOT NULL,
);

---------------- TABLAS DE HECHOS ----------------

-- Hechos pedidos
CREATE TABLE D_DE_DATOS.BI_PEDIDOS (
	cod_pedido DECIMAL(18,0) PRIMARY KEY,
	dia_pedido NVARCHAR(30) NOT NULL,
	mes_pedido INT NOT NULL,
	anio_pedido INT NOT NULL,
	rango_horario_pedido INT NOT NULL,
	dia_entrega INT NOT NULL,
	mes_entrega INT NOT NULL, 
	anio_entrega INT NOT NULL
	rango_horario_entrega INT NOT NULL, 
	cod_local INT NOT NULL, 
	tarifa_servicio_pedido DECIMAL(18,2) NOT NULL,
	total_productos_pedido DECIMAL(18,2) NOT NULL,
	total_pedido DECIMAL(18,2) NOT NULL,
	total_descuentos DECIMAL(18,2) NOT NULL,
	total_servicios DECIMAL(18,2) NOT NULL,
	calificacion_pedido DECIMAL(18,0) NULL,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.BI_LOCALES,
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


---------------------------------------------------------------------------------

--Creación de vistas

-- ● Día de la semana y franja horaria con mayor cantidad de pedidos según la
-- localidad y categoría del local, para cada mes de cada año.
-- 13
-- ● Monto total no cobrado por cada local en función de los pedidos
-- cancelados según el día de la semana y la franja horaria (cuentan como
-- pedidos cancelados tanto los que cancela el usuario como el local).
-- ● Valor promedio mensual que tienen los envíos de pedidos en cada
-- localidad.
-- ● Desvío promedio en tiempo de entrega según el tipo de movilidad, el día
-- de la semana y la franja horaria.
-- El desvío debe calcularse en minutos y representa la diferencia entre la
-- fecha/hora en que se realizó el pedido y la fecha/hora que se entregó en
-- comparación con los minutos de tiempo estimados.
-- Este indicador debe tener en cuenta todos los envíos, es decir, sumar tanto
-- los envíos de pedidos como los de mensajería.
-- ● Monto total de los cupones utilizados por mes en función del rango etario
-- de los usuarios.
-- ● Promedio de calificación mensual por local.
-- ● Porcentaje de pedidos y mensajería entregados mensualmente según el
-- rango etario de los repartidores y la localidad.
-- Este indicador se debe tener en cuenta y sumar tanto los envíos de pedidos
-- como los de mensajería.
-- El porcentaje se calcula en función del total general de pedidos y envíos
-- mensuales entregados.
-- ● Promedio mensual del valor asegurado (valor declarado por el usuario) de
-- los paquetes enviados a través del servicio de mensajería en función del
-- tipo de paquete.
-- ● Cantidad de reclamos mensuales recibidos por cada local en función del
-- día de la semana y rango horario.
-- ● Tiempo promedio de resolución de reclamos mensual según cada tipo de
-- reclamo y rango etario de los operadores.
-- El tiempo de resolución debe calcularse en minutos y representa la
-- diferencia entre la fecha/hora en que se realizó el reclamo y la fecha/hora
-- que se resolvió.
-- ● Monto mensual generado en cupones a partir de reclamos.


---------------------------------------------------------------------------------------

---------------- MIGRACIONES A DIMENSIONES ----------------

--Rango Etario
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RANGO_ETARIO
AS
BEGIN 
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(desc_rango_etario)
	VALUES('<25')
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(desc_rango_etario)
	VALUES('25-35')
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(desc_rango_etario)
	VALUES('35-55')
INSERT INTO D_DE_DATOS.BI_RANGO_ETARIO(desc_rango_etario)
	VALUES('>55')
END
GO

--Rango horario
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_RANGO_HORARIO
AS
BEGIN 
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('08:00 - 10:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('10:00 - 12:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('12:00 - 14:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('14:00 - 16:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('16:00 - 18:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('18:00 - 20:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('20:00 - 22:00')
INSERT INTO D_DE_DATOS.BI_RANGO_HORARIO(desc_rango_horario)
	VALUES('22:00 - 00:00')
END
GO

-- Localidades
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALIDADES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_LOCALIDADES (cod_localidad, nombre_localidad, provincia_localidad)
		SELECT cod_localidad, nombre_localidad, provincia_localidad
		FROM D_DE_DATOS.LOCALIDADES
  END
GO

-- Locales
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_LOCALES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_LOCALES (nombre_local, desc_local, cod_localidad, cod_tipo_local, cod_categoria_local)
		SELECT L.nombre_local, L.desc_local, LO.cod_localidad, TL.cod_tipo_local, CL.cod_categoria_local
		FROM D_DE_DATOS.LOCALES L
		INNER JOIN D_DE_DATOS.LOCALIDADES LO ON L.cod_localidad = LO.cod_localidad
		INNER JOIN D_DE_DATOS.TIPOS_LOCALES TL ON L.cod_tipo_local = TL.cod_tipo_local
		INNER JOIN D_DE_DATOS.CATEGORIAS_LOCALES CL ON L.cod_categoria_local = CL.cod_categoria_local
  END
GO

---------------------------------------------------------------------------------------

---------------- MIGRACIONES A TABLAS EXTRAS ----------------

-- Repartidores
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_REPARTIDORES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_REPARTIDORES (rango_etario, cod_movilidad_repartidor)
		SELECT D_DE_DATOS.CALCULAR_RANGO_ETARIO(fecha_nacimiento_repartidor), TM.cod_movilidad_repartidor
		FROM D_DE_DATOS.REPARTIDORES R
		INNER JOIN D_DE_DATOS.TIPOS_MOVILIDAD TM ON TM.cod_movilidad_repartidor = R.cod_movilidad_repartidor
  END
GO

-- Usuarios
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_USUARIOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_USUARIOS (rango_etario, fecha_nacimiento_usuario)
		SELECT D_DE_DATOS.CALCULAR_RANGO_ETARIO(fecha_nacimiento_usuario), fecha_nacimiento_usuario
		FROM D_DE_DATOS.USUARIOS
  END
GO

-- Operadores
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_OPERADORES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_OPERADORES (rango_etario, fecha_nacimiento_operador)
		SELECT D_DE_DATOS.CALCULAR_RANGO_ETARIO(fecha_nacimiento_operador), fecha_nacimiento_operador
		FROM D_DE_DATOS.OPERADORES
  END
GO

-- Tipo paquete
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_TIPOS_PAQUETES
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_TIPOS_PAQUETES (precio_paquete)
		SELECT precio_paquete FROM D_DE_DATOS.TIPOS_PAQUETES
  END
GO

-- Envios
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_ENVIOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_ENVIOS (cod_direccion_usuario,
	precio_envio,
	cod_repartidor,
	cod_localidad,
	cod_pedido)
		SELECT D.cod_direccion_usuario, E.precio_envio, R.cod_repartidor, L.cod_localidad, P.cod_pedido
		  FROM D_DE_DATOS.ENVIOS E
		  INNER JOIN D_DE_DATOS.DIRECCIONES_USUARIOS D on E.cod_direccion_usuario = D.co
		  INNER JOIN D_DE_DATOS.REPARTIDORES R on E.cod_repartidor = R.cod_repartidor
		  INNER JOIN D_DE_DATOS.LOCALIDADES L on E.cod_localidad = L.cod_localidad
		  INNER JOIN D_DE_DATOS.PEDIDOS P on E.cod_pedido = P.cod_pedido
		  END
GO

---------------------------------------------------------------------------------------

---------------- MIGRACIONES A HECHOS ----------------

-- Hechos pedidos
CREATE PROCEDURE D_DE_DATOS.MIGRAR_BI_PEDIDOS
 AS
  BEGIN
    INSERT INTO D_DE_DATOS.BI_PEDIDOS 
	(cod_pedido,
	dia_pedido,
	mes_pedido,
	anio_pedido,
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
	total_servicios,
	calificacion_pedido
	)
		SELECT cod_pedido,
		  D_DE_DATOS.CALCULAR_DIA_SEMANA(fecha_pedido) AS dia_pedido,
		  YEAR(fecha_pedido) AS anio_pedido,
  		  MONTH(fecha_pedido) AS mes_pedido,
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
		  total_servicios,
		  calificacion_pedido
		  FROM D_DE_DATOS.PEDIDOS
		  END
GO

-- Faltan migraciones a pedidos, envios y entiendo que a servicios_mensajeria