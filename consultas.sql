-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas
SELECT codigo_oficina, ciudad FROM Oficinas;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM Oficinas WHERE pais = 'España';
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email FROM Empleados WHERE codigo_jefe = 7;
-- 4. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- Utilizando la función YEAR de MySQL:
SELECT DISTINCT codigo_cliente FROM Pagos WHERE YEAR(fecha_pago) = 2008;
-- Utilizando la función DATE_FORMAT de MySQL:
SELECT DISTINCT codigo_cliente FROM Pagos WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';
-- 5. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) FROM Empleados;
-- 6. ¿Cuántos clientes tiene cada país?
SELECT pais, COUNT(*) FROM Clientes GROUP BY pais;
-- 7. ¿Cuál fue el pago medio en 2009?
SELECT AVG(total) FROM Pagos WHERE YEAR(fecha_pago) = 2009;
-- 8. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado, COUNT(*) AS numero_pedidos FROM Pedidos GROUP BY estado ORDER BY numero_pedidos DESC;
-- 9. Calcula el precio de venta del producto más caro y barato en una misma consulta.
SELECT MAX(precio_venta), MIN(precio_venta) FROM Productos;
-- 10. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente FROM Clientes ORDER BY limite_credito DESC LIMIT 1;
-- 11. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre FROM Productos ORDER BY precio_venta DESC LIMIT 1;
-- 12. Devuelve el nombre del producto del que se han vendido más unidades. 
-- (Tenga en cuenta que tendrá que calcular cuál es el número total de 
-- unidades que se han vendido de cada producto a partir de los datos de la 
-- tabla detalle_pedido
SELECT p.nombre 
FROM Productos p 
JOIN Detalle_Pedidos dp ON p.codigo_producto = dp.codigo_producto 
GROUP BY p.nombre 
ORDER BY SUM(dp.cantidad) DESC 
LIMIT 1;
-- 13. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
SELECT c.codigo_cliente 
FROM Clientes c 
WHERE c.limite_credito > (SELECT SUM(p.total) FROM Pagos p WHERE p.codigo_cliente = c.codigo_cliente);
-- 14. Devuelve el listado de clientes indicando el nombre del cliente y cuantos 
-- pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no 
-- han realizado ningún pedido.
SELECT c.nombre_cliente, COUNT(p.codigo_pedido) 
FROM Clientes c 
LEFT JOIN Pedidos p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.nombre_cliente;
-- 15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos 
-- empleados que no sean representante de ventas de ningún cliente
SELECT e.nombre, e.apellido1, e.apellido2, o.telefono 
FROM Empleados e 
JOIN Oficinas o ON e.codigo_oficina = o.codigo_oficina 
WHERE e.puesto != 'Representante de ventas';
-- 16. Devuelve las oficinas donde no trabajan ninguno de los empleados que 
-- hayan sido los representantes de ventas de algún cliente que haya realizado 
-- la compra de algún producto de la gama Frutales
SELECT o.*
FROM Oficinas o
WHERE o.codigo_oficina NOT IN (
    SELECT e.codigo_oficina
    FROM Empleados e
    JOIN Clientes c ON e.codigo_empleado = c.codigo_empleado
    JOIN Pedidos p ON c.codigo_cliente = p.codigo_cliente
    JOIN Detalle_Pedidos dp ON p.codigo_pedido = dp.codigo_pedido
    JOIN Productos pr ON dp.codigo_producto = pr.codigo_producto
    WHERE pr.gama = 'Frutales'
);
-- 17. Devuelve el listado de clientes indicando el nombre del cliente y cuantos 
-- pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no 
-- han realizado ningún pedido
SELECT c.nombre_cliente, COUNT(p.codigo_pedido) 
FROM Clientes c 
LEFT JOIN Pedidos p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.nombre_cliente;
-- 18. Devuelve un listado con los nombres de los clientes y el total pagado por 
-- cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han 
-- realizado ningún pago.
SELECT c.nombre_cliente, COALESCE(SUM(p.total), 0) 
FROM Clientes c 
LEFT JOIN Pagos p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.nombre_cliente;






