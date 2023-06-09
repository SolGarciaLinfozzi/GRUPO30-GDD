USE [GD1C2023]
GO

CREATE SCHEMA [D_DE_DATOS]
GO

-- MIGRACION DE DATOS

-- STORED PROCEDURES

CREATE PROCEDURE D_DE_DATOS.MigrarUsuarios
AS
BEGIN
    INSERT INTO D_DE_DATOS.USUARIOS (nombre_usuario,apellido_usuario,DNI_usuario,fecha_registro_usuario,telefono_usuario,correo_usuario,fecha_nacimiento_usuario)
    SELECT DISTINCT 
        USUARIO_NOMBRE, 
        USUARIO_APELLIDO,
        USUARIO_DNI,
        USUARIO_FECHA_REGISTRO,
        USUARIO_TELEFONO,
        USUARIO_MAIL,
        USUARIO_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE USUARIO_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarTiposCupones
AS
BEGIN
	INSERT INTO D_DE_DATOS.TIPOS_CUPONES(desc_tipo_cupon)
	SELECT DISTINCT cupon_tipo
	FROM gd_esquema.Maestra
	WHERE cupon_tipo IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarTiposLocales
AS
BEGIN
	INSERT INTO D_DE_DATOS.TIPOS_LOCALES(desc_tipo_local)
	SELECT DISTINCT LOCAL_TIPO
	FROM gd_esquema.Maestra
	WHERE LOCAL_TIPO IS NOT NULL;
END
GO


CREATE PROCEDURE D_DE_DATOS.MigrarTiposMediosPago
AS
BEGIN
	INSERT INTO D_DE_DATOS.TIPOS_MEDIOS_PAGO(desc_tipo_medio_pago)
	SELECT DISTINCT MEDIO_PAGO_TIPO
	FROM gd_esquema.Maestra
	WHERE MEDIO_PAGO_TIPO IS NOT NULL;
END
GO


CREATE PROCEDURE D_DE_DATOS.MigrarTiposMovilidad
AS
BEGIN
	INSERT INTO D_DE_DATOS.TIPOS_MOVILIDAD(desc_movilidad_repartidor)
	SELECT DISTINCT REPARTIDOR_TIPO_MOVILIDAD
	FROM gd_esquema.Maestra
	WHERE REPARTIDOR_TIPO_MOVILIDAD IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarTiposPaquetes
AS
BEGIN
	INSERT INTO D_DE_DATOS.TIPOS_PAQUETES(desc_tipo_paquete,alto_max_paquete,ancho_max_paquete,largo_max_paquete,peso_max_paquete,precio_paquete)
	SELECT DISTINCT 
		PAQUETE_TIPO,
		PAQUETE_ALTO_MAX,
		PAQUETE_ANCHO_MAX, 
		PAQUETE_LARGO_MAX, 
		PAQUETE_PESO_MAX, 
		PAQUETE_TIPO_PRECIO
	FROM gd_esquema.Maestra
	WHERE PAQUETE_TIPO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarTiposReclamos
AS
BEGIN
	INSERT INTO D_DE_DATOS.TIPOS_RECLAMOS(desc_tipo_reclamo)
	SELECT DISTINCT RECLAMO_TIPO
	FROM gd_esquema.Maestra
	WHERE RECLAMO_TIPO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarEstadosPedidos
AS
BEGIN
	INSERT INTO D_DE_DATOS.ESTADOS_PEDIDOS(desc_estado_pedido)
	SELECT DISTINCT PEDIDO_ESTADO
	FROM gd_esquema.Maestra
	WHERE PEDIDO_ESTADO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarEstadosMensajeria
AS
BEGIN
	INSERT INTO D_DE_DATOS.ESTADOS_MENSAJERIA(desc_estado_mensajeria)
	SELECT DISTINCT ENVIO_MENSAJERIA_ESTADO
	FROM gd_esquema.Maestra
	WHERE ENVIO_MENSAJERIA_ESTADO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarEstadosReclamos
AS
BEGIN
	INSERT INTO D_DE_DATOS.ESTADOS_RECLAMOS(desc_estado_reclamo)
	SELECT DISTINCT RECLAMO_ESTADO
	FROM gd_esquema.Maestra
	WHERE RECLAMO_ESTADO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarEstadosLocalidades
AS
BEGIN
	INSERT INTO D_DE_DATOS.LOCALIDADES(nombre_localidad, provincia_localidad)
	SELECT DISTINCT LOCAL_LOCALIDAD, LOCAL_PROVINCIA
	FROM gd_esquema.Maestra
	WHERE LOCAL_LOCALIDAD IS NOT NULL
	UNION
	SELECT DISTINCT envio_mensajeria_localidad, envio_mensajeria_provincia
	FROM gd_esquema.Maestra
	WHERE envio_mensajeria_localidad IS NOT NULL
	UNION
	SELECT DISTINCT DIRECCION_USUARIO_localidad, DIRECCION_USUARIO_provincia
	FROM gd_esquema.Maestra
	WHERE DIRECCION_USUARIO_LOCALIDAD IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarDias
