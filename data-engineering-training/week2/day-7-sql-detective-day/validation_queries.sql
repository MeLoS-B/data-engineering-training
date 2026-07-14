


--Task 1 Count all orders.
SELECT COUNT(*) as total_orders FROM orders;

--Task 2 Count completed orders.
SELECT COUNT(*) as total_orders FROM orders
WHERE status = 'completed';


--Task 3 Count pending orders.
SELECT COUNT(*) as total_orders FROM orders
WHERE status = 'pending';

--Task 4 Count cancelled orders.

SELECT COUNT(*) as total_orders FROM orders
WHERE status = 'cancelled';


--Task 5 Count all customers.
SELECT COUNT(*) as total_customers FROM customers;


--Task 6 Count all products.
]SELECT COUNT(*) as total_products FROM products;

--Task 7 Calculate completed revenue only. Pending and cancelled orders must not be included.
SELECT SUM(quantity * price) as revenue FROM orders INNER JOIN products ON orders.product_id = products.product_id
WHERE status = 'completed';

--Task 8 Calculate completed revenue by product_name.

SELECT SUM(quantity * price) as revenue,products.product_name as revenue FROM orders INNER JOIN products ON orders.product_id = products.product_id
WHERE status = 'completed'
GROUP BY products.product_name;


--Task 9 Calculate completed revenue by category.

SELECT SUM(quantity * price) as revenue,products.category as revenue FROM orders INNER JOIN products ON orders.product_id = products.product_id
WHERE status = 'completed'
GROUP BY products.category;



--Task 10 Count orders by city.

SELECT COUNT(*) as count_orders,city FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY city;


--Task 11 Find customers with more than one order.

SELECT COUNT(*) AS total_count_customer,customers.customer_name FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_name
HAVING total_count_customer > 1;

--Task 12 Find the top 3 completed orders by total_amount.

SELECT products.price * orders.quantity as total_amount,products.product_name FROM orders 
INNER JOIN products ON orders.product_id = products.product_id
ORDER BY total_amount DESC
LIMIT 3;


--Task 13 Find orders that should not count as real revenue.
SELECT * FROM orders 
WHERE status != 'completed';


--Task 14 Find which category has the highest completed revenue.
SELECT SUM(orders.quantity * products.price) as total_revenue,products.category FROM orders INNER JOIN products
ON orders.product_id = products.product_id
GROUP BY products.category;


--Task 15 Find which city has the highest order activity.

SELECT COUNT(*) as count_activity,city FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY city
ORDER BY count_activity DESC
LIMIT 1;