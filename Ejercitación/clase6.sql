-- CLASE 6 EJERCITACIÓN

USE Comercial;

--------------------------------------------------------------------------------------------------------------------------------
--JOINS (Group by, having, Subqueries, subq. correlacionados, outer joins, Temp tables)


--1. Mostrar el Código del fabricante, nombre del fabricante, tiempo de entrega y monto
--Total de productos vendidos, ordenado por nombre de fabricante. En caso que el
--fabricante no tenga ventas, mostrar el to  tal en NULO.

SELECT M.manu_code, manu_name, lead_time, SUM(quantity * unit_price) montoTotal
FROM items I
RIGHT JOIN manufact M on I.manu_code = M.manu_code  --Tabla dominandote = manufact
GROUP BY M.manu_code, manu_name, lead_time
ORDER BY manu_name
-- USO EL RIGHT PORQUE HAY QUE MOSTRAR LOS FABRICANTES QUE NO TENGAN VENTAS TAMBIÉN
-- El Outer join, mostrara todas las filas de la tabla dominante macheen o no con la otra tabla.

SELECT M.manu_code, manu_name, lead_time, SUM(unit_price * quantity) montoTotal
FROM manufact M
LEFT JOIN items I ON I.manu_code = M.manu_code	--Tabla dominandote = manufact
GROUP BY M.manu_code, manu_name, lead_time
ORDER BY manu_name


--2. Mostrar en una lista de a pares, el código y descripción del producto, y los pares de
--fabricantes que fabriquen el mismo producto. En el caso que haya un único fabricante
--deberá mostrar el Código de fabricante 2 en nulo. Ordenar el resultado por código de
--producto.

SELECT P.stock_num 'Nro. de producto', description 'Descripción', P.manu_code 'Fabricante 1', P2.manu_code 'Fabricante 2'
FROM products P
LEFT JOIN products P2 ON (P.stock_num = P2.stock_num AND P.manu_code != P2.manu_code)
JOIN product_types T ON P.stock_num = T.stock_num
WHERE P.manu_code < P2.manu_code or P2.manu_code is NULL


--3. Listar todos los clientes que hayan tenido más de una orden.
--a) En primer lugar, escribir una consulta usando una subconsulta.
--b) Reescribir la consulta utilizando GROUP BY y HAVING.
--La consulta deberá tener el siguiente formato:
--Número_de_Cliente Nombre Apellido
--(customer_num) (fname) (lname)

--a1) 
SELECT DISTINCT customer_num, fname, lname
FROM customer 
WHERE customer_num IN 
	(SELECT customer_num 
	FROM orders 
	GROUP BY customer_num 
	HAVING COUNT(*) > 1 )

--a2) 
SELECT customer_num, fname, lname
FROM customer c
WHERE EXISTS 
	(SELECT customer_num 
	 FROM orders o
	 WHERE o.customer_num = c.customer_num
	 GROUP BY customer_num 
	 HAVING COUNT(order_num) > 1)

--a3) 
SELECT customer_num, fname,lname
FROM customer c
WHERE 
	(SELECT COUNT(order_num) 
	 FROM orders o
	 WHERE o.customer_num = c.customer_num) > 1


--b)
SELECT C.customer_num, fname, lname
FROM customer C
JOIN orders O ON C.customer_num = O.customer_num
GROUP BY C.customer_num, fname, lname
HAVING COUNT(order_num) > 1


--4. Seleccionar todas las Órdenes de compra cuyo Monto total (Suma de p x q de sus items)
--sea menor al precio total promedio (avg p x q) de todas las líneas de las ordenes.
--Formato de la salida: Nro. de Orden Total
--(order_num) (suma)

SELECT O.order_num, SUM(quantity * unit_price) montoTotal 
FROM orders O
JOIN items I ON I.order_num = O.order_num
GROUP BY O.order_num
HAVING SUM(quantity * unit_price) < (SELECT AVG(unit_price * quantity) FROM items)

--5. Obtener por cada fabricante, el listado de todos los productos de stock con precio
--unitario (unit_price) mayor que el precio unitario promedio de dicho fabricante.
--Los campos de salida serán: manu_code, manu_name, stock_num, description,
--unit_price.