AS
BEGIN
	INSERT INTO D_DE_DATOS.DIAS(desc_dia)
	SELECT DISTINCT HORARIO_LOCAL_DIA
	FROM gd_esquema.Maestra
	WHERE HORARIO_LOCAL_DIA IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarOperadores
AS
BEGIN
	INSERT INTO D_DE_DATOS.OPERADORES (nombre_operador,apellido_operador,DNI_operador,telefono_operador,direccion_operador,correo_operador,fecha_nacimiento_operador)
	SELECT DISTINCT 
		OPERADOR_RECLAMO_NOMBRE,
		OPERADOR_RECLAMO_APELLIDO,
		OPERADOR_RECLAMO_DNI,
		OPERADOR_RECLAMO_TELEFONO,
		OPERADOR_RECLAMO_DIRECCION,
		OPERADOR_RECLAMO_MAIL,
		OPERADOR_RECLAMO_FECHA_NAC
	FROM gd_esquema.Maestra
	WHERE OPERADOR_RECLAMO_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarDireccionesUsuarios
AS
BEGIN
	INSERT INTO D_DE_DATOS.DIRECCIONES_USUARIOS (cod_usuario, nombre_direccion_usuario,desc_direccion_usuario, cod_localidad)
	SELECT DISTINCT U.cod_usuario, DIRECCION_USUARIO_NOMBRE, DIRECCION_USUARIO_DIRECCION, L.cod_localidad
	FROM gd_esquema.Maestra
	INNER JOIN D_DE_DATOS.USUARIOS U ON U.nombre_usuario = gd_esquema.Maestra.USUARIO_NOMBRE
									AND U.dni_usuario = gd_esquema.Maestra.USUARIO_DNI
	INNER JOIN D_DE_DATOS.LOCALIDADES L ON L.nombre_localidad = gd_esquema.Maestra.DIRECCION_USUARIO_LOCALIDAD
									AND L.provincia_localidad = gd_esquema.Maestra.DIRECCION_USUARIO_PROVINCIA
END
GO


CREATE PROCEDURE D_DE_DATOS.MigrarMediosPago
AS
BEGIN
	INSERT INTO D_DE_DATOS.MEDIOS_PAGO (cod_usuario, cod_tipo_medio_pago, marca_tarjeta, tarjeta_nro)
	SELECT DISTINCT U.cod_usuario, TMP.cod_tipo_medio_pago, MARCA_TARJETA, MEDIO_PAGO_NRO_TARJETA
	FROM gd_esquema.Maestra
	INNER JOIN D_DE_DATOS.USUARIOS U ON U.nombre_usuario = USUARIO_NOMBRE
									AND U.dni_usuario = USUARIO_dni
	INNER JOIN D_DE_DATOS.TIPOS_MEDIOS_PAGO TMP ON TMP.desc_tipo_medio_pago = MEDIO_PAGO_TIPO;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarLocales
AS
BEGIN
	INSERT INTO D_DE_DATOS.LOCALES (nombre_local, desc_local, direccion_local, cod_localidad, cod_tipo_local)
	SELECT DISTINCT LOCAL_NOMBRE, LOCAL_DESCRIPCION, LOCAL_DIRECCION, L.cod_localidad, TL.cod_tipo_local
	FROM gd_esquema.Maestra M
	INNER JOIN D_DE_DATOS.LOCALIDADES L ON L.nombre_localidad = M.LOCAL_LOCALIDAD AND L.provincia_localidad = M.LOCAL_PROVINCIA
	INNER JOIN D_DE_DATOS.TIPOS_LOCALES TL ON TL.desc_tipo_local = M.LOCAL_TIPO;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarHorariosLocales
