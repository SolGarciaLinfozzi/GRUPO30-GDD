--EJERCITACION CLASE 5

USE Comercial;

--1
SELECT c.customer_num, company, order_num
FROM customer c 
INNER JOIN orders o ON c.customer_num = o.customer_num
ORDER BY c.customer_num;

--2
SELECT  order_num, item_num,description, manu_code, quantity, (unit_price*quantity) precioTotal 
FROM items I
INNER JOIN product_types P ON I.stock_num = P.stock_num
WHERE order_num = 1004;

--3
SELECT order_num, item_num, description, I.manu_code, quantity, (unit_price*quantity) precioTotal, manu_name
FROM items I
INNER JOIN product_types P ON I.stock_num = P.stock_num
INNER JOIN manufact M ON I.manu_code = M.manu_code
WHERE order_num = 1004;

--4
SELECT order_num, C.customer_num, fname, lname, company
FROM customer C
INNER JOIN orders O ON C.customer_num = O.customer_num;
--WHERE order_num IS NOT NULL;     INNECESARIO

--5
SELECT DISTINCT C.customer_num, lname, fname, company 
FROM customer C
INNER JOIN orders O ON C.customer_num = O.customer_num;

--otra manera
SELECT DISTINCT C.customer_num,fname,lname,company
FROM orders O 
INNER JOIN customer C ON (O.customer_num = C.customer_num)


--6
SELECT manu_name, P.stock_num, description, unit, unit_price, (unit_price*1.20) 'Precio Junio'
FROM products P
INNER JOIN manufact M ON P.manu_code = M.manu_code
INNER JOIN product_types T ON P.stock_num = T.stock_num
INNER JOIN units U ON P.unit_code = U.unit_code;

--7
SELECT item_num, description, quantity, (unit_price*quantity) 'Precio Total'
FROM items I
INNER JOIN product_types T ON I.stock_num = T.stock_num
WHERE order_num = 1004;

--8
SELECT DISTINCT manu_name, lead_time --IMPORTANTE EL DISTINCT
FROM items I
INNER JOIN manufact M ON I.manu_code = M.manu_code
INNER JOIN orders O ON (I.order_num = O.order_num)
WHERE customer_num = 104;

--9
SELECT O.order_num, order_date, item_num, description, quantity, (unit_price*quantity) 'Precio Total'
FROM orders O
INNER JOIN items I ON O.order_num = I.order_num
INNER JOIN product_types T ON I.stock_num = T.stock_num;

--10
SELECT lname +', '+ fname 'Apellido y nombre', '(' + SUBSTRING(phone,1,3) + ')' + ' ' + SUBSTRING(phone,5,8) telefono
FROM customer
ORDER BY lname,fname;

--11
SELECT ship_date, lname + ', ' + fname 'Apellido y nombre', COUNT(order_num)
FROM orders O
INNER JOIN customer C ON O.customer_num = C.customer_num
INNER JOIN state S ON S.state= C.state
WHERE sname = 'California'
AND zipcode BETWEEN 94000 AND 94100
GROUP BY ship_date, lname, fname  --Necesito hacerlo por el COUNT(order_num)
ORDER BY ship_date, lname, fname;
--agrupado y ordenado por fecha de embarque y por cliente

--12
SELECT manu_name, description, SUM(quantity) cantidadVendida, SUM(quantity * unit_price) totalVendido
FROM items I
INNER JOIN product_types T ON I.stock_num = T.stock_num
INNER JOIN manufact M ON I.manu_code = M.manu_code
INNER JOIN orders O ON I.order_num = O.order_num
WHERE I.manu_code IN ('ANZ','HRO','HSK','SMT')
AND O.order_date BETWEEN '2015-05-01' AND '2015-06-30'
GROUP BY manu_name , description
ORDER BY 4 DESC;

--Otra solución
SELECT manu_name, description, SUM(quantity) cantidadVendida, SUM(quantity* unit_price) totalVendido
FROM manufact m 
JOIN items i ON (m.manu_code=i.manu_code)
JOIN product_types p ON (i.stock_num = p.stock_num)
JOIN orders o ON (i.order_num=o.order_num)
WHERE m.manu_code IN ('ANZ', 'HRO', 'HSK', 'SMT')
AND order_date BETWEEN '2015-05-01' AND '2015-06-30'
GROUP BY manu_name, description
ORDER BY 4 DESC;

--13
SELECT CAST(YEAR(order_date) AS VARCHAR)+'/'+CAST(MONTH(order_date) AS VARCHAR) 'Año/Mes', SUM(quantity) unidadesVendidas, SUM(quantity * unit_price) importeTotal
FROM items I
INNER JOIN product_types T ON I.stock_num = T.stock_num
INNER JOIN orders O ON I.order_num = O.order_num
GROUP BY YEAR(O.order_date), MONTH(O.order_date)
ORDER BY importeTotal DESC;