SELECT P.manu_code, manu_name, P.stock_num, description, unit_price
FROM products P
JOIN manufact M ON M.manu_code = P.manu_code
JOIN product_types T ON T.stock_num = P.stock_num
WHERE unit_price > (SELECT AVG(unit_price) FROM products P2 WHERE P2.manu_code = M.manu_code)

--6. Usando el operador NOT EXISTS listar la información de órdenes de compra que NO
--incluyan ningún producto que contenga en su descripción el string ‘ baseball gloves’.
--Ordenar el resultado por compañía del cliente ascendente y número de orden
--descendente.
--El formato de salida deberá ser:
--Número de Cliente Compañía Número de Orden Fecha de la Orden
--(customer_num) (company) (order_num) (order_date).

SELECT O.customer_num, company, O.order_num, order_date
FROM orders	O
JOIN customer C ON O.customer_num = C.customer_num
WHERE NOT EXISTS (
SELECT item_num
FROM items I
JOIN product_types T ON I.stock_num = T.stock_num
WHERE description LIKE '%baseball gloves%'
AND I.order_num = O.order_num )
ORDER BY company ASC, order_num DESC


--7. Obtener el número, nombre y apellido de los clientes que NO hayan comprado productos
--del fabricante ‘HSK’.

SELECT customer_num, lname, fname
FROM customer C
WHERE NOT EXISTS(
SELECT manu_code
FROM ITEMS I
JOIN orders O ON I.order_num = O.order_num
WHERE manu_code = 'HSK'
AND O.customer_num = C.customer_num
)


--8. Obtener el número, nombre y apellido de los clientes que hayan comprado TODOS los
--productos del fabricante ‘HSK’.

SELECT C.customer_num, C.fname, C.lname
FROM customer C
WHERE NOT EXISTS (
	SELECT P.stock_num
	FROM products P
	WHERE manu_code = 'HSK'
	AND NOT EXISTS (
	SELECT customer_num
	FROM orders O 
	JOIN items I ON O.order_num = I.order_num
	WHERE P.stock_num = I.stock_num
	AND P.manu_code = I.manu_code
	AND O.customer_num = C.customer_num))

--El query utiliza la cláusula NOT EXISTS para encontrar los clientes que NO tienen ningún producto del fabricante 'HSK' que NO hayan comprado.


----------------------------------------------------------------------------------------------------------------------------------------
--Operador UNION

--9. Reescribir la siguiente consulta utilizando el operador UNION:
--SELECT * FROM products
--WHERE manu_code = 'HRO' OR stock_num = 1

SELECT * 
FROM products
WHERE manu_code = 'HRO'
UNION 
SELECT * 
FROM products
WHERE stock_num = 1


--10. Desarrollar una consulta que devuelva las ciudades y compañías de todos los Clientes
--ordenadas alfabéticamente por Ciudad 
--pero en la consulta deberán aparecer primero las
--compañías situadas en Redwood City y luego las demás.
--Formato: Clave de ordenamiento Ciudad Compañía
--(sortkey) (city) (company)

SELECT 1 sortkey, city, company
FROM customer
WHERE city = 'Redwood City'
UNION 
SELECT 2 sortkey, city, company
FROM customer
WHERE city != 'Redwood City'
ORDER BY sortkey, city

--ORDENAR PO SORTKEY !!

--11. Desarrollar una consulta que devuelva 
--los dos tipos de productos más vendidos y 
--los dos menos vendidos en función de las unidades totales vendidas.
--Formato
-- TipoProducto	  Cantidad
--	101				999
--	189				888
--	24				...
--	4				1

SELECT I.stock_num tipoProducto, SUM(I.quantity) CantidadComprada
FROM items I
WHERE I.stock_num IN (SELECT TOP 2 I2.stock_num
						FROM items I2
						GROUP BY I2.stock_num
						ORDER BY SUM(I2.quantity) DESC )
GROUP BY I.stock_num
UNION
SELECT I.stock_num tipoProducto, SUM(I.quantity) CantidadComprada
FROM items I
WHERE I.stock_num IN (SELECT TOP 2 I2.stock_num
						FROM items I2
						GROUP BY I2.stock_num
						ORDER BY SUM(I2.quantity) ASC)
GROUP BY I.stock_num
ORDER BY SUM(I.quantity) DESC



