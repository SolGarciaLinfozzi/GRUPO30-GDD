-- CLASE 8

-- PRÁCTICA 1: TRIGGERS

USE Comercial;

--1. Dada la tabla Products de la base de datos stores7 se requiere crear una tabla
--Products_historia_precios y crear un trigger que registre los cambios de precios que se hayan
--producido en la tabla Products.

--Tabla Products_historia_precios
-- Stock_historia_Id Identity (PK)
-- Stock_num
-- Manu_code
-- fechaHora (grabar fecha y hora del evento)
-- usuario (grabar usuario que realiza el cambio de precios)
-- unit_price_old
-- unit_price_new
-- estado char default ‘A’ check (estado IN (‘A’,’I’)

DROP TABLE products_historia_precios;
CREATE TABLE products_historia_precios (
	stock_historia_id int IDENTITY(1,1) PRIMARY KEY,
	stock_num smallint,
	manu_code char(3),
	fechaHora datetime,
	usuario varchar(20),
	unit_price_old decimal(6,2),
	unit_price_new decimal(6,2),
	estado char DEFAULT 'A' CHECK(estado IN('A','I')),
);

DROP TRIGGER dbo.cambios_precios;
CREATE TRIGGER cambios_precios 
ON products 
AFTER UPDATE AS
BEGIN
	DECLARE @stock_num smallint
	DECLARE @manu_code char(3)
	DECLARE @unit_price_old decimal(6,2)
	DECLARE @unit_price_new decimal(6,2)

	DECLARE Cursor_precios_stock CURSOR FOR
	SELECT I.stock_num, I.manu_code, I.unit_price, D.unit_price
	FROM inserted I 
	JOIN deleted D ON (I.stock_num = D.stock_num AND I.manu_code = D.manu_code)
	WHERE I.unit_price != D.unit_price

	OPEN Cursor_precios_stock

	FETCH NEXT FROM Cursor_precios_stock
	INTO @stock_num, @manu_code, @unit_price_new, @unit_price_old

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO products_historia_precios (stock_num, manu_code, unit_price_new, unit_price_old, fechaHora, usuario)
		VALUES (@stock_num, @manu_code, @unit_price_new, @unit_price_old, GETDATE(), SYSTEM_USER)
		
		FETCH NEXT FROM Cursor_precios_stock
		INTO @stock_num, @manu_code, @unit_price_new, @unit_price_old
	END
	CLOSE Cursor_precios_stock
	DEALLOCATE Cursor_precios_stock

END

SELECT * FROM dbo.products;
UPDATE products SET unit_price = 500 WHERE stock_num = 1;
SELECT * FROM dbo.products_historia_precios;


--2. Crear un trigger sobre la tabla Products_historia_precios que ante un delete sobre la misma
--realice en su lugar un update del campo estado de ‘A’ a ‘I’ (inactivo).

DROP TRIGGER productos_eliminados;
CREATE TRIGGER productos_eliminados 
ON Products_historia_precios
INSTEAD OF DELETE AS
BEGIN
	DECLARE @stock_historia_id INT

	DECLARE Cursor_delete_productos CURSOR FOR
	SELECT stock_historia_id
	FROM deleted 

	OPEN Cursor_delete_productos

	FETCH NEXT FROM Cursor_delete_productos
	INTO @stock_historia_id
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		UPDATE products_historia_precios
		SET estado = 'I' 
		WHERE stock_historia_id = @stock_historia_id
		
		FETCH NEXT FROM Cursor_delete_productos
		INTO @stock_historia_id
	END
	CLOSE Cursor_delete_productos
	DEALLOCATE Cursor_delete_productos

END

SELECT * FROM Products_historia_precios;
DELETE FROM Products_historia_precios WHERE manu_code = 'SMT';


--3. Validar que sólo se puedan hacer inserts en la tabla Products en un horario entre las 8:00 AM y
--8:00 PM. En caso contrario enviar un error por pantalla.

DROP TRIGGER validacion_upd_products;
CREATE TRIGGER validacion_upd_products 
ON products 
INSTEAD OF INSERT AS
BEGIN

	IF(  DATEPART(HOUR, GETDATE()) BETWEEN 8 AND 20   )
		BEGIN
			INSERT INTO products (stock_num, manu_code, unit_price, unit_code)
			SELECT stock_num, manu_code, unit_price, unit_code
			FROM inserted
		END
	ELSE
		BEGIN
		RAISERROR('Maestro que hace a esta hora laburando?', 16, 1)
		END

END


--4. Crear un trigger que ante un borrado sobre la tabla ORDERS realice un borrado en cascada
--sobre la tabla ITEMS, validando que sólo se borre 1 orden de compra.
--Si detecta que están queriendo borrar más de una orden de compra, informará un error y
--abortará la operación.

DROP TRIGGER eliminar_orden;
CREATE TRIGGER eliminar_orden
ON orders
INSTEAD OF DELETE AS
BEGIN

	DECLARE @order_num INT

	IF((SELECT COUNT(*) FROM deleted) > 1)
		BEGIN
		RAISERROR('Estas loco? No podes borrar mas de 1 orden', 16, 1);
		END
	ELSE
		BEGIN
			
			SELECT @order_num = order_num FROM deleted

			DELETE FROM items WHERE order_num = @order_num
			DELETE FROM orders WHERE order_num = @order_num
		END
END

SELECT * FROM orders;
DELETE FROM orders;
SELECT * FROM items;


--5. Crear un trigger de insert sobre la tabla ítems que al detectar que el código de fabricante
--(manu_code) del producto a comprar no existe en la tabla manufact,
-- inserte una fila en dicha tabla con el manu_code ingresado, en el campo manu_name la descripción ‘Manu Orden 999’
--donde 999 corresponde al nro. de la orden de compra a la que pertenece el ítem y en el campo
--lead_time el valor 1.

DROP TRIGGER insertar_items;
CREATE TRIGGER insertar_items 
ON items
INSTEAD OF INSERT AS
BEGIN
	DECLARE @manu_code VARCHAR(3)
	DECLARE @manu_name VARCHAR(50)
	DECLARE @lead_time INT
	DECLARE @order_num INT

	DECLARE Cursor_items_insertados CURSOR FOR
	SELECT manu_code,order_num FROM inserted

	OPEN Cursor_items_insertados

	FETCH NEXT FROM Cursor_items_insertados
	INTO @manu_code,@order_num

	WHILE(@@FETCH_STATUS = 0)
	BEGIN

		IF(	NOT EXISTS (SELECT * FROM manufact WHERE manu_code = @manu_code ) )
			BEGIN
			SELECT @manu_name = 'Manu Orden ' +  CAST(@order_num AS CHAR(10)) 
			SELECT @lead_time = 1

			INSERT INTO manufact(manu_code, manu_name,lead_time)
			VALUES (@manu_code,@manu_name,@lead_time)

			FETCH NEXT FROM Cursor_items_insertados
			INTO @manu_code,@order_num
			END
	END

	CLOSE Cursor_items_insertados
	DEALLOCATE Cursor_items_insertados
	
	INSERT INTO items (item_num, order_num, stock_num, manu_code, quantity, unit_price)
	SELECT item_num, order_num, stock_num, manu_code, quantity, unit_price FROM inserted 
	
END


--6. Crear tres triggers (Insert, Update y Delete) sobre la tabla Products para replicar todas las
--operaciones en la tabla Products _replica, la misma deberá tener la misma estructura de la tabla
--Products.

DROP TABLE products_replica;
CREATE TABLE products_replica(
	stock_num INT,
	manu_code CHAR(3),
	unit_price DECIMAL(6,2),
	unit_code INT
	PRIMARY KEY(stock_num,manu_code)
);

DROP TABLE products2;
CREATE TABLE products2(
	stock_num INT,
	manu_code CHAR(3),
	unit_price DECIMAL(6,2),
	unit_code INT
	PRIMARY KEY(stock_num,manu_code)
);

DROP TRIGGER insert_products;
CREATE TRIGGER insert_products
ON products2
AFTER INSERT AS
BEGIN
	
	DECLARE @STOCK_NUM INT
	DECLARE @MANU_CODE CHAR(3)
	DECLARE @UNIT_PRICE DECIMAL(6,2)
	DECLARE @UNIT_CODE INT


	DECLARE CursorInsetarProductos CURSOR FOR
	SELECT stock_num,manu_code,unit_price,unit_code 
	FROM inserted

	OPEN CursorInsetarProductos

	FETCH NEXT FROM CursorInsetarProductos
	INTO @STOCK_NUM,@MANU_CODE,@UNIT_PRICE,@UNIT_CODE

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO products_replica VALUES(@STOCK_NUM,@MANU_CODE,@UNIT_PRICE,@UNIT_CODE)
		FETCH NEXT FROM CursorInsetarProductos
		INTO @STOCK_NUM,@MANU_CODE,@UNIT_PRICE,@UNIT_CODE
	END

	CLOSE CursorInsetarProductos
	DEALLOCATE CursorInsetarProductos

END


SELECT * FROM products2;
INSERT INTO products2 (stock_num, manu_code, unit_price, unit_code)
VALUES
    (22, 'SOL', 500,1),
    (28, 'MAR', 100,2);

SELECT * FROM Products_replica;

DROP TRIGGER update_products;
CREATE TRIGGER update_products
ON products2
AFTER UPDATE AS
BEGIN
	
	DECLARE @STOCK_NUM INT
	DECLARE @MANU_CODE CHAR(3)
	DECLARE @UNIT_PRICE DECIMAL(6,2)
	DECLARE @UNIT_CODE INT

	DECLARE CursorActualizarProductos CURSOR FOR
	SELECT I.stock_num,I.manu_code,I.unit_price,I.unit_code
	FROM inserted I

	OPEN CursorActualizarProductos

	FETCH NEXT FROM CursorActualizarProductos
	INTO @STOCK_NUM,@MANU_CODE,@UNIT_PRICE,@UNIT_CODE

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		UPDATE Products_replica 
		SET stock_num = @STOCK_NUM, manu_code = @MANU_CODE, unit_price = @UNIT_PRICE, unit_code = @UNIT_CODE
		WHERE stock_num = @STOCK_NUM AND manu_code = @MANU_CODE

		FETCH NEXT FROM CursorActualizarProductos
		INTO @STOCK_NUM,@MANU_CODE,@UNIT_PRICE,@UNIT_CODE
	END

	CLOSE CursorActualizarProductos
	DEALLOCATE CursorActualizarProductos

END

SELECT * FROM products2;
UPDATE products2 SET unit_price = 500;
SELECT * FROM Products_replica;


DROP TRIGGER delete_products;
CREATE TRIGGER delete_products
ON products2
AFTER DELETE AS
BEGIN
	
	DECLARE @STOCK_NUM INT
	DECLARE @MANU_CODE CHAR(3)

	DECLARE CursorEliminarProductos CURSOR FOR
	SELECT stock_num,manu_code
	FROM deleted

	OPEN CursorEliminarProductos

	FETCH NEXT FROM CursorEliminarProductos
	INTO @STOCK_NUM,@MANU_CODE

	WHILE(@@FETCH_STATUS = 0)
	BEGIN

		DELETE FROM Products_replica WHERE stock_num = @STOCK_NUM AND manu_code = @MANU_CODE

		FETCH NEXT FROM CursorEliminarProductos
		INTO @STOCK_NUM,@MANU_CODE
	END

	CLOSE CursorEliminarProductos
	DEALLOCATE CursorEliminarProductos

END

SELECT * FROM products2;
DELETE FROM products2 WHERE unit_code = 1;
SELECT * FROM Products_replica;




--7. Crear la vista Productos_x_fabricante que tenga los siguientes atributos:
--Stock_num, description, manu_code, manu_name, unit_price
DROP VIEW Productos_x_fabricante ;
CREATE VIEW Productos_x_fabricante 
AS
SELECT
P.stock_num,
T.description,
P.manu_code,
M.manu_name,
P.unit_price
FROM products P
JOIN product_types T ON T.stock_num = P.stock_num
JOIN manufact M ON M.manu_code = P.manu_code

SELECT * FROM Productos_x_fabricante;

--Crear un trigger de Insert sobre la vista anterior que ante un insert, inserte una fila en la tabla
--Products, pero si el manu_code no existe en la tabla manufact, inserte además una fila en dicha
--tabla con el campo lead_time en 1.

DROP TRIGGER insert_view_producto_x_fab;
CREATE TRIGGER insert_view_producto_x_fab
ON Productos_x_fabricante
INSTEAD OF INSERT AS
BEGIN
	DECLARE @STOCK_NUM INT
	DECLARE @DESCRIPTON VARCHAR(15)
	DECLARE @MANU_CODE VARCHAR(3)
	DECLARE @MANU_NAME VARCHAR(15)
	DECLARE @UNIT_PRICE DECIMAL(6,2)

	DECLARE Cursor_insert_vista CURSOR FOR
	SELECT stock_num, description, manu_code,manu_name, unit_price
	FROM inserted

	OPEN Cursor_insert_vista

	FETCH NEXT FROM Cursor_insert_vista
	INTO @STOCK_NUM,@DESCRIPTON,@MANU_CODE,@MANU_NAME,@UNIT_PRICE

	WHILE(@@FETCH_STATUS = 0)
	BEGIN

		IF(NOT EXISTS (SELECT * FROM manufact WHERE manu_code = @MANU_CODE) )
			BEGIN
			INSERT INTO manufact (manu_code,manu_name,lead_time)
			VALUES (@MANU_CODE, @MANU_NAME, 1)
			END
		
		INSERT INTO products (stock_num,manu_code,unit_price)
		VALUES (@STOCK_NUM,@MANU_CODE, @UNIT_PRICE)

		FETCH NEXT FROM Cursor_insert_vista
		INTO @STOCK_NUM,@DESCRIPTON,@MANU_CODE,@MANU_NAME,@UNIT_PRICE
	END

	CLOSE Cursor_insert_vista
	DEALLOCATE Cursor_insert_vista

END


----------------------------------------------------------------------------------------------

-- PRÁCTICA 2: TRIGGERS


--1. Se pide: Crear un trigger que valide que ante un insert de una o más filas en la tabla
--ítems, realice la siguiente validación:
-- Si la orden de compra a la que pertenecen los ítems ingresados corresponde a
--clientes del estado de California, se deberá validar que estas órdenes puedan tener
--como máximo 5 registros en la tabla ítem.
-- Si se insertan más ítems de los definidos, el resto de los ítems se deberán insertar
--en la tabla items_error la cual contiene la misma estructura que la tabla ítems más
--un atributo fecha que deberá contener la fecha del día en que se trató de insertar.
--Ej. Si la Orden de Compra tiene 3 items y se realiza un insert masivo de 3 ítems más, el
--trigger deberá insertar los 2 primeros en la tabla ítems y el restante en la tabla ítems_error.
--Supuesto: En el caso de un insert masivo los items son de la misma orden.






--2. Triggers Dada la siguiente vista
--CREATE VIEW ProdPorFabricante AS
--SELECT m.manu_code, m.manu_name, COUNT(*)
--FROM manufact m INNER JOIN products p
--ON (m.manu_code = p.manu_code)
--GROUP BY manu_code, manu_name;
--Crear un trigger que permita ante un insert en la vista ProdPorFabricante insertar una fila
--en la tabla manufact.
--Observaciones: el atributo leadtime deberá insertarse con un valor default 10
--El trigger deberá contemplar inserts de varias filas, por ej. ante un
--INSERT / SELECT.





--3. Crear un trigger que ante un INSERT o UPDATE de una o más filas de la tabla Customer, realice
--la siguiente validación.
-- La cuota de clientes correspondientes al estado de California es de 20, si se supera dicha
--cuota se deberán grabar el resto de los clientes en la tabla customer_pend.
-- Validar que si de los clientes a modificar se modifica el Estado, no se puede superar dicha
--cuota.
--Si por ejemplo el estado de CA cuenta con 18 clientes y se realiza un update o insert masivo de 5
--clientes con estado de CA, el trigger deberá modificar los 2 primeros en la tabla customer y los
--restantes grabarlos en la tabla customer_pend.
--La tabla customer_pend tendrá la misma estructura que la tabla customer con un atributo adicional
--fechaHora que deberá actualizarse con la fecha y hora del día.






--4. Dada la siguiente vista
--CREATE VIEW ProdPorFabricanteDet AS
--SELECT m.manu_code, m.manu_name, pt.stock_num, pt.description
--FROM manufact m LEFT OUTER JOIN products p ON m.manu_code = p.manu_code
--LEFT OUTER JOIN product_types pt ON p.stock_num = pt.stock_num;
--Se pide: Crear un trigger que permita ante un DELETE en la vista ProdPorFabricante
--borrar los datos en la tabla manufact pero sólo de los fabricantes cuyo campo description
--sea NULO (o sea que no tienen stock).
--Observaciones: El trigger deberá contemplar borrado de varias filas mediante un DELETE
--masivo. En ese caso sólo borrará de la tabla los fabricantes que no tengan productos en
--stock, borrando los demás.






--5. Se pide crear un trigger que permita ante un delete de una sola fila en la vista
--ordenesPendientes valide:
--o Si el cliente asociado a la orden tiene sólo esa orden pendiente de pago (paid_date IS
--NULL), no permita realizar la Baja, informando el error.
--o Si la Orden tiene más de un ítem asociado, no permitir realizar la Baja, informando el
--error.
--o Ante cualquier otra condición borrar la Orden con sus ítems asociados, respetando la
--integridad referencial.
--Estructura de la vista: customer_num, fname, lname, Company, order_num, order_date
--WHERE paid_date IS NULL.