AS
BEGIN
	INSERT INTO D_DE_DATOS.HORARIOS_LOCALES (cod_local, horario_apertura_local, horario_cierre_local, cod_dia)
	SELECT DISTINCT l.cod_local, m.HORARIO_LOCAL_HORA_APERTURA, m.HORARIO_LOCAL_HORA_CIERRE, d.cod_dia
	FROM gd_esquema.Maestra m
	INNER JOIN D_DE_DATOS.DIAS d ON d.desc_dia = m.HORARIO_LOCAL_DIA
	INNER JOIN D_DE_DATOS.LOCALES l ON l.nombre_local = m.LOCAL_NOMBRE
	WHERE m.LOCAL_NOMBRE IS NOT NULL
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarProductos
AS
BEGIN
	INSERT INTO D_DE_DATOS.PRODUCTOS (cod_local, nombre_producto, desc_producto, precio_unitario_producto)
	SELECT DISTINCT L.cod_local, PRODUCTO_LOCAL_NOMBRE, PRODUCTO_LOCAL_DESCRIPCION, PRODUCTO_LOCAL_PRECIO
	from gd_esquema.Maestra M
	INNER JOIN D_DE_DATOS.LOCALES L ON L.nombre_local = M.LOCAL_NOMBRE
	WHERE M.PRODUCTO_LOCAL_NOMBRE IS NOT NULL
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarRepartidores
AS
BEGIN
	INSERT INTO D_DE_DATOS.REPARTIDORES (nombre_repartidor, apellido_repartidor, DNI_repartidor, telefono_repartidor, mail_repartidor, fecha_nacimiento_repartidor, dirección_repartidor, cod_movilidad_repartidor)
	SELECT DISTINCT
		M.REPARTIDOR_NOMBRE,
		M.REPARTIDOR_APELLIDO,
		M.REPARTIDOR_DNI,
		M.REPARTIDOR_TELEFONO,
		M.REPARTIDOR_EMAIL,
		M.REPARTIDOR_FECHA_NAC,
		M.REPARTIDOR_DIRECION,
		cod_movilidad_repartidor
	FROM
		gd_esquema.Maestra M
		INNER JOIN D_DE_DATOS.tipos_movilidad TM ON M.REPARTIDOR_TIPO_MOVILIDAD = TM.desc_movilidad_repartidor
	WHERE
		REPARTIDOR_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarPedidos
AS
BEGIN
		INSERT INTO D_DE_DATOS.PEDIDOS (cod_pedido,fecha_pedido, cod_usuario,cod_local,cod_medio_pago, tarifa_servicio_pedido, total_productos_pedido,total_descuentos, total_pedido, observaciones_pedido,cod_estado_pedido, tiempo_entrega_estimado_pedido, fecha_entrega_pedido, calificacion_pedido)
	SELECT DISTINCT
		M.PEDIDO_NRO,
		M.PEDIDO_FECHA,
		U.cod_usuario,
		L.cod_local,
		MP.cod_medio_pago,
		M.PEDIDO_TARIFA_SERVICIO,
		M.PEDIDO_TOTAL_PRODUCTOS,
		M.PEDIDO_TOTAL_CUPONES,
		M.PEDIDO_TOTAL_SERVICIO,
		M.PEDIDO_OBSERV,
		EP.cod_estado_pedido,
		M.PEDIDO_TIEMPO_ESTIMADO_ENTREGA,
		M.PEDIDO_FECHA_ENTREGA,
		M.PEDIDO_CALIFICACION
	FROM
		gd_esquema.Maestra M
		INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario 
		INNER JOIN D_DE_DATOS.LOCALES L ON M.LOCAL_NOMBRE = L.nombre_local AND M.LOCAL_DIRECCION = L.direccion_local
		INNER JOIN D_DE_DATOS.MEDIOS_PAGO MP ON M.MEDIO_PAGO_NRO_TARJETA = MP.tarjeta_nro AND M.USUARIO_DNI = U.DNI_usuario
		INNER JOIN D_DE_DATOS.ESTADOS_PEDIDOS EP ON M.PEDIDO_ESTADO = EP.desc_estado_pedido
	WHERE PEDIDO_NRO is not null
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarEnvios
AS
BEGIN
	INSERT INTO D_DE_DATOS.ENVIOS (cod_direccion_usuario, precio_envio, propina_envio, cod_repartidor, cod_localidad,cod_pedido)
	SELECT DISTINCT
		DU.cod_direccion_usuario,
		M.PEDIDO_PRECIO_ENVIO,
		M.PEDIDO_PROPINA,
		R.cod_repartidor,
		L.cod_localidad,
		P.cod_pedido
	FROM
		gd_esquema.Maestra M
		INNER JOIN D_DE_DATOS.LOCALIDADES L ON M.LOCAL_LOCALIDAD = L.nombre_localidad
		INNER JOIN D_DE_DATOS.DIRECCIONES_USUARIOS DU ON M.DIRECCION_USUARIO_DIRECCION = DU.desc_direccion_usuario
														AND L.cod_localidad = DU.cod_localidad
		INNER JOIN D_DE_DATOS.REPARTIDORES R ON M.REPARTIDOR_DNI = R.dni_repartidor
		INNER JOIN D_DE_DATOS.PEDIDOS P ON M.PEDIDO_NRO = P.cod_pedido
		WHERE M.PEDIDO_PRECIO_ENVIO IS NOT NULL