-------------------------------------------------------------------------------------------
--VIEWS

--12. Crear una Vista llamada ClientesConMultiplesOrdenes basada en la consulta realizada en
--el punto 3.b con los nombres de atributos solicitados en dicho punto.

--3. Listar todos los clientes que hayan tenido más de una orden.
--a) En primer lugar, escribir una consulta usando una subconsulta.
--b) Reescribir la consulta utilizando GROUP BY y HAVING.
--La consulta deberá tener el siguiente formato:
--Número_de_Cliente Nombre Apellido
--(customer_num) (fname) (lname)

CREATE VIEW ClientesConMultiplesOrdenes
AS
SELECT
C.customer_num AS numeroCliente,
C.fname AS Nombre,
C.lname AS Apellido,
COUNT(order_num) cantidadOrdenes
FROM customer C
JOIN orders O ON O.customer_num = C.customer_num
GROUP BY 
C.customer_num,
C.fname,
C.lname
HAVING COUNT(order_num) > 1


--13. Crear una Vista llamada Productos_HRO en base a la consulta
--SELECT * FROM products
--WHERE manu_code = “HRO”

--La vista deberá restringir la posibilidad de insertar datos que no cumplan con su criterio de selección.
--a. Realizar un INSERT de un Producto con manu_code=’ANZ’ y stock_num=303. Qué sucede?
--b. Realizar un INSERT con manu_code=’HRO’ y stock_num=303. Qué sucede?
--c. Validar los datos insertados a través de la vista.

CREATE VIEW Productos_HRO
AS SELECT * FROM products
WHERE manu_code = 'HRO'
WITH CHECK OPTION ;

INSERT INTO Productos_HRO (stock_num,manu_code)
VALUES (303,'ANZ') ;
INSERT INTO Productos_HRO (stock_num,manu_code)
VALUES (303,'HRO') ;


----------------------------------------------------------------------------------------------
--TRANSACCIONES

--14. Escriba una transacción que incluya las siguientes acciones:

--• BEGIN TRANSACTION
--o Insertar un nuevo cliente llamado “Fred Flintstone” en la tabla de clientes (customer).
--o Seleccionar todos los clientes llamados Fred de la tabla de clientes (customer).
--• ROLLBACK TRANSACTION

--Luego volver a ejecutar la consulta
--• Seleccionar todos los clientes llamados Fred de la tabla de clientes (customer).
--• Completado el ejercicio descripto arriba. Observar que los resultados del segundo SELECT difieren con respecto al primero.

BEGIN TRANSACTION
INSERT INTO customer (customer_num,fname) VALUES(14567,'Fred Flintstone')
SELECT * FROM customer WHERE fname = 'Fred Flintstone'
ROLLBACK TRANSACTION

SELECT * FROM customer WHERE fname = 'Fred Flintstone'


--15. Se ha decidido crear un nuevo fabricante AZZ, 
--quién proveerá parte de los mismos productos que provee el fabricante ANZ,
--los productos serán los que contengan el string ‘tennis’ en su descripción.

--• Agregar las nuevas filas en la tabla manufact y la tabla products.
--• El código del nuevo fabricante será “AZZ”, el nombre de la compañía “AZZIO SA”
--y el tiempo de envío será de 5 días (lead_time).
--• La información del nuevo fabricante “AZZ” de la tabla Products será la misma
--que la del fabricante “ANZ” pero sólo para los productos que contengan 'tennis'
--en su descripción.
--• Tener en cuenta las restricciones de integridad referencial existentes, manejar
--todo dentro de una misma transacción.

BEGIN TRANSACTION
INSERT INTO manufact (manu_code,manu_name,lead_time) VALUES ('AZZ', 'AZZIO SA', 5)
INSERT INTO products (manu_code, stock_num, unit_price, unit_code)(SELECT 'AZZ', P.stock_num, P.unit_price, P.unit_code
							FROM products P
							JOIN product_types T ON P.stock_num = T.stock_num
							WHERE manu_code = 'ANZ' AND T.description LIKE '%tennis%')
SELECT * FROM manufact WHERE manu_code = 'AZZ'
SELECT * FROM products WHERE manu_code = 'AZZ'
COMMIT TRANSACTION

	
