USE [GD1C2023]
GO

-- Creación de las tablas

-- Tiempo (año, mes)
CREATE TABLE D_DE_DATOS.BI_TIEMPO(
	cod_tiempo INT IDENTITY(1,1) PRIMARY KEY,
	tiempo_anio INT,
	tiempo_mes INT
);
GO
-- Rango horario (De 8 a 00 cada 2 horas)
CREATE TABLE D_DE_DATOS.BI_RANGO_HORARIO(
    cod_rango_horario INT IDENTITY(1,1) PRIMARY KEY,
    desc_rango_horario NVARCHAR(50) NOT NULL
);
GO

-- Rango etario usuario/repartidor/operario
CREATE TABLE D_DE_DATOS.BI_RANGO_ETARIO(
    cod_rango_etario INT IDENTITY(1,1) PRIMARY KEY,
    desc_rango_etario NVARCHAR(50) NOT NULL
);
GO


-- Día (Se corresponde con los días de la semana: L-M-M-J-V-S-D)
CREATE TABLE D_DE_DATOS.DIAS (
    cod_dia INT IDENTITY(1,1) PRIMARY KEY,
	desc_dia NVARCHAR(50) NOT NULL
);

-- Provincia/Localidad
CREATE TABLE D_DE_DATOS.LOCALIDADES (
	cod_localidad INT IDENTITY(1,1) PRIMARY KEY,
	nombre_localidad NVARCHAR(255) NOT NULL,
	provincia_localidad NVARCHAR(255) NOT NULL
);

-- Tipo Medio de pago
CREATE TABLE D_DE_DATOS.TIPOS_MEDIOS_PAGO (
	cod_tipo_medio_pago INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_medio_pago NVARCHAR(50) NOT NULL
);

-- Tipo de Local/Categoría de Local
CREATE TABLE D_DE_DATOS.TIPOS_LOCALES (
    cod_tipo_local INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_local NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.CATEGORIAS_LOCALES (
    cod_categoria_local INT IDENTITY(1,1) PRIMARY KEY,
	desc_categoria_local NVARCHAR(50) NOT NULL
);

-- Local
CREATE TABLE D_DE_DATOS.LOCALES (
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

-- Tipo Movilidad
CREATE TABLE D_DE_DATOS.TIPOS_MOVILIDAD (
	cod_movilidad_repartidor INT IDENTITY(1,1) PRIMARY KEY,
	desc_movilidad_repartidor NVARCHAR(50) NOT NULL
);

-- Tipo Paquete
CREATE TABLE D_DE_DATOS.TIPOS_PAQUETES (
	cod_tipo_paquete INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_paquete NVARCHAR(50) NOT NULL,
	alto_max_paquete DECIMAL(18,2) NOT NULL,
	ancho_max_paquete  DECIMAL(18,2) NOT NULL,
	largo_max_paquete  DECIMAL(18,2) NOT NULL,
	peso_max_paquete  DECIMAL(18,2) NOT NULL,
	precio_paquete  DECIMAL(18,2) NOT NULL
);

-- Estados pedidos
CREATE TABLE D_DE_DATOS.ESTADOS_PEDIDOS (
    cod_estado_pedido INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_pedido NVARCHAR(50) NOT NULL
);

-- Estado envíos mensajería
CREATE TABLE D_DE_DATOS.ESTADOS_MENSAJERIA (
	cod_estado_mensajeria INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_mensajeria NVARCHAR(50) NOT NULL
);


-- Estados reclamos
CREATE TABLE D_DE_DATOS.ESTADOS_RECLAMOS (
	cod_estado_reclamo INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_reclamo NVARCHAR(50) NOT NULL
);

-------------------------------------------------------------------------------------------

--Funciones

--Rango Etario
CREATE FUNCTION D_DE_DATOS.FX_CALCULAR_RANGO_ETARIO(@FECHA_NAC DATETIME2(3))
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
CREATE FUNCTION D_DE_DATOS.FX_CALCULAR_RANGO_HORARIO(@FECHA_HORA DATETIME2(3))
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

--Migracion

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