END
GO


CREATE PROCEDURE D_DE_DATOS.MigrarItems
AS
BEGIN
	INSERT INTO D_DE_DATOS.ITEMS (cod_producto, cod_pedido, cantidad_item, precio_unitario_item)
	SELECT DISTINCT
		P.cod_producto,
		PE.cod_pedido,
		M.PRODUCTO_CANTIDAD,
		M.PRODUCTO_LOCAL_PRECIO
	FROM
	gd_esquema.Maestra M
			INNER JOIN D_DE_DATOS.PRODUCTOS P ON M.PRODUCTO_LOCAL_NOMBRE = P.nombre_producto 
			AND M.PRODUCTO_LOCAL_PRECIO = P.precio_unitario_producto

			INNER JOIN D_DE_DATOS.PEDIDOS PE ON M.PEDIDO_FECHA = PE.fecha_pedido AND M.PEDIDO_TOTAL_SERVICIO = PE.total_pedido
			INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario
			INNER JOIN D_DE_DATOS.LOCALES L ON M.LOCAL_NOMBRE = L.nombre_local

	WHERE M.PEDIDO_NRO IS NOT NULL
		AND M.RECLAMO_NRO IS NULL;
END
GO


CREATE PROCEDURE D_DE_DATOS.MigrarCuponesDescuento
AS
BEGIN
	INSERT INTO D_DE_DATOS.CUPONES_DESCUENTO(cod_usuario,monto_cupon,fecha_alta_cupon,fecha_vencimiento_cupon,cod_tipo_cupon)
	SELECT DISTINCT
		U.cod_usuario,
		M.CUPON_MONTO,
		M.CUPON_FECHA_ALTA,
		M.CUPON_FECHA_VENCIMIENTO,
		T.cod_tipo_cupon
	FROM
	gd_esquema.Maestra M
			INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario 
			INNER JOIN D_DE_DATOS.TIPOS_CUPONES T ON M.CUPON_TIPO = T.desc_tipo_cupon
	WHERE CUPON_NRO IS NOT NULL
	UNION
	SELECT DISTINCT
		U.cod_usuario,
		M.CUPON_RECLAMO_MONTO,
		M.CUPON_RECLAMO_FECHA_ALTA,
		M.CUPON_RECLAMO_FECHA_VENCIMIENTO,
		T.cod_tipo_cupon
	FROM
	gd_esquema.Maestra M
			INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario 
			INNER JOIN D_DE_DATOS.TIPOS_CUPONES T ON M.CUPON_RECLAMO_TIPO = T.desc_tipo_cupon
	WHERE CUPON_RECLAMO_NRO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarPedidosCupon
AS
BEGIN
	INSERT INTO D_DE_DATOS.PEDIDOS_CUPON(cod_pedido,cod_cupon)
	SELECT DISTINCT
		PE.cod_pedido,
		C.cod_cupon
	FROM
	gd_esquema.Maestra M
		INNER JOIN D_DE_DATOS.PEDIDOS PE ON M.PEDIDO_FECHA = PE.fecha_pedido AND M.PEDIDO_TOTAL_SERVICIO = PE.total_pedido
		INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario
		INNER JOIN D_DE_DATOS.LOCALES L ON M.LOCAL_NOMBRE = L.nombre_local

		INNER JOIN D_DE_DATOS.CUPONES_DESCUENTO C ON M.CUPON_MONTO = C.monto_cupon AND M.CUPON_FECHA_ALTA = C.fecha_alta_cupon AND M.CUPON_FECHA_VENCIMIENTO = C.fecha_vencimiento_cupon
		
	WHERE PEDIDO_NRO IS NOT NULL AND RECLAMO_NRO IS NULL AND CUPON_NRO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarReclamos
AS
BEGIN
		INSERT INTO D_DE_DATOS.RECLAMOS(cod_reclamo,cod_usuario,cod_pedido,cod_tipo_reclamo,desc_reclamo,fecha_reclamo,cod_operador,cod_estado_reclamo,solucion_reclamo,fecha_solucion_reclamo,calificacion_solucion_reclamo)
	SELECT DISTINCT
	M.RECLAMO_NRO,
		U.cod_usuario,
		PE.cod_pedido,
		T.cod_tipo_reclamo,
		M.RECLAMO_DESCRIPCION,
		M.RECLAMO_FECHA,
		O.cod_operador,
		E.cod_estado_reclamo,
		M.RECLAMO_SOLUCION,
		M.RECLAMO_FECHA_SOLUCION,
		M.RECLAMO_CALIFICACION
	FROM
	gd_esquema.Maestra M
			INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario 
			INNER JOIN D_DE_DATOS.OPERADORES O ON M.OPERADOR_RECLAMO_DNI = O.DNI_operador AND M.OPERADOR_RECLAMO_NOMBRE = O.nombre_operador 

			INNER JOIN D_DE_DATOS.PEDIDOS PE ON M.PEDIDO_NRO = PE.cod_pedido

			INNER JOIN D_DE_DATOS.TIPOS_RECLAMOS T ON M.RECLAMO_TIPO = T.desc_tipo_reclamo
			INNER JOIN D_DE_DATOS.ESTADOS_RECLAMOS E ON M.RECLAMO_ESTADO = E.desc_estado_reclamo

	WHERE RECLAMO_NRO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarReclamosCupon
