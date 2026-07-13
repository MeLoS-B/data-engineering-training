


--Query 21 Join orders with customers and show order_id, customer_name, city, order_date, and status.

SELECT orders.order_id,customers.customer_name,customers.city,orders.order_date,orders.status FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id;


--Query 22 Join orders with products and show order_id, product_name, category, quantity, price, total_amount, and status.


SELECT orders.order_id,products.product_name,products.category,orders.quantity,products.price,products.price * orders.quantity AS total_amount,status FROM orders INNER JOIN products
ON orders.product_id = products.product_id



--Query 23 Join all three tables and create a complete order report with customer_name, city, product_name, category,quantity, price, total_amount, status, and order_date.


SELECT 
    customers.customer_name,
    customers.city,
    products.product_name,
    products.category,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS total_amount,
    orders.status,
    orders.order_date
FROM orders
INNER JOIN customers 
ON orders.customer_id = customers.customer_id
INNER JOIN products 
ON orders.product_id = products.product_id;



--Query 24 Create completed revenue by product_name.

SELECT quantity * price AS total_price,product_name FROM orders INNER JOIN products ON orders.product_id = products.product_id
GROUP BY product_name


--Query 25 Create completed revenue by category.

SELECT quantity * price AS total_price,category FROM orders INNER JOIN products ON orders.product_id = products.product_id
GROUP BY category


--Query 26 Create order count by city.

SELECT 
    customers.city,
    COUNT(*) AS total_count_by_city
FROM orders
INNER JOIN customers 
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY total_count_by_city DESC;


--Query 27 Create completed revenue by city.

SELECT 
    customers.city,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city
ORDER BY completed_revenue DESC;


--Query 28 Create completed revenue by customer_name.

SELECT SUM(quantity *  products.price) as total_revenue,customers.customer_name FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_name
ORDER BY total_revenue DESC;



--Query 29 Show customers with more than one order using GROUP BY and HAVING.

SELECT *,Count(*) as total_orders,customers.customer_id FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id
HAVING total_orders > 1



--Query 30 Show top 3 customers by completed revenue.

SELECT customers.customer_id,SUM(orders.quantity * products.price ) AS total_revenue FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN products ON products.product_id = orders.product_id
GROUP BY customers.customer_id
ORDER BY total_revenue DESC
LIMIT 3;


--Query 31 Show top 3 products by completed revenue.

SELECT 
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
INNER JOIN products 
    ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC
LIMIT 3;



--Query 32 Show all pending or cancelled orders with customer_name, city, product_name, and potential_amount.


SELECT 
    customers.customer_name,
    customers.city,
    products.product_name,
    (orders.quantity * products.price) AS potential_amount,
    orders.status
FROM orders
INNER JOIN customers 
    ON orders.customer_id = customers.customer_id
INNER JOIN products 
    ON orders.product_id = products.product_id
WHERE orders.status IN ('pending', 'cancelled');