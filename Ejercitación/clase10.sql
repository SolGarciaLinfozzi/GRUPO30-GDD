USE Comercial;

--CLASE 10: QUERIES COMPLEJOS

--1) Crear una vista que devuelva:
--a) Código y Nombre (manu_code,manu_name) de los fabricante, 
--posean o no productos(en tabla Products),
--cantidad de productos que fabrican (cant_producto)
-- y la fecha de la última OC que contenga un producto suyo (ult_fecha_orden).

-- De los fabricantes que fabriquen productos sólo se podrán mostrar los que
--fabriquen más de 2 productos.
-- No se permite utilizar funciones definidas por usuario, ni tablas temporales, ni
--UNION.

--b) Realizar una consulta sobre la vista que devuelva manu_code, manu_name,
--cant_producto y si el campo ult_fecha_orden posee un NULL informar ‘No Posee
--Órdenes’ si no posee NULL informar el valor de dicho campo.
-- No se puede utilizar UNION para el SELECT.

DROP VIEW informacion_fabricantes;
CREATE VIEW informacion_fabricantes
AS 
SELECT
M.manu_code AS Código,
M.manu_name AS Nombre,
COUNT(DISTINCT P.stock_num) AS cantidadProductos,
MAX(O.order_date) AS ultFechaOrden
FROM manufact M
LEFT JOIN products P ON M.manu_code = P.manu_code
LEFT JOIN items I ON I.manu_code = M.manu_code
LEFT JOIN orders O ON O.order_num = i.order_num
GROUP BY  
M.manu_code,
M.manu_name
HAVING COUNT(DISTINCT P.stock_num)>2 OR COUNT(DISTINCT P.stock_num)=0

SELECT * FROM informacion_fabricantes;

--Prueba1b)
INSERT INTO manufact VALUES ('PRU','Prueba',99,'CA',NULL,NULL);

SELECT 
Código,
Nombre, 
cantidadProductos,
CASE 
WHEN ultFechaOrden IS NULL THEN 'No posee productos' 
WHEN ultFechaOrden IS NOT NULL THEN CAST (ultFechaOrden AS CHAR)
END AS ultimaFechaOrden
FROM informacion_fabricantes

-- Borro la fila dummy
DELETE FROM manufact WHERE manu_code='PRU'


--2) Desarrollar una consulta ABC de fabricantes que:
--Liste el código y nombre del fabricante, la cantidad de órdenes de compra que contengan
--sus productos y la monto total de los productos vendidos.

--Mostrar sólo los fabricantes cuyo código comience con A ó con N y posea 3 letras, y los
--productos cuya descripción posean el string “tennis” ó el string “ball” en cualquier parte del
--nombre y cuyo monto total vendido sea mayor que el total de ventas promedio de todos
--los fabricantes (Cantidad * precio unitario / Cantidad de fabricantes que vendieron sus
--productos).
--Mostrar los registros ordenados por monto total vendido de mayor a menor.

SELECT 
	M.manu_code, 
	M.manu_name, 
	COUNT(DISTINCT I.order_num) cantidadOC, 
	SUM(quantity * unit_price) montoTotal
FROM manufact M
	JOIN items I ON M.manu_code = I.manu_code
	JOIN product_types T ON I.stock_num = T.stock_num
WHERE (description LIKE '%tennis%' OR description LIKE '%ball%')
	AND M.manu_code LIKE '[AN]__' 
GROUP BY M.manu_code, manu_name
HAVING SUM(quantity * unit_price) > (SELECT SUM(quantity * unit_price)/COUNT(DISTINCT manu_code) FROM items)
ORDER BY SUM(quantity * unit_price) DESC



3) Crear una vista que devuelva
Para cada cliente mostrar (customer_num, lname, company), cantidad de órdenes
de compra, fecha de su última OC, monto total comprado y el total general
comprado por todos los clientes.
De los clientes que posean órdenes sólo se podrán mostrar los clientes que tengan
alguna orden que posea productos que son fabricados por más de dos fabricantes y
que tengan al menos 3 órdenes de compra.
Ordenar el reporte de tal forma que primero aparezcan los clientes que tengan
órdenes por cantidad de órdenes descendente y luego los clientes que no tengan
órdenes.
--No se permite utilizar funciones, ni tablas temporales.




4) Crear una consulta que devuelva los 5 primeros estados y el tipo de producto
(description) más comprado en ese estado (state) según la cantidad vendida del tipo
de producto.
Ordenarlo por la cantidad vendida en forma descendente.
Nota: No se permite utilizar funciones, ni tablas temporales.

5) Listar los customers que no posean órdenes de compra y aquellos cuyas últimas
órdenes de compra superen el promedio de todas las anteriores.
Mostrar customer_num, fname, lname, paid_date y el monto total de la orden que
supere el promedio de las anteriores. Ordenar el resultado por monto total en forma
descendiente.

6) Se desean saber los fabricantes que vendieron mayor cantidad de un mismo
producto que la competencia según la cantidad vendida. Tener en cuenta que puede
existir un producto que no sea fabricado por ningún otro fabricante y que puede
haber varios fabricantes que tengan la misma cantidad máxima vendida.
Mostrar el código del producto, descripción del producto, código de fabricante,
cantidad vendida, monto total vendido. Ordenar el resultado código de producto, por
cantidad total vendida y por monto total, ambos en forma decreciente.
Nota: No se permiten utilizar funciones, ni tablas temporales.