AS
BEGIN
	INSERT INTO D_DE_DATOS.RECLAMOS_CUPON(cod_reclamo,cod_cupon)
	SELECT DISTINCT
		PE.cod_pedido,
		C.cod_cupon
	FROM
	gd_esquema.Maestra M
		INNER JOIN D_DE_DATOS.PEDIDOS PE ON M.PEDIDO_FECHA = PE.fecha_pedido AND M.PEDIDO_TOTAL_SERVICIO = PE.total_pedido
		INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario
		INNER JOIN D_DE_DATOS.LOCALES L ON M.LOCAL_NOMBRE = L.nombre_local

		INNER JOIN D_DE_DATOS.CUPONES_DESCUENTO C ON M.CUPON_RECLAMO_MONTO  = C.monto_cupon AND M.CUPON_RECLAMO_FECHA_ALTA = C.fecha_alta_cupon AND M.CUPON_RECLAMO_FECHA_VENCIMIENTO = C.fecha_vencimiento_cupon
		
	WHERE PEDIDO_NRO IS NULL AND RECLAMO_NRO IS NOT NULL AND CUPON_RECLAMO_NRO IS NOT NULL;
END
GO

CREATE PROCEDURE D_DE_DATOS.MigrarServiciosMensajeria
AS
BEGIN
		INSERT INTO D_DE_DATOS.SERVICIOS_MENSAJERIA (cod_mensajeria,cod_usuario,fecha_mensajeria , direccion_origen_mensajeria , direccion_destino_mensajeria ,cod_localidad, km_mensajeria ,cod_tipo_paquete, valor_asegurado_mensajeria , observaciones_mensajeria , precio_envio_mensajeria  , precio_seguro_mensajeria  ,cod_repartidor, propina_mensajeria,cod_medio_pago, total_mensajeria  , cod_estado_mensajeria, tiempo_entrega_estimado_mensajeria  , fecha_entrega_mensajeria ,calificacion_mensajeria  )
	SELECT DISTINCT
	    M.ENVIO_MENSAJERIA_NRO,
		U.cod_usuario,
		M.ENVIO_MENSAJERIA_FECHA,
		M.ENVIO_MENSAJERIA_DIR_ORIG,
		M.ENVIO_MENSAJERIA_DIR_DEST,
		L.cod_localidad,
		M.ENVIO_MENSAJERIA_KM,
		TP.cod_tipo_paquete,
		M.ENVIO_MENSAJERIA_VALOR_ASEGURADO,
		M.ENVIO_MENSAJERIA_OBSERV,
		M.ENVIO_MENSAJERIA_PRECIO_ENVIO,
		M.ENVIO_MENSAJERIA_PRECIO_SEGURO,
		R.cod_repartidor,
		M.ENVIO_MENSAJERIA_PROPINA,
		MP.cod_medio_pago,
		M.ENVIO_MENSAJERIA_TOTAL,
		E.cod_estado_mensajeria,
		M.ENVIO_MENSAJERIA_TIEMPO_ESTIMADO,
		M.ENVIO_MENSAJERIA_FECHA_ENTREGA,
		M.ENVIO_MENSAJERIA_CALIFICACION

	FROM
		gd_esquema.Maestra M
		INNER JOIN D_DE_DATOS.USUARIOS U ON M.USUARIO_DNI = U.DNI_usuario 
		INNER JOIN D_DE_DATOS.LOCALIDADES L ON M.ENVIO_MENSAJERIA_LOCALIDAD = L.nombre_localidad AND M.ENVIO_MENSAJERIA_PROVINCIA = L.provincia_localidad
		INNER JOIN D_DE_DATOS.TIPOS_PAQUETES TP ON M.PAQUETE_TIPO = TP.desc_tipo_paquete
		INNER JOIN D_DE_DATOS.REPARTIDORES R ON M.REPARTIDOR_DNI = R.DNI_repartidor
		INNER JOIN D_DE_DATOS.MEDIOS_PAGO MP ON M.MEDIO_PAGO_NRO_TARJETA = MP.tarjeta_nro AND M.USUARIO_DNI = U.DNI_usuario
		INNER JOIN D_DE_DATOS.ESTADOS_MENSAJERIA E ON M.ENVIO_MENSAJERIA_ESTADO = E.desc_estado_mensajeria

	WHERE ENVIO_MENSAJERIA_NRO is not null;
