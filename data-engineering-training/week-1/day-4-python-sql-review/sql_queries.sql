

-- Task S1 - Read and select columns


--Query 1 Show all orders.

SELECT * FROM orders

--Query 2 Show only customer_name and product.

SELECT customer_name,product FROM orders

--Query 3 Show order_id, customer_name, city, and status.

SELECT order_id,customer_name,city,status FROM orders


--Query 4 Show product, category, quantity, and price.

SELECT product,category,quantity,price FROM orders


--Task S2 - Filter rows with WHERE

--Query 5 Show only completed orders.

SELECT * FROM orders
WHERE status = 'completed'


--Query 6 Show only pending orders.

SELECT * FROM orders
WHERE status = 'pending'


--Query 7 Show only cancelled orders.

SELECT * FROM orders
WHERE status = 'cancelled'


--Query 8 Show orders where price is greater than 100.


SELECT * FROM orders
WHERE price > 100



--Query 9 Show orders from Vushtrri.


SELECT * FROM orders
WHERE city = 'Vushtrri'


--Query 10 Show orders where category is Accessories.

SELECT * FROM orders
WHERE category = 'Accessories'



--Task S3 - Combine filters

--Query 11 Show completed orders where price is greater than 100.

SELECT * FROM orders 
WHERE status = 'completed' AND price > 100



--Query 12 Show completed orders from Prishtina.

SELECT * FROM orders 
WHERE status = 'completed' AND city = 'Prishtina'


--Query 13 Show orders where status is pending OR cancelled.

SELECT * FROM orders 
WHERE status = 'pending' OR status = 'cancelled'



--Query 14 Show Accessories orders where price is less than 50.


SELECT * FROM orders 
WHERE category = 'Accessories' AND price < 50


--Task S4 - Sorting and limiting


--Query 15 Show orders from cheapest to most expensive.

SELECT * FROM orders
ORDER BY price ASC



--Query 16 Show orders from most expensive to cheapest.

SELECT * FROM orders
ORDER BY price DESC


--Query 17 Show top 3 most expensive orders by price.

SELECT * FROM orders
ORDER BY price DESC
LIMIT 3


--Query 18 Show top 3 orders by total_amount.

SELECT *,quantity * price AS total_amount FROM orders
ORDER BY total_amount DESC
LIMIT 3;



--Task S5 - Calculated columns


--Query 19 Show customer_name, product, quantity, price, and total_amount.

SELECT customer_name,product,quantity,price,quantity * price AS total_amount FROM orders;


--Query 20 Show only completed orders with total_amount.

SELECT quantity * price as total_amount FROM orders
WHERE status = 'completed';


--Query 21 Show completed orders with total_amount sorted from highest to lowest.

SELECT quantity * price as total_amount FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;






-- mini bussiness challenge

SELECT 
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 1;






SELECT 
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 1;



SELECT *
FROM orders
WHERE status = 'pending'
OR status = 'cancelled';



SELECT 
    SUM(quantity * price) AS completed_revenue
FROM orders
WHERE status = 'completed';




-- # Business Analysis

-- ## Most valuable order

-- The most valuable order is the order with the highest total_amount because it represents the biggest single contribution to revenue.

-- ## Why cancelled orders are not revenue

-- Cancelled orders should not be counted as revenue because the company does not receive money from cancelled purchases. Including them would give an inaccurate view of business performance.