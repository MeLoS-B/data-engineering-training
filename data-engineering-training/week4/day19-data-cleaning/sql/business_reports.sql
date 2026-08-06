-- 1. Revenue by Customer
-- Sums line_total for non-cancelled orders grouped by customer
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    ROUND(SUM(oi.line_total), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.full_name, c.email
ORDER BY total_revenue DESC;

-- 2. Revenue by City
-- Sums line_total for non-cancelled orders grouped by shipping city
SELECT 
    COALESCE(o.shipping_city, 'Unknown') AS shipping_city,
    ROUND(SUM(oi.line_total), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY o.shipping_city
ORDER BY total_revenue DESC;

-- 3. Revenue by Product Category
-- Sums line_total for non-cancelled orders grouped by product category
SELECT 
    p.category,
    ROUND(SUM(oi.line_total), 2) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'cancelled'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 4. Top Products by Units and Revenue
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.line_total), 2) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'cancelled'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;

-- 5. Top Customers by Order Count and Revenue
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.line_total), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_revenue DESC;

-- 6. Active Products Never Sold
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.status
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL AND p.status = 'active'
ORDER BY p.product_id;

-- 7. Customers Without Orders
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    c.country
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;

-- 8. Orders Without Payments
-- Orders that have no associated payments in payments table
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL
ORDER BY o.order_id;