END
GO

-- CREACION DE TABLAS

CREATE TABLE D_DE_DATOS.USUARIOS (
	cod_usuario INT IDENTITY(1,1) PRIMARY KEY,
	nombre_usuario NVARCHAR(255) NOT NULL,
	apellido_usuario NVARCHAR(255) NOT NULL,
	DNI_usuario DECIMAL(18, 0) NOT NULL,
	fecha_registro_usuario DATETIME2(3) NOT NULL,
	telefono_usuario DECIMAL(18, 0) NOT NULL,
	correo_usuario NVARCHAR(255) NOT NULL,
	fecha_nacimiento_usuario DATE NOT NULL
);

CREATE TABLE D_DE_DATOS.LOCALIDADES (
	cod_localidad INT IDENTITY(1,1) PRIMARY KEY,
	nombre_localidad NVARCHAR(255) NOT NULL,
	provincia_localidad NVARCHAR(255) NOT NULL
);

CREATE TABLE D_DE_DATOS.DIRECCIONES_USUARIOS (
	cod_direccion_usuario INT IDENTITY(1,1) PRIMARY KEY,
	cod_usuario INT NOT NULL,
	nombre_direccion_usuario NVARCHAR(50) NOT NULL,
	desc_direccion_usuario NVARCHAR(255) NOT NULL,
	cod_localidad INT NOT NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades
);

