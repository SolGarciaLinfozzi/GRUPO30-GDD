--CLASE 7

--FUNCIONES


--1. Escribir una sentencia SELECT que devuelva el 
--número de orden, fecha de orden y el nombre del día de la semana de la orden de todas las órdenes que no han sido pagadas.
--Si el cliente pertenece al estado de California el día de la semana debe devolverse en inglés, caso
--contrario en español. Cree una función para resolver este tema.

--Nota: SET @DIA = datepart(weekday,@fecha)
--Devuelve en la variable @DIA el nro. de día de la semana , comenzando con 1 Domingo hasta 7 Sábado.


SELECT order_num, order_date,
CASE
	WHEN state = 'CA' THEN dbo.dia_semana2(order_date,'ingles') 
	WHEN state != 'CA' OR state IS NULL THEN dbo.dia_semana2(order_date,'espaniol')
END
AS DiaSemana
FROM orders o, customer c
WHERE o.customer_num = c.customer_num
AND paid_date IS NULL


CREATE FUNCTION dbo.DIA_SEMANA2 (@FECHA DATETIME, @IDIOMA VARCHAR (20))
RETURNS VARCHAR (20)
AS BEGIN
DECLARE @DIA INT
DECLARE @RETORNO VARCHAR(20)
SET @DIA = datepart(weekday,@fecha)

IF @IDIOMA = 'espaniol'
	BEGIN
	SET @RETORNO = CASE 
					when @dia = 1 then 'Domingo'
					when @dia = 2 then 'lunes' 
					when @dia = 3 then 'Martes' 
					when @dia = 4 then'Miercoles' 
					when @dia = 5 then 'Jueves'
					when @dia = 6 then 'Viernes'
					else 'Sábado'
				END 
	END
ELSE
	BEGIN
	SET @RETORNO = CASE 
					when @dia = 1 then 'Sunday'
					when @dia = 2 then 'Monday'
					when @dia = 3 then 'Tuesday' 
					when @dia = 4 then 'Wednesday'
					when @dia = 5 then 'Thursday'
					when @dia = 6 then 'Friday'
					else 'Saturday' 
				END

	END

RETURN @RETORNO
END


---------------------------------------------------------------------------------

SELECT O.order_num, O.order_date, dbo.DIA_SEMANA(O.order_date,C.state) diaSemana
FROM orders O 
JOIN customer C ON O.customer_num = C.customer_num
WHERE O.paid_date IS NULL;

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'DIA_SEMANA')
	DROP FUNCTION DIA_SEMANA;

CREATE FUNCTION dbo.DIA_SEMANA(@fecha DATETIME2(3), @state NVARCHAR(50)) RETURNS NVARCHAR(15)
AS
BEGIN
    DECLARE @DIA NVARCHAR(15)
	DECLARE @COD_DIA INT
    SET @COD_DIA = DATEPART(weekday,@fecha)

    IF @COD_DIA = 1 
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Sunday'
		ELSE
			SET @DIA = 'Domingo'
	END
	IF @COD_DIA = 2
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Monday'
		ELSE
			SET @DIA = 'Lunes'
	END
    IF @COD_DIA = 3
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Tuesday'
		ELSE
			SET @DIA = 'Martes'
	END
	IF @COD_DIA = 4
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Wednesday'
		ELSE
			SET @DIA = 'Miercoles'
	END
	IF @COD_DIA = 5
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Thursday'
		ELSE
			SET @DIA = 'Jueves'
	END
	IF @COD_DIA = 6
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Friday'
		ELSE
			SET @DIA = 'Viernes'
	END
	IF @COD_DIA = 7
	BEGIN
		IF  @state = 'CA'
			SET @DIA = 'Saturday'
		ELSE
			SET @DIA = 'Sabado'
	END
    RETURN @DIA
END


2. Escribir una sentencia SELECT para los clientes que han tenido órdenes en al menos 2 meses
diferentes, los dos meses con las órdenes con el mayor ship_charge.
Se debe devolver una fila por cada cliente que cumpla esa condición, el formato es:
Cliente Año y mes mayor carga Segundo año mayor carga
NNNN YYYY - Total: NNNN.NN YYYY - Total: NNNN.NN
La primera columna es el id de cliente y las siguientes 2 se refieren a los campos ship_date y ship_charge.
Se requiere crear una función que devuelva la información de 1er o 2do año mes con la orden con mayor Carga
(ship_charge).


