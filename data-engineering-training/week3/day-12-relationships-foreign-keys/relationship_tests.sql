

INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(14, '2026-07-01', 'completed', 'Online');


INSERT INTO order_items (order_id, product_id, quantity)
VALUES

(120, 1, 1),


INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 120, 1);



INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', -20);


INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 120, 0);



INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(1, '2026-07-01', 'done', 'Online'),