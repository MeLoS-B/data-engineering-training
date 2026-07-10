











--Show all orders
SELECT * FROM orders;

--Show only completed orders
SELECT *
FROM orders
WHERE status = 'completed';

--Show pending or cancelled orders
SELECT *
FROM orders
WHERE status = 'pending'
OR status = 'cancelled';

--Show total_amount as quantity * price
SELECT
customer_name,
product,
quantity, 
price,
quantity * price AS total_amount
FROM orders;

--Show completed orders with total_amount
SELECT
customer_name,
product,
status,
quantity, 
price,
quantity * price AS total_amount
FROM orders
WHERE status = 'completed';

--Calculate completed revenue using SUM(quantity * price)
SELECT 
    SUM(price * quantity) AS completed_revenue
FROM orders
WHERE status = 'completed';

--Count orders by status using COUNT(*) and GROUP BY status
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

--Count orders by city using COUNT(*) and GROUP BY city
SELECT city, COUNT(*) AS total_orders
FROM orders
GROUP BY city;

--Count orders by category using COUNT(*) and GROUP BY category
SELECT category, COUNT(*) AS total_orders
FROM orders
GROUP BY category;

--Show top 3 orders by total_amount
SELECT
customer_name,
product,
quantity * price AS total_amount
FROM orders 
ORDER BY total_amount DESC
LIMIT 3;

--Find the most valuable order
SELECT
customer_name,
product,
status,
quantity,
price,
quantity * price AS total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 1;