--3. Escribir un Select que devuelva para cada producto de la tabla Products que exista en la tabla
--Catalog todos sus fabricantes separados entre sí por el caracter pipe (|). Utilizar una función para
--resolver parte de la consulta. Ejemplo de la salida
--Stock_num Fabricantes
--5 NRG | SMT | ANZ

SELECT DISTINCT stock_num, dbo.fx_fabricantes(stock_num) as Fabricantes
FROM products P
WHERE EXISTS (SELECT stock_num FROM catalog C WHERE C.stock_num = P.stock_num);

CREATE FUNCTION Fx_FABRICANTES (@CODIGO INT) RETURNS VARCHAR (100) 
AS
BEGIN
	DECLARE @RETORNO VARCHAR(100)
	DECLARE @FABRICANTE VARCHAR(3)

	DECLARE CUR_FABRICANTES CURSOR FOR 
	SELECT manu_code  
	FROM catalog
	WHERE stock_num = @CODIGO; -- Se utiliza para recorrer los registros de la tabla catalog que coinciden con el @CODIGO 

	SET @RETORNO = ''
	OPEN CUR_FABRICANTES -- Se abre el cursor CUR_FABRICANTES para comenzar a recorrer los registros

	FETCH NEXT FROM CUR_FABRICANTES INTO @FABRICANTE 
	--Dentro de un bucle WHILE, se utiliza la cláusula FETCH NEXT para obtener el siguiente valor de @FABRICANTE desde el cursor.
	WHILE (@@FETCH_STATUS = 0) -- Asegurarse de que se haya obtenido un valor válido.
	
	BEGIN
	SET @RETORNO = @RETORNO + @FABRICANTE + ' | '
	
	FETCH NEXT FROM CUR_FABRICANTES INTO @FABRICANTE -- Obtener el siguiente valor del cursor y continuar con el bucle mientras haya más registros
	END

	CLOSE CUR_FABRICANTES -- Cierra el cursor 
	DEALLOCATE CUR_FABRICANTES -- Libera la memoria asociada con él

    SET @RETORNO = SUBSTRING(@RETORNO, 1, LEN(@RETORNO) - 2)  -- Elimina los últimos 2 caracteres de la cadena @RETORNO, que corresponden al último carácter '|' y al espacio adicional
	RETURN @RETORNO
END

--------------------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES


--1
--Crear la siguiente tabla CustomerStatistics con los siguientes campos
--customer_num (entero y pk), ordersqty (entero), maxdate (date), uniqueProducts
--(entero)
--Crear un procedimiento ‘actualizaEstadisticas’ que reciba dos parámetros
--customer_numDES y customer_numHAS y que 
--en base a los datos de la tabla customer cuyo customer_num estén en en rango pasado por parámetro, 
--inserte (si no existe) o modifique el registro de la tabla CustomerStatistics con la siguiente
--información:

--Ordersqty contedrá la cantidad de órdenes para cada cliente.
--Maxdate contedrá la fecha máxima de la última órden puesta por cada cliente.
--uniqueProducts contendrá la cantidad única de tipos de productos adquiridos
--por cada cliente.


--MI ALTERNATIVA
DROP TABLE CustomerStatistics;
CREATE TABLE CustomerStatistics(
	customer_num INT PRIMARY KEY,
	ordersqty INT,
	maxdate DATETIME,
	n uniqueProducts INT
);


