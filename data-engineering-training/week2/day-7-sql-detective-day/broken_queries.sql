
--Query 1
SELECT city, COUNT(*) AS order_count
FROM orders
GROUP BY city;


--Query 2
SELECT product_name SUM(quantity * price) AS revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE status = 'completed'
GROUP BY product_name;


--Query 3
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status;
ORDER BY order_count DESC;


--Query 4
SELECT order_id, quantity, price, quantity * price AS total_amount
FROM orders;

--Query 5
SELECT category, SUM(quantity) AS total_quantity
FROM orders
WHERE status = 'completed'
GROUP BY category;

--Query 6
SELECT SUM(quantity * price) AS total_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id;


--Query 7
SELECT customer_id, COUNT(*) AS order_count
FROM orders
HAVING COUNT(*) > 1
GROUP BY customer_id;

--Query 8
SELECT orders.order_id, customers.customer_name
FROM orders
JOIN customers;


--Query 9
SELECT customer_id, product_id, price
FROM orders
JOIN products ON orders.product_id = products.product_id;


--Query 10
SELECT *
FROM orders
WHERE status = 'completed';