-- insert_clean_data.sql
-- These are the INSERT statements that load Silver clean data into the Gold SQLite tables.
-- In the pipeline this is executed programmatically by sqlite_loader.py using parameterized queries.
-- This file documents the exact SQL shape used for each table.

-- Load customers first (no foreign key dependencies)
INSERT INTO customers (customer_id, full_name, email, city, country, created_at, status)
VALUES
    (:customer_id, :full_name, :email, :city, :country, :created_at, :status);

-- Load products (no foreign key dependencies)
INSERT INTO products (product_id, product_name, category, price, currency, stock_quantity, supplier_id, status)
VALUES
    (:product_id, :product_name, :category, :price, :currency, :stock_quantity, :supplier_id, :status);

-- Load orders after customers exist (references customers.customer_id)
INSERT INTO orders (order_id, customer_id, order_date, status, shipping_city, shipping_country, payment_method)
VALUES
    (:order_id, :customer_id, :order_date, :status, :shipping_city, :shipping_country, :payment_method);

-- Load order_items after orders and products exist
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_amount, line_total)
VALUES
    (:order_item_id, :order_id, :product_id, :quantity, :unit_price, :discount_amount, :line_total);

-- Load payments after orders exist (references orders.order_id)
INSERT INTO payments (payment_id, order_id, payment_date, amount, currency, payment_method, status)
VALUES
    (:payment_id, :order_id, :payment_date, :amount, :currency, :payment_method, :status);