CREATE TABLE D_DE_DATOS.TIPOS_MOVILIDAD (
	cod_movilidad_repartidor INT IDENTITY(1,1) PRIMARY KEY,
	desc_movilidad_repartidor NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.REPARTIDORES (
	cod_repartidor INT IDENTITY(1,1) PRIMARY KEY,
	nombre_repartidor NVARCHAR(255) NOT NULL,
	apellido_repartidor NVARCHAR(255) NOT NULL,
	DNI_repartidor DECIMAL(18,0) NOT NULL,
	telefono_repartidor DECIMAL(18,0) NOT NULL,
	mail_repartidor NVARCHAR(255) NOT NULL,
	fecha_nacimiento_repartidor DATETIME NOT NULL,
	dirección_repartidor NVARCHAR(255) NOT NULL,
	cod_movilidad_repartidor INT NOT NULL,
	cod_localidad INT NULL,
	FOREIGN KEY (cod_movilidad_repartidor) REFERENCES D_DE_DATOS.tipos_movilidad,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades
);

CREATE TABLE D_DE_DATOS.ENVIOS (
	cod_envio INT IDENTITY(1,1) PRIMARY KEY,
	cod_direccion_usuario INT NOT NULL,
	precio_envio DECIMAL(18,2) NOT NULL,
	propina_envio DECIMAL(18,2) NULL,
	cod_repartidor INT NOT NULL,
	cod_localidad INT NOT NULL,
	cod_pedido INT NOT NULL,
	FOREIGN KEY (cod_direccion_usuario) REFERENCES D_DE_DATOS.direcciones_usuarios,
	FOREIGN KEY (cod_repartidor) REFERENCES D_DE_DATOS.repartidores,
	FOREIGN KEY (cod_localidad) REFERENCES D_DE_DATOS.localidades,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.pedidos
);

CREATE TABLE D_DE_DATOS.TIPOS_MEDIOS_PAGO (
	cod_tipo_medio_pago INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_medio_pago NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.MEDIOS_PAGO (
	cod_medio_pago INT IDENTITY(1,1) PRIMARY KEY,
	cod_usuario INT NOT NULL,
	cod_tipo_medio_pago INT NOT NULL,
	marca_tarjeta NVARCHAR(100) NULL,
	tarjeta_nro NVARCHAR(50) NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_tipo_medio_pago) REFERENCES D_DE_DATOS.tipos_medios_pago
);

CREATE TABLE D_DE_DATOS.TIPOS_LOCALES (
    cod_tipo_local INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_local NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.CATEGORIAS_LOCALES (
    cod_categoria_local INT IDENTITY(1,1) PRIMARY KEY,
	desc_categoria_local NVARCHAR(50) NOT NULL
);

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

CREATE TABLE D_DE_DATOS.DIAS (
    cod_dia INT IDENTITY(1,1) PRIMARY KEY,
	desc_dia NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.HORARIOS_LOCALES (
    cod_horario_local INT IDENTITY(1,1) PRIMARY KEY,
	cod_local INT NOT NULL,
	horario_apertura_local DECIMAL(18,0) NOT NULL,
	horario_cierre_local DECIMAL(18,0) NOT NULL,
	cod_dia INT NOT NULL,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.locales,
	FOREIGN KEY (cod_dia) REFERENCES D_DE_DATOS.dias
);

CREATE TABLE D_DE_DATOS.ESTADOS_PEDIDOS (
    cod_estado_pedido INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_pedido NVARCHAR(50) NOT NULL
);


CREATE TABLE D_DE_DATOS.PEDIDOS (
	cod_pedido INT PRIMARY KEY,
	fecha_pedido DATETIME2(3) NOT NULL,
	cod_usuario INT NOT NULL,
	cod_local INT NOT NULL, 
	cod_medio_pago INT NOT NULL,
	tarifa_servicio_pedido DECIMAL(18,2) NOT NULL,
	total_productos_pedido DECIMAL(18,2) NOT NULL,
	total_pedido DECIMAL(18,2) NOT NULL,
	total_descuentos DECIMAL(18,2) NOT NULL,
	observaciones_pedido NVARCHAR(255) NULL,
	cod_estado_pedido INT NOT NULL,
	tiempo_entrega_estimado_pedido DECIMAL(18,2) NOT NULL,
	fecha_entrega_pedido DATETIME2(3) NULL,
	calificacion_pedido DECIMAL(18,0) NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.locales,
	FOREIGN KEY (cod_medio_pago) REFERENCES D_DE_DATOS.medios_pago,
	FOREIGN KEY (cod_estado_pedido) REFERENCES D_DE_DATOS.estados_pedidos
);


CREATE TABLE D_DE_DATOS.PRODUCTOS (
    cod_producto INT IDENTITY(1,1) PRIMARY KEY,
    cod_local INT NOT NULL,
    nombre_producto NVARCHAR(50) NOT NULL,
    desc_producto NVARCHAR(255) NOT NULL,
    precio_unitario_producto DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (cod_local) REFERENCES D_DE_DATOS.locales
);

CREATE TABLE D_DE_DATOS.ITEMS (
    cod_item INT IDENTITY(1,1) PRIMARY KEY,
    cod_producto INT NOT NULL,
    cod_pedido INT NOT NULL,
    cantidad_item INT NOT NULL,
    precio_unitario_item DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (cod_producto) REFERENCES D_DE_DATOS.productos,
    FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.pedidos
);

CREATE TABLE D_DE_DATOS.OPERADORES (
	cod_operador INT IDENTITY(1,1) PRIMARY KEY,
	nombre_operador NVARCHAR(255) NOT NULL,
	apellido_operador NVARCHAR(255) NOT NULL,
	DNI_operador DECIMAL(18,0) NOT NULL,
	telefono_operador DECIMAL(18,0) NOT NULL,
	direccion_operador NVARCHAR(255) NOT NULL,
	correo_operador NVARCHAR(255) NOT NULL,
	fecha_nacimiento_operador DATE NOT NULL
);

CREATE TABLE D_DE_DATOS.TIPOS_RECLAMOS (
	cod_tipo_reclamo INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_reclamo NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.ESTADOS_RECLAMOS (
	cod_estado_reclamo INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_reclamo NVARCHAR(50) NOT NULL
);


CREATE TABLE D_DE_DATOS.RECLAMOS (
	cod_reclamo INT PRIMARY KEY,
	cod_usuario INT NOT NULL,
	cod_pedido INT NOT NULL,
	cod_tipo_reclamo INT NOT NULL,
	desc_reclamo NVARCHAR(255) NULL,
	fecha_reclamo DATETIME2(3) NOT NULL,
	cod_operador INT NOT NULL,
	cod_estado_reclamo INT NOT NULL,
	solucion_reclamo NVARCHAR(255) NULL,
	fecha_solucion_reclamo DATETIME2(3) NULL,
	calificacion_solucion_reclamo DECIMAL(18,0) NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.pedidos,
	FOREIGN KEY (cod_tipo_reclamo) REFERENCES D_DE_DATOS.tipos_reclamos,
	FOREIGN KEY (cod_operador) REFERENCES D_DE_DATOS.operadores,
	FOREIGN KEY (cod_estado_reclamo) REFERENCES D_DE_DATOS.estados_reclamos
);

CREATE TABLE D_DE_DATOS.TIPOS_CUPONES (
	cod_tipo_cupon INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_cupon NVARCHAR(255) NOT NULL
);

CREATE TABLE D_DE_DATOS.CUPONES_DESCUENTO (
	cod_cupon INT PRIMARY KEY,
	cod_usuario INT NOT NULL,
	monto_cupon DECIMAL (18,2) NOT NULL,
	fecha_alta_cupon DATETIME2(3) NOT NULL,
	fecha_vencimiento_cupon DATETIME2(3) NOT NULL,
	cod_tipo_cupon INT NOT NULL,
	FOREIGN KEY (cod_usuario) REFERENCES D_DE_DATOS.usuarios,
	FOREIGN KEY (cod_tipo_cupon) REFERENCES D_DE_DATOS.tipos_cupones
);

CREATE TABLE D_DE_DATOS.RECLAMOS_CUPON (
	cod_reclamo INT NOT NULL,
	cod_cupon INT NOT NULL,
	FOREIGN KEY (cod_reclamo) REFERENCES D_DE_DATOS.reclamos,
	FOREIGN KEY (cod_cupon) REFERENCES D_DE_DATOS.cupones_descuento,
	PRIMARY KEY (cod_reclamo, cod_cupon)
);

CREATE TABLE D_DE_DATOS.PEDIDOS_CUPON (
	cod_pedido INT NOT NULL,
	cod_cupon INT NOT NULL,
	FOREIGN KEY (cod_pedido) REFERENCES D_DE_DATOS.pedidos,
	FOREIGN KEY (cod_cupon) REFERENCES D_DE_DATOS.cupones_descuento,
	PRIMARY KEY (cod_pedido, cod_cupon)
);

CREATE TABLE D_DE_DATOS.TIPOS_PAQUETES (
	cod_tipo_paquete INT IDENTITY(1,1) PRIMARY KEY,
	desc_tipo_paquete NVARCHAR(50) NOT NULL,
	alto_max_paquete DECIMAL(18,2) NOT NULL,
	ancho_max_paquete  DECIMAL(18,2) NOT NULL,
	largo_max_paquete  DECIMAL(18,2) NOT NULL,
	peso_max_paquete  DECIMAL(18,2) NOT NULL,
	precio_paquete  DECIMAL(18,2) NOT NULL
);

CREATE TABLE D_DE_DATOS.ESTADOS_MENSAJERIA (
	cod_estado_mensajeria INT IDENTITY(1,1) PRIMARY KEY,
	desc_estado_mensajeria NVARCHAR(50) NOT NULL
);

CREATE TABLE D_DE_DATOS.SERVICIOS_MENSAJERIA (
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

-- Ejecucion de los Stored Procedures

EXECUTE D_DE_DATOS.MigrarUsuarios;
EXECUTE D_DE_DATOS.MigrarTiposCupones;
EXECUTE D_DE_DATOS.MigrarTiposLocales;
EXECUTE D_DE_DATOS.MigrarTiposMediosPago;
EXECUTE D_DE_DATOS.MigrarTiposMovilidad;
EXECUTE D_DE_DATOS.MigrarTiposPaquetes;
EXECUTE D_DE_DATOS.MigrarTiposReclamos;
EXECUTE D_DE_DATOS.MigrarEstadosPedidos;
EXECUTE D_DE_DATOS.MigrarEstadosMensajeria;
EXECUTE D_DE_DATOS.MigrarEstadosReclamos;
EXECUTE D_DE_DATOS.MigrarEstadosLocalidades;
EXECUTE D_DE_DATOS.MigrarDias;
EXECUTE D_DE_DATOS.MigrarOperadores;
EXECUTE D_DE_DATOS.MigrarDireccionesUsuarios;
EXECUTE D_DE_DATOS.MigrarMediosPago;
EXECUTE D_DE_DATOS.MigrarLocales;
EXECUTE D_DE_DATOS.MigrarHorariosLocales;
EXECUTE D_DE_DATOS.MigrarProductos;
EXECUTE D_DE_DATOS.MigrarRepartidores;
EXECUTE D_DE_DATOS.MigrarEnvios;
EXECUTE D_DE_DATOS.MigrarPedidos;
-- EXECUTE D_DE_DATOS.MigrarItems;
EXECUTE D_DE_DATOS.MigrarCuponesDescuento;
-- EXECUTE D_DE_DATOS.MigrarPedidosCupon;
EXECUTE D_DE_DATOS.MigrarReclamos;
-- EXECUTE D_DE_DATOS.MigrarReclamosCupon;
EXECUTE D_DE_DATOS.MigrarServiciosMensajeria;

PRINT 'Migracion finalizada exitosamente'
GO 

-- CREACION DE INDICES 

CREATE INDEX IDX_ENVIO_USUARIO
ON D_DE_DATOS.SERVICIOS_MENSAJERIA(cod_usuario,cod_mensajeria);

CREATE INDEX IDX_REPARTIDOR
ON D_DE_DATOS.SERVICIOS_MENSAJERIA(cod_repartidor, cod_mensajeria)
