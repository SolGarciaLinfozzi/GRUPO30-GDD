USE Comercial;

--CLASE 11: QUERIES COMPLEJOS

1. Listar Número de Cliente, apellido y nombre, Total Comprado por el cliente ‘Total del Cliente’,
Cantidad de Órdenes de Compra del cliente ‘OCs del Cliente’ y la Cant. de Órdenes de Compra
solicitadas por todos los clientes ‘Cant. Total OC’, de todos aquellos clientes cuyo promedio de compra
por Orden supere al promedio de órdenes de compra general, tengan al menos 2 órdenes y cuyo
zipcode comience con 94.

2.a Se requiere crear una tabla temporal #ABC_Productos un ABC de Productos ordenado por cantidad
de venta en u$, los datos solicitados son:
Nro. de Stock, Código de fabricante, descripción del producto, Nombre de Fabricante, Total del producto
pedido 'u$ por Producto', Cant. de producto pedido 'Unid. por Producto', para los productos que
pertenezcan a fabricantes que fabriquen al menos 10 productos diferentes.

3. En función a la tabla temporal generada en el punto 2, obtener un listado que detalle para cada tipo
de producto existente en #ABC_Producto, la descripción del producto, el mes en el que fue solicitado, el
cliente que lo solicitó (en formato 'Apellido, Nombre'), la cantidad de órdenes de compra 'Cant OC por
mes', la cantidad del producto solicitado 'Unid Producto por mes' y el total en u$ solicitado 'u$ Producto
por mes'.
Mostrar sólo aquellos clientes que vivan en el estado con mayor cantidad de clientes, ordenado por
mes y descripción del tipo de producto en forma ascendente y por cantidad de productos por mes en
forma descendente.

4. Dado los productos con número de stock 5, 6 y 9 del fabricante 'ANZ' listar de a pares los clientes que
hayan solicitado el mismo producto, siempre y cuando, el primer cliente haya solicitado más cantidad
del producto que el 2do cliente.
Se deberá informar nro de stock, código de fabricante, Nro de Cliente y Apellido del primer cliente, Nro
de cliente y apellido del 2do cliente ordenado por stock_num y manu_code

5. Se requiere realizar una consulta que devuelva en una fila la siguiente información: La mayor cantidad de
órdenes de compra de un cliente, mayor total en u$ solicitado por un cliente y la mayor cantidad de
productos solicitados por un cliente, la menor cantidad de órdenes de compra de un cliente, el menor total
en u$ solicitado por un cliente y la menor cantidad de productos solicitados por un cliente
Los valores máximos y mínimos solicitados deberán corresponderse a los datos de clientes según todas
las órdenes existentes, sin importar a que cliente corresponda el dato.

6. Seleccionar los número de cliente, número de orden y monto total de la orden de aquellos clientes del
estado California(CA) que posean 4 o más órdenes de compra emitidas en el 2015. Además las órdenes
mostradas deberán cumplir con la salvedad que la cantidad de líneas de ítems de esas órdenes debe ser
mayor a la cantidad de líneas de ítems de la orden de compra con mayor cantidad de ítems del estado AZ
en el mismo año.

7. Se requiere listar para el Estado de California el par de clientes que sean los que suman el mayor
monto en dólares en órdenes de compra, con el formato de salida:
'Código Estado', 'Descripción Estado', 'Apellido, Nombre', 'Apellido, Nombre', 'Total Solicitado' (*)
(*) El total solicitado contendrá la suma de los dos clientes.

8. Se observa que no se cuenta con stock suficiente para las últimas 5 órdenes de compra emitidas que
contengan productos del fabricante 'ANZ'. Por lo que se decide asignarle productos en stock a la orden
del cliente que más cantidad de productos del fabricante 'ANZ' nos haya comprado.
Se solicita listar el número de orden de compra, número de cliente, fecha de la orden y una fecha de
orden “modificada” a la cual se le suma el lead_time del fabricante más 1 día por preparación del pedido
a aquellos clientes que no son prioritarios. Para aquellos clientes a los que les entregamos los productos
en stock, la “fecha modificada” deberá estar en NULL.
Listar toda la información ordenada por “fecha modificada”

9. Listar el número, nombre, apellido, estado, cantidad de órdenes y monto total comprado de los
clientes que no sean del estado de Wisconsin y cuyo monto total comprado sea mayor que el monto
total promedio de órdenes de compra.