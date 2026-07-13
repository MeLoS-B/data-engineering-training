

--Query 12 Count orders by status.

SELECT COUNT(*) AS count_order_by_status,status  FROM orders
GROUP BY status
ORDER BY count_order_by_status DESC;

--Query 13 Count orders by order_date.

SELECT COUNT(*) AS count_order_by_order_date,order_date  FROM orders
GROUP BY order_date


--Query 14 Count orders by customer_id.


SELECT COUNT(*) AS count_order_by_customer_id,customer_id  FROM orders
GROUP BY customer_id
ORDER BY count_order_by_customer_id DESC;


--Query 15 Count orders by product_id.

SELECT COUNT(*) AS count_order_by_product_id,product_id  FROM orders
GROUP BY product_id
ORDER BY count_order_by_product_id DESC;


--Query 16 Calculate total quantity by product_id for completed orders only.

SELECT 
    product_id,
    SUM(quantity) AS total_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id
ORDER BY total_quantity DESC;



--Query 17 Calculate completed revenue by product_id.

SELECT 
    products.product_id,
    SUM(quantity * price) AS total_price
FROM orders
INNER JOIN products 
ON orders.product_id = products.product_id
WHERE status = 'completed'
GROUP BY products.product_id;



--Query 18 Calculate completed revenue by status and explain why the result is not always a good business report.


SELECT 
    products.product_id,
    SUM(quantity * price) AS total_price,
    status
FROM orders
INNER JOIN products 
ON orders.product_id = products.product_id
GROUP BY products.product_id,status


--Query 19 Use HAVING to show only customer_id values with more than one order.

SELECT COUNT(*) as total_count,customers.customer_id FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id
HAVING total_count > 1


--Query 20 Use HAVING to show only product_id values where completed quantity is greater than 2.

SELECT SUM(quantity) as total_quantity,products.product_id FROM orders INNER JOIN products ON orders.product_id = products.product_id
GROUP BY products.product_id
HAVING total_quantity > 2