DROP PROCEDURE actualizaEstadisticas;
CREATE PROCEDURE actualizaEstadisticas
@customer_numDES INT , @customer_numHAS INT  --PARAMETROS QUE RECIBE
AS
BEGIN
	DECLARE CustomerCursor CURSOR FOR --Declaro el cursor para recorrer todos los registros que esten dentro del rango
	SELECT customer_num 
	FROM customer 
	WHERE customer_num BETWEEN @customer_numDES AND @customer_numHAS 

	DECLARE @CUSTOMER_NUM INT
	DECLARE @ORDERSQTY INT
	DECLARE @MAXDATE DATETIME
	DECLARE @UNIQUEMANUFACT INT

	OPEN CustomerCursor
	FETCH NEXT FROM CustomerCursor INTO @CUSTOMER_NUM 
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF EXISTS (SELECT customer_num FROM CustomerStatistics C WHERE C.customer_num = @CUSTOMER_NUM)
		BEGIN 
			UPDATE CustomerStatistics
			SET 
			 
			customer_num = @CUSTOMER_NUM,
			ordersqty = (
			SELECT  COUNT(O.order_num)
			FROM customer C
			JOIN ORDERS O ON O.customer_num = C.customer_num
			WHERE C.customer_num = @CUSTOMER_NUM ),

			maxdate = (
			SELECT MAX(O.order_date)
			FROM customer C
			JOIN ORDERS O ON O.customer_num = C.customer_num
			WHERE C.customer_num = @CUSTOMER_NUM ),

			uniqueProducts = (
			SELECT COUNT(DISTINCT I.stock_num)
			FROM customer C
			JOIN ORDERS O ON O.customer_num = C.customer_num
			JOIN ITEMS I ON I.order_num = O.order_num
			WHERE C.customer_num = @CUSTOMER_NUM )
			
		END

		ELSE
		BEGIN 
			INSERT INTO CustomerStatistics (customer_num,ordersqty,maxdate,uniqueProducts) 
			SELECT 
			@CUSTOMER_NUM,
			COUNT(O.order_num), 
			MAX(O.order_date),
			COUNT(DISTINCT I.stock_num)
			FROM customer C
			JOIN ORDERS O ON O.customer_num = C.customer_num
			JOIN ITEMS I ON I.order_num = O.order_num
			WHERE C.customer_num = @CUSTOMER_NUM 
		END

	FETCH NEXT FROM CustomerCursor INTO @CUSTOMER_NUM -- Obtener el siguiente valor del cursor y continuar con el bucle mientras haya más registros
	END
	CLOSE CustomerCursor -- Cierra el cursor 
	DEALLOCATE CustomerCursor -- Libera la memoria asociada con él
END

EXECUTE dbo.actualizaEstadisticas @customer_numDES = 100, @customer_numHAS = 1000;
SELECT * FROM customerStatistics;

-- ALTERNATIVA DE LA GUÍA
DROP TABLE CustomerStatistics2;
CREATE TABLE CustomerStatistics2(
	customer_num INT PRIMARY KEY,
	ordersqty INT,
	maxdate DATETIME,
	uniqueManufact INT
);

DROP PROCEDURE actualizaEstadisticas2;
CREATE PROCEDURE actualizaEstadisticas2
@customer_numDES INT , @customer_numHAS INT
AS
BEGIN
	DECLARE CustomerCursor CURSOR FOR
	SELECT customer_num from customer WHERE customer_num
	BETWEEN @customer_numDES AND @customer_numHAS
	DECLARE @customer_num INT, @ordersqty INT, @maxdate DATETIME, @uniqueManufact INT;
	OPEN CustomerCursor;
	FETCH NEXT FROM CustomerCursor INTO @customer_num

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT
		@ordersqty=count(*), 
		@maxDate=max(order_date)
		FROM orders
		WHERE customer_num = @customer_num;

		SELECT @uniqueManufact=count(distinct stock_num)
		FROM items i, orders o
		WHERE o.customer_num = @customer_num
		AND o.order_num = i.order_num;
		
		IF NOT EXISTS( SELECT 1 FROM CustomerStatistics2
			WHERE customer_num = @customer_num)
			insert into CustomerStatistics2
			values (@customer_num,@ordersQty, @maxDate,@uniqueManufact);
		ELSE
			update CustomerStatistics2
			SET ordersQty=@ordersQty,maxDate=@maxDate,
			uniqueManufact= @uniqueManufact
			WHERE customer_num = @customer_num;

		FETCH NEXT FROM CustomerCursor INTO @customer_num
	END;
	CLOSE CustomerCursor;
	DEALLOCATE CustomerCursor;
END

EXECUTE dbo.actualizaEstadisticas2 @customer_numDES = 100, @customer_numHAS = 1000;
SELECT * FROM customerStatistics2;


