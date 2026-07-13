
--Query 1 Create a report for completed revenue by order_date.
SELECT 
    order_date,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
INNER JOIN products
    ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY order_date
ORDER BY order_date;    



--Query 2  Create a report for average completed order value by category.

SELECT 
    products.category,
    AVG(orders.quantity * products.price) AS average_completed_order_value
FROM orders
INNER JOIN products
    ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY average_completed_order_value DESC;


--Query 3 Create a report that shows each product with total_orders, completed_orders, completed_quantity, andcompleted_revenue.

SELECT
    products.product_name,

    COUNT(orders.order_id) AS total_orders,

    SUM(
        CASE 
            WHEN orders.status = 'completed' THEN 1
            ELSE 0
        END
    ) AS completed_orders,

    SUM(
        CASE 
            WHEN orders.status = 'completed' THEN orders.quantity
            ELSE 0
        END
    ) AS completed_quantity,

    SUM(
        CASE 
            WHEN orders.status = 'completed' 
            THEN orders.quantity * products.price
            ELSE 0
        END
    ) AS completed_revenue

FROM products
LEFT JOIN orders
    ON products.product_id = orders.product_id
GROUP BY products.product_name
ORDER BY completed_revenue DESC;


--Query 4 Create a report that shows each city with total_orders, completed_orders, pending_or_cancelled_orders, and completed_revenue.


SELECT
    customers.city,

    COUNT(orders.order_id) AS total_orders,

    SUM(
        CASE 
            WHEN orders.status = 'completed' THEN 1
            ELSE 0
        END
    ) AS completed_orders,

    SUM(
        CASE 
            WHEN orders.status IN ('pending','cancelled') THEN 1
            ELSE 0
        END
    ) AS pending_or_cancelled_orders,

    SUM(
        CASE 
            WHEN orders.status = 'completed'
            THEN orders.quantity * products.price
            ELSE 0
        END
    ) AS completed_revenue

FROM customers

INNER JOIN orders
    ON customers.customer_id = orders.customer_id

INNER JOIN products
    ON orders.product_id = products.product_id

GROUP BY customers.city
ORDER BY completed_revenue DESC;



--Query 5  Add two new orders and check whether your reports update correctly.

INSERT INTO orders
(customer_id, product_id, order_date, quantity, status)
VALUES
(5, 101, '2026-07-08', 2, 'completed'),
(3, 106, '2026-07-08', 1, 'pending');