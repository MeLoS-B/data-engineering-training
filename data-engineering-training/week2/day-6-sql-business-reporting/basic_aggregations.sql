
--Query 1 Count all orders.
SELECT COUNT(*) FROM orders;

--Query 2 Count only completed orders.
SELECT * FROM orders
WHERE status = 'completed'

--Query 3 Count only pending orders.
SELECT * FROM orders
WHERE status = 'pending'

--Query 4 Count only cancelled orders.
SELECT * FROM orders
WHERE status = 'cancelled'


--Query 5 Calculate total quantity ordered across all statuses.
SELECT SUM(quantity) as total_quantity FROM orders


--Query 6 Calculate total quantity ordered only from completed orders.

SELECT SUM(quantity) as total_quantity_status_completed FROM orders
WHERE status = 'completed'


--Query 7 Find the average product price.

SELECT AVG(price) AS average_price FROM products;


--Query 8 Find the cheapest product price.

SELECT MIN(price) AS minimum_price FROM products;


--Query 9 Find the most expensive product price.

SELECT MAX(price) AS maximum_price FROM products;


--Query 10 Calculate completed revenue using quantity * price. This requires connecting orders with products.

SELECT product_name,quantity * price AS total_price FROM orders INNER JOIN products ON products.product_id = orders.product_id;


--Query 11 Calculate non-completed potential value from pending and cancelled orders. Explain why this should not be counted as real revenue.


SELECT SUM(quantity * price) AS  potential_value 
FROM orders
INNER JOIN products
ON orders.product_id = products.product_id
WHERE status = 'pending' OR status = 'cancelled';


