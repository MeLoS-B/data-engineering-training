


--Query 1 Show all clean orders.

SELECT * FROM clean_orders;


--Query 2 Calculate completed revenue.
SELECT 
    SUM(quantity * price) AS completed_revenue
FROM clean_orders
WHERE status = 'completed';


--Query 3 Count orders by status.

SELECT 
    status,
    COUNT(*) AS count_orders
FROM clean_orders
GROUP BY status;


--Query 4 Count orders by city.

SELECT
    city,
    COUNT(*) AS count_orders
FROM clean_orders
GROUP BY city;

--Query 5 Calculate completed revenue by city.


SELECT
    city,
    SUM(quantity * price) AS total_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY city;

--Query 6 Calculate completed revenue by category.

SELECT
    category,
    SUM(quantity * price) AS total_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY category;


--Query 7 Show top 5 orders by total_amount.

SELECT
    order_id,
    customer_name,
    product_name,
    quantity,
    price,
    total_amount
FROM clean_orders
ORDER BY total_amount DESC
LIMIT 5;


--Query 8 Show top customers by completed revenue.

SELECT
    customer_name,
    SUM(quantity * price) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY customer_name
ORDER BY completed_revenue DESC
LIMIT 5;


--Query 9 Count orders by channel.


SELECT
    channel,
    COUNT(*) AS count_orders
FROM clean_orders
GROUP BY channel;


--Query 10 Find the city with the highest completed revenue.


SELECT
    city,
    SUM(quantity * price) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY city
ORDER BY completed_revenue DESC
LIMIT 1;