--2
--Crear un procedimiento ‘migraClientes’ que reciba dos parámetros
--customer_numDES y customer_numHAS y que dependiendo el tipo de cliente y la
--cantidad de órdenes los inserte en las tablas clientesCalifornia, clientesNoCaBaja,
--clienteNoCAAlta.

--• El procedimiento deberá migrar de la tabla customer todos los
--clientes de California a la tabla clientesCalifornia, los clientes que no
--son de California pero tienen más de 999u$ en OC en
--clientesNoCaAlta y los clientes que tiene menos de 1000u$ en OC en
--la tablas clientesNoCaBaja.

--• Se deberá actualizar un campo status en la tabla customer con valor
--‘P’ Procesado, para todos aquellos clientes migrados.

--• El procedimiento deberá contemplar toda la migración como un lote,
--en el caso que ocurra un error, se deberá informar el error ocurrido y
--abortar y deshacer la operación.
-- DEBO USAR TRANSACCIONES EN EL PROCEDURE

DROP TABLE dbo.clientesCalifornia;
CREATE TABLE clientesCalifornia(
	customer_num INT NOT NULL,
	fname VARCHAR(15),
	lname VARCHAR(15),
	company VARCHAR(20),
	address1 VARCHAR(20),
	address2 VARCHAR(20),
	city VARCHAR(15),
	state VARCHAR(2),
	zipcode VARCHAR(5),
	phone VARCHAR(18)
);

DROP TABLE dbo.clientesNoCaAlta;
CREATE TABLE clientesNoCaAlta(
	customer_num INT NOT NULL,
	fname VARCHAR(15),
	lname VARCHAR(15),
	company VARCHAR(20),
	address1 VARCHAR(20),
	address2 VARCHAR(20),
	city VARCHAR(15),
	state VARCHAR(2),
	zipcode VARCHAR(5),
	phone VARCHAR(18)
);

DROP TABLE dbo.clientesNoCaBaja;
CREATE TABLE clientesNoCaBaja(
	customer_num INT NOT NULL,
	fname VARCHAR(15),
	lname VARCHAR(15),
	company VARCHAR(20),
	address1 VARCHAR(20),
	address2 VARCHAR(20),
	city VARCHAR(15),
	state VARCHAR(2),
	zipcode VARCHAR(5),
	phone VARCHAR(18)
);


