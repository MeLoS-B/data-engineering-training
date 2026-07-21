


--Query 1 Show all customers.
SELECT * FROM customers;

--Query 2 Show all products.
SELECT * FROM products;

--Query 3 Show all orders.
SELECT * FROM orders;

--Query 4 Show all order_items.
SELECT * FROM order_items;

--Query 5 Show only completed orders.

SELECT * FROM orders
WHERE status = 'completed';

--Query 6 Show only pending or cancelled orders.
SELECT * FROM orders
WHERE status IN ('pending','cancelled');

--Query 7 Show each order with customer_name, city, order_date, status, and channel.

SELECT * FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id;

--Query 8 Show each order_item with product_name, category, price, and quantity.
SELECT product_name,category,price,quantity FROM order_items INNER JOIN products ON order_items.product_id = products.product_id; 


--Query 9 Show order_id, customer_name, product_name, quantity, price, and total_amount.
SELECT orders.order_id,customer_name,product_name,quantity,price,quantity * price as total_amount FROM order_items INNER JOIN products ON order_items.product_id = products.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN customers ON orders.customer_id = customers.customer_id

--Query 10 Show only completed orders with their customer and product details.


SELECT 
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.customer_name,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price
FROM order_items oi
INNER JOIN products p 
    ON oi.product_id = p.product_id
INNER JOIN orders o 
    ON oi.order_id = o.order_id
INNER JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed';




--Query 11 Join customers + orders + order_items + products in one query.

SELECT * FROM order_items INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN products ON order_items.product_id = products.product_id
INNER JOIN customers ON orders.customer_id = customers.customer_id


--Query 12 Join customers + orders + order_items + products in one query.

SELECT customer_name,city,orders.order_id,product_name,category,quantity,price,quantity * price AS total_amount FROM order_items INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN products ON order_items.product_id = products.product_id
INNER JOIN customers ON orders.customer_id = customers.customer_id


--Query 13 Sort the result by order_id and then by product_name.

SELECT 
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.customer_name,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price
FROM order_items oi
INNER JOIN products p 
    ON oi.product_id = p.product_id
INNER JOIN orders o 
    ON oi.order_id = o.order_id
INNER JOIN customers c 
    ON o.customer_id = c.customer_id

ORDER BY o.order_id ASC, p.product_name ASC;


--Query 14 Filter the joined result to show only completed orders.


SELECT 
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.customer_name,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price
FROM order_items oi
INNER JOIN products p 
    ON oi.product_id = p.product_id
INNER JOIN orders o 
    ON oi.order_id = o.order_id
INNER JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
ORDER BY o.order_id ASC, p.product_name ASC;


--Query 15 Calculate completed revenue by city.
SELECT 
    city,
    SUM(quantity*price) AS total_amount
FROM order_items
INNER JOIN orders 
ON order_items.order_id = orders.order_id
INNER JOIN products 
ON order_items.product_id = products.product_id
INNER JOIN customers 
ON orders.customer_id = customers.customer_id
WHERE orders.status = 'completed'
GROUP BY city;

--Query 16 Calculate completed revenue by product category.

SELECT 
    category,
    SUM(quantity*price) AS total_amount
FROM order_items
INNER JOIN orders 
ON order_items.order_id = orders.order_id
INNER JOIN products 
ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY category;

--Query 17 Show top 5 customers by completed revenue.
SELECT 
    customer_name,
    SUM(quantity*price) AS total_amount
FROM order_items
INNER JOIN orders 
ON order_items.order_id = orders.order_id
INNER JOIN products 
ON order_items.product_id = products.product_id
INNER JOIN customers 
ON orders.customer_id = customers.customer_id
WHERE orders.status = 'completed'
GROUP BY customer_name
ORDER BY total_amount DESC
LIMIT 5;


--Query 18 Show top 5 products by completed revenue.

SELECT product_name,SUM(quantity*price) as total_amount FROM order_items INNER JOIN orders ON order_items.order_id = orders.order_id 
INNER JOIN products ON order_items.product_id = products.product_id 
INNER JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY product_name
ORDER BY total_amount DESC
LIMIT 5;


--Query 19 Count how many orders each customer has.

SELECT 
    customer_name,
    COUNT(DISTINCT orders.order_id) AS number_of_orders
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name;

--Query 20 Count how many items each order has.


SELECT
    order_id,
    SUM(quantity) AS total_items
FROM order_items
GROUP BY order_id;


--Query 21 Find customers who have more than one order.

SELECT
    customer_name,
    COUNT(orders.order_id) AS number_of_orders
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name
HAVING COUNT(orders.order_id) > 1;


--Query 22 Find products that were sold more than once.
SELECT
    product_name,
    SUM(quantity) AS total_sold
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY product_name
HAVING SUM(quantity) > 1;



--Query 23 Show all customers and their orders. Include customers even if they have no orders.
SELECT 
    customers.customer_id,
    customers.customer_name,
    orders.order_id,
    orders.order_date,
    orders.status
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;


--Query 24 Show all products and how many times each product appears in order_items. Include products that were never sold.

SELECT
    products.product_id,
    products.product_name,
    COUNT(order_items.product_id) AS times_sold
FROM products
LEFT JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY 
    products.product_id,
    products.product_name;