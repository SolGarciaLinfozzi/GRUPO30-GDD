--EJERCITACION CLASE 4 

USE Comercial;

--1
--Una forma
CREATE TABLE #clientes (
	customer_num smallint not null PRIMARY KEY,
	fname varchar(15) null,
	lname varchar(15) null,
	company varchar(20) null,
	address1 varchar(20) null,
	address2 varchar(20) null,
	city varchar(15) null,
	state char(2) null,
	zipcode char(5) null,
	phone varchar(18) null,
	customer_num_referedBy smallint null,
	status char(1) null,
	FOREIGN KEY (state) REFERENCES state,
	FOREIGN KEY (customer_num_referedBy) REFERENCES customer);

	INSERT INTO #clientes SELECT * FROM customer;

--No es necesario crear la tabla 
--Directamente se puede hacer de esta manera más rápida
	SELECT * INTO #clientes2 FROM customer;

--2
INSERT INTO #clientes (customer_num,fname,lname,company,state,city)
VALUES (144, 'Agustín', 'Creevy', 'Jaguares SA', 'CA', 'Los Angeles');

SELECT * FROM #clientes;

--3
SELECT * INTO #clientesCalifornia FROM customer
WHERE state = 'CA';

SELECT * FROM #clientesCalifornia;

--4
INSERT INTO #clientes
(customer_num, fname, lname, company, address1, address2, city, state,zipcode, phone)
SELECT 155,fname,lname,company,address1,address2,city,state,zipcode,phone
FROM customer
WHERE customer_num=103

--5
--Verificar
SELECT COUNT(*) CantFilasAEliminar FROM #clientes
WHERE zipcode BETWEEN 94000 AND 94050
AND city LIKE 'M%'

DELETE FROM #clientes 
WHERE zipcode BETWEEN 94000 AND 94050
AND city LIKE 'M%'

--6
SELECT COUNT(customer_num) cantFilasAEliminar from #clientes WHERE state='CO';

UPDATE #clientes
SET state ='AK', address2= 'Barrio Las Heras'
WHERE state = 'CO';

--7
UPDATE #clientes
SET phone ='1'+ phone