DROP PROCEDURE dbo.migraClientes;
CREATE PROCEDURE migraClientes
@customer_numDES INT, @customer_numHAS INT --PARÁMETROS
AS
BEGIN
	BEGIN TRY  -- TRANSACCIÓN

	DECLARE @CUSTOMER_NUM INT
	DECLARE @FNAME VARCHAR(15)
	DECLARE @LNAME VARCHAR(15)
	DECLARE @COMPANY VARCHAR(20)
	DECLARE @ADDRESS1 VARCHAR(20)
	DECLARE @ADDRESS2 VARCHAR(20)
	DECLARE @CITY VARCHAR(15)
	DECLARE @STATE VARCHAR(2)
	DECLARE @ZIPCODE VARCHAR(5)
	DECLARE @PHONE VARCHAR(18)
	DECLARE @TOTALOC INT

	DECLARE CursorCliente CURSOR FOR
	SELECT customer_num FROM dbo.customer 
	WHERE customer_num BETWEEN @customer_numDES AND @customer_numHAS
	
	OPEN CursorCliente

	FETCH NEXT FROM CursorCliente INTO @CUSTOMER_NUM
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SELECT
		@FNAME=fname, 
		@LNAME=lname, 
		@COMPANY = company,
		@ADDRESS1 = address1,
		@ADDRESS2 = address2,
		@CITY = city,
		@STATE = state,
		@ZIPCODE = zipcode,
		@PHONE = phone
		FROM dbo.customer
		WHERE customer_num = @CUSTOMER_NUM;

		SELECT @TOTALOC =  SUM(quantity * unit_price) FROM dbo.items I
		JOIN dbo.orders O ON O.order_num = I.order_num 
		WHERE O.customer_num = @CUSTOMER_NUM;


		IF( @STATE = 'CA' )
			BEGIN
				INSERT INTO dbo.clientesCalifornia (customer_num,fname,lname,company,address1,address2,city,state,zipcode,phone) 
				VALUES(@CUSTOMER_NUM,@FNAME,@LNAME,@COMPANY,@ADDRESS1,@ADDRESS2,@CITY,@STATE,@ZIPCODE,@PHONE)
				
				UPDATE dbo.customer
				SET status = 'P'
				WHERE customer_num = @CUSTOMER_NUM
			END
		ELSE IF (@TOTALOC > 999)
			BEGIN
				INSERT INTO dbo.clientesNoCaAlta (customer_num,fname,lname,company,address1,address2,city,state,zipcode,phone) 
				VALUES(@CUSTOMER_NUM,@FNAME,@LNAME,@COMPANY,@ADDRESS1,@ADDRESS2,@CITY,@STATE,@ZIPCODE,@PHONE)
				
				UPDATE dbo.customer
				SET status = 'P'
				WHERE customer_num = @CUSTOMER_NUM
			END

		ELSE IF (@TOTALOC < 1000 OR @TOTALOC IS NULL)
			BEGIN
				INSERT INTO dbo.clientesNoCaBaja (customer_num,fname,lname,company,address1,address2,city,state,zipcode,phone) 
				VALUES(@CUSTOMER_NUM,@FNAME,@LNAME,@COMPANY,@ADDRESS1,@ADDRESS2,@CITY,@STATE,@ZIPCODE,@PHONE)
				
				UPDATE dbo.customer
				SET status = 'P'
				WHERE customer_num = @CUSTOMER_NUM
			END
		FETCH NEXT FROM CursorCliente INTO @CUSTOMER_NUM
	END

	CLOSE CursorCliente -- Cierra el cursor 
	DEALLOCATE CursorCliente -- Libera la memoria asociada con él

	END TRY -- TRANSACCIÓN
	--En caso de que se produzca una excepción o error durante la ejecución del código en el bloque TRY, la ejecución del código se transferirá al bloque CATCH.
	BEGIN CATCH 
		CLOSE CustomerCursor
		DEALLOCATE CustomerCursor
		ROLLBACK TRANSACTION
		DECLARE @errorDescripcion VARCHAR(100)
		SELECT @errorDescripcion = 'Error en Cliente ' + CAST(@customer_num AS CHAR(5)) 
		RAISERROR(@errorDescripcion, 16, 1)
		--El segundo argumento de RAISERROR representa el nivel de gravedad del error y el tercer argumento es el estado del error.
	END CATCH
END

EXECUTE dbo.migraClientes @customer_numDES = 100, @customer_numHAS = 1000;
SELECT * FROM dbo.clientesCalifornia;
SELECT * FROM dbo.clientesNoCaAlta;
SELECT * FROM dbo.clientesNoCaBaja;
SELECT * FROM dbo.customer WHERE customer_num BETWEEN 100 AND 1000;


--3

Crear un procedimiento ‘actualizaPrecios’ que reciba como parámetros manu_codeDES, manu_codeHAS y porcActualizacion 
que dependiendo del tipo de cliente y la cantidad de órdenes 
genere las siguientes tablas listaPrecioMayor y listaPreciosMenor. Ambas tienen las misma estructura que la tabla Productos.

• El procedimiento deberá tomar de la tabla Productos todos los productos que
correspondan al rango de fabricantes asignados por parámetro.
Por cada producto del fabricante se evaluará la cantidad (quantity) comprada.

Si la misma es mayor o igual a 500 se grabará el producto en la tabla listaPrecioMayor y el unit_price deberá ser actualizado con (unit_price * (porcActualización *0,80)),
Si la cantidad comprada del producto es menor a 500 se actualizará (o insertará) en la tabla listaPrecioMenor y el unit_price se actualizará con (unit_price * porcActualizacion)
• Asimismo, se deberá actualizar un campo status de la tabla stock con valor ‘A’ Actualizado, para todos aquellos productos con cambio de precio actualizado.
• El procedimiento deberá contemplar todas las operaciones de cada fabricante como un lote, en el caso que ocurra un error, se deberá informar el error ocurrido
y deshacer la operación de ese fabricante.


DROP TABLE dbo.listaPrecioMayor;
CREATE TABLE  listaPrecioMayor(
	stock_num INT NOT NULL,
	manu_code CHAR(3) NOT NULL,
	unit_price DECIMAL(6,2),
	unit_code INT
);

