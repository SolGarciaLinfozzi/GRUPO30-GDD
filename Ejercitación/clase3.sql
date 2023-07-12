-- CLASE 3 EJERCITACIÓN

USE Comercial;
 
--1
SELECT fname,address1,address2 
FROM customer;

--2
SELECT fname,address1,address2 
FROM customer 
WHERE state='CA';

--3
SELECT DISTINCT city 
FROM customer
WHERE state='CA';

--4
SELECT DISTINCT city 
FROM customer 
WHERE state='CA' ORDER BY city ASC;

--5
SELECT address1,address2 
FROM customer 
WHERE customer_num = 103;

--6
SELECT stock_num 
FROM products 
WHERE manu_code = 'ANZ' 
ORDER BY unit_code ASC;

--7
SELECT DISTINCT manu_code 
FROM items 
ORDER BY 1;
-- "ORDER BY 1" indica que se ordenen por la primera columna seleccionada en la consulta (en este caso, "manu_code").

--8 
SELECT order_num ,order_date,customer_num,ship_date 
FROM orders 
WHERE paid_date IS NULL AND ship_date >= '2015-01-01' AND ship_date < '2015-07-01' 
ORDER BY 1;
--MONTH(ship_date)<=6 AND YEAR(ship_date)<=2015;

--9 
SELECT customer_num,company 
FROM customer 
WHERE company LIKE '%town%';

--10
SELECT MAX(ship_charge) precio_maximo, MIN(ship_charge) precio_minimo, AVG(ship_charge) precio_promedio 
FROM orders;

--11
SELECT order_num,order_date,ship_date 
FROM orders 
WHERE MONTH(ship_date) = MONTH(order_date) AND YEAR(ship_date) = YEAR(order_date);

--12
SELECT customer_num, ship_date, COUNT(*) cant_embarques, SUM(ship_charge) total 
FROM orders 
GROUP BY customer_num, ship_date 
ORDER BY total DESC;

--13
SELECT ship_date, SUM(ship_weight) total_libras
FROM orders 
GROUP BY ship_date 
HAVING SUM(ship_weight) >= 30 
ORDER BY total_libras DESC;


--14
SELECT customer_num, fname, state, company 
FROM customer 
WHERE state = 'CA' ORDER BY company; 

--15

SELECT manu_code, COUNT(DISTINCT stock_num) productosUnicos
FROM items 
GROUP BY manu_code 
HAVING SUM(quantity * unit_price) >1500 
ORDER BY 2 DESC;


--16
SELECT manu_code, stock_num, SUM(quantity) cant_vendida, unit_price, SUM(quantity*unit_price) total_vendido  
FROM items 
WHERE manu_code LIKE '_R%'
GROUP BY manu_code, stock_num, unit_price
ORDER BY manu_code, stock_num


--17
CREATE TABLE #ordenesTemp(
	customer_num INT,
	cant_ordenes_cliente INT,
	primer_fecha_compra	DATETIME,
	ultima_fecha_compra DATETIME);

INSERT INTO #ordenesTemp (customer_num, cant_ordenes_cliente,primer_fecha_compra,ultima_fecha_compra)
SELECT DISTINCT
	customer_num,
	COUNT(*),
	MIN(order_date),
	MAX(order_date)
FROM orders
GROUP BY customer_num

SELECT * 
FROM #ordenesTemp 
WHERE primer_fecha_compra < '2015-05-23 00:00:00.000'
ORDER BY ultima_fecha_compra DESC;

--18

SELECT COUNT(customer_num) cantClientes, cant_ordenes_cliente
FROM #ordenesTemp 
GROUP BY  cant_ordenes_cliente
ORDER BY cant_ordenes_cliente DESC;


--19
--Son visibles durante la misma sesión por lo que se eliminan cuando el usuario se desconecta.

--20

SELECT COUNT(customer_num) cant_clientes, state, city
FROM customer
WHERE company LIKE '%ts%' 
AND city != 'Mountain View'  --  <>  Ó !=
AND zipcode BETWEEN 93000 AND 94100 
GROUP BY state , city
ORDER BY city

--21

SELECT state, COUNT(customer_num_referedBy) cant_clientes_referidos
FROM customer
WHERE company LIKE '[A-L]%'
GROUP BY state

select c.state, count(*)
from customer c
where c.company like '[A-L]%'
and c.customer_num_referedBy IS NOT NULL
group by c.state
order by 1


--22
SELECT state, AVG(lead_time) prom_lead_time
FROM manufact
WHERE manu_name LIKE '%e%' 
AND lead_time BETWEEN 5 AND 20
GROUP BY state


--23
SELECT unit, COUNT(*)+1 cant_unidades
FROM units
WHERE unit_descr IS NOT NULL
GROUP BY unit
HAVING COUNT(*) >5
