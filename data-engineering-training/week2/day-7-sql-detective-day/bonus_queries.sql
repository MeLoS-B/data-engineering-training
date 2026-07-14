


--Query 1 Create a query that shows completed revenue by city using orders + customers + products.

SELECT orders.quantity  * products.price as total_price,orders.order_id,customers.customer_id,orders.quantity,orders.status
FROM orders INNER JOIN customers ON orders.order_id = customers.customer_id
INNER JOIN products ON orders.product_id = products.product_id


--Query 2 Create a query that shows average completed order value by category.

SELECT AVG(products.price * orders.quantity) as average ,products.category FROM orders INNER JOIN products ON orders.product_id = products.product_id
GROUP BY products.category


--Query 3 Create a query that shows only products with completed revenue greater than 100.

SELECT products.price * orders.quantity as total_amount,products.product_name 
FROM orders INNER JOIN products ON orders.product_id = products.product_id
GROUP BY product_name
HAVING total_amount > 100



--Query 4  Create a query that compares completed, pending, and cancelled order counts by city.
SELECT
    customers.city,
    COUNT(CASE WHEN orders.status = 'completed' THEN 1 END) AS completed_count,
    COUNT(CASE WHEN orders.status = 'pending' THEN 1 END) AS pending_count,
    COUNT(CASE WHEN orders.status = 'cancelled' THEN 1 END) AS cancelled_count
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY customers.city;


--Query 5 Create one intentional broken query yourself, explain the mistake, and then fix it.

--broke query
SELECT products.price * orders.quantity as total_amount,products.product_name 
FROM orders INNER JOIN products ON orders.product_id = products.product_id
HAVING total_amount > 100
GROUP BY product_name;

--good query
SELECT products.price * orders.quantity as total_amount,products.product_name 
FROM orders INNER JOIN products ON orders.product_id = products.product_id
GROUP BY product_name
HAVING total_amount > 100;