DROP TABLE dbo.listaPrecioMenor;
CREATE TABLE  listaPrecioMenor(
	stock_num INT NOT NULL,
	manu_code CHAR(3) NOT NULL,
	unit_price DECIMAL(6,2),
	unit_code INT
);

DROP PROCEDURE dbo.actualizaPrecios;
CREATE PROCEDURE actualizaPrecios
@manu_codeDES CHAR(3), @manu_codeHAS CHAR(3), @porcActualizacion INT
AS
BEGIN
	BEGIN TRY
	DECLARE @MANU_CODE CHAR(3)
	DECLARE @STOCK_NUM INT
	DECLARE @UNIT_PRICE INT
	DECLARE @UNIT_CODE INT
	DECLARE @CANTIDADCOMPRADAPRODUCTO INT 
	DECLARE CursorFabricante CURSOR FOR
	SELECT  manu_code FROM dbo.manufact
	WHERE manu_code BETWEEN @manu_codeDES AND @manu_codeHAS

	OPEN CursorFabricante

	FETCH NEXT FROM CursorFabricante INTO @MANU_CODE
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		DECLARE CursorProducto CURSOR FOR  --Declaro cursor para recorrer los productos del fabricante
		SELECT  stock_num FROM dbo.products
		WHERE manu_code = @MANU_CODE

		OPEN CursorProducto
		FETCH NEXT FROM CursorProducto INTO @STOCK_NUM
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SELECT @CANTIDADCOMPRADAPRODUCTO = SUM(quantity) FROM items I
			WHERE manu_code = @MANU_CODE AND stock_num = @STOCK_NUM

			SELECT @UNIT_PRICE = unit_price, @UNIT_CODE = unit_code FROM products
			WHERE manu_code = @MANU_CODE AND stock_num = @STOCK_NUM

			IF(@CANTIDADCOMPRADAPRODUCTO >= 500)
				BEGIN
					INSERT INTO listaPrecioMayor (stock_num, manu_code, unit_price, unit_code) 
					VALUES (@STOCK_NUM, @MANU_CODE, @UNIT_PRICE * (@porcActualizacion * 0.80), @UNIT_CODE)

					UPDATE dbo.products
					SET status = 'A'
					WHERE manu_code = @MANU_CODE AND stock_num = @STOCK_NUM
				END

			ELSE IF(@CANTIDADCOMPRADAPRODUCTO < 500 OR @CANTIDADCOMPRADAPRODUCTO IS NULL)

				BEGIN
					INSERT INTO listaPrecioMenor (stock_num, manu_code, unit_price, unit_code) 
					VALUES (@STOCK_NUM, @MANU_CODE, @UNIT_PRICE * @porcActualizacion, @UNIT_CODE)

					UPDATE dbo.products
					SET status = 'A'
					WHERE manu_code = @MANU_CODE AND stock_num = @STOCK_NUM
				END


			FETCH NEXT FROM CursorProducto INTO @STOCK_NUM
		END

		CLOSE CursorProducto 
		DEALLOCATE CursorProducto 
		
		FETCH NEXT FROM CursorFabricante INTO @MANU_CODE
	END

	CLOSE CursorFabricante -- Cierra el cursor 
	DEALLOCATE CursorFabricante -- Libera la memoria asociada con él
	END TRY
	BEGIN CATCH
		CLOSE CursorFabricante
		DEALLOCATE CursorFabricante 
		ROLLBACK TRANSACTION
		DECLARE @ERRORDESCRIPCION VARCHAR(100)
		SELECT @ERRORDESCRIPCION = 'ERROR en fabricante: ' +  CAST(@MANU_CODE AS CHAR(5)) 
		RAISERROR(@ERRORDESCRIPCION, 16, 1)
	END CATCH

END

EXECUTE dbo.actualizaPrecios @manu_codeDES = 'AAA' , @manu_codeHAS = 'III', @porcActualizacion = 1;
SELECT * FROM dbo.listaPrecioMayor;
SELECT * FROM dbo.listaPrecioMenor;


SELECT * FROM manufact;
SELECT * FROM products WHERE manu_code IN ('ANZ','HRO', 'HSK', 'HHH') ORDER BY manu_code
SELECT * FROM products WHERE manu_code IN ('HRO') ORDER BY manu_code


