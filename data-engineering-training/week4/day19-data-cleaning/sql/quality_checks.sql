-- quality_checks.sql
-- Post-load SQL checks that verify the Gold database is internally consistent.
-- Run these after loading to confirm data integrity before reporting.

-- 1. Row counts per table
SELECT 'customers'   AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products',   COUNT(*) FROM products
UNION ALL
SELECT 'orders',     COUNT(*) FROM orders
UNION ALL
SELECT 'order_items',COUNT(*) FROM order_items
UNION ALL
SELECT 'payments',   COUNT(*) FROM payments;

-- 2. Check for any NULL values in required customer fields
SELECT customer_id, full_name, email, country, created_at, status
FROM customers
WHERE customer_id IS NULL
   OR full_name   IS NULL
   OR email       IS NULL
   OR country     IS NULL
   OR created_at  IS NULL
   OR status      IS NULL;

-- 3. Check for any orders referencing a customer not in the customers table
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 4. Check for any order_items referencing an order not in the orders table
SELECT oi.order_item_id, oi.order_id
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 5. Check for any order_items referencing a product not in the products table
SELECT oi.order_item_id, oi.product_id
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 6. Check for any payments referencing an order not in the orders table
SELECT p.payment_id, p.order_id
FROM payments p
LEFT JOIN orders o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 7. Verify line_total matches quantity * unit_price - discount_amount
SELECT order_item_id, quantity, unit_price, discount_amount, line_total,
       ROUND(quantity * unit_price - discount_amount, 2) AS expected_total
FROM order_items
WHERE ABS(line_total - ROUND(quantity * unit_price - discount_amount, 2)) > 0.01;

-- 8. Check for duplicate emails in customers
SELECT email, COUNT(*) AS count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- 9. Check for negative or zero prices in products
SELECT product_id, product_name, price
FROM products
WHERE price <= 0;

-- 10. Check for negative stock quantities
SELECT product_id, stock_quantity
FROM products
WHERE stock_quantity < 0;
