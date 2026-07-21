
INSERT INTO customers (customer_name, city, segment)
VALUES
('Arta', 'Vushtrri', 'Retail'),
('Blend', 'Prishtina', 'Corporate'),
('Dren', 'Mitrovica', 'Retail'),
('Elira', 'Peja', 'Small Business'),
('Leart', 'Ferizaj', 'Corporate'),
('Gresa', 'Gjakova', 'Retail');



INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 1200.00),
('Mouse', 'Accessories', 25.00),
('Monitor', 'Electronics', 280.00),
('Keyboard', 'Accessories', 55.00),
('Desk', 'Furniture', 180.00),
('Headphones', 'Accessories', 90.00);



INSERT INTO orders (customer_id, order_date, status, channel)
VALUES
(1, '2026-07-01', 'Completed', 'Online'),
(2, '2026-07-02', 'Completed', 'Store'),
(3, '2026-07-03', 'Pending', 'Online'),
(1, '2026-07-04', 'Completed', 'Mobile'),
(4, '2026-07-05', 'Cancelled', 'Store'),
(5, '2026-07-06', 'Completed', 'Online'),
(6, '2026-07-07', 'Completed', 'Mobile'),
(2, '2026-07-08', 'Completed', 'Store');



INSERT INTO order_items (order_id, product_id, quantity)
VALUES

(1, 1, 1),
(1, 2, 2),


(2, 3, 1),


(3, 2, 1),
(3, 4, 1),


(4, 1, 1),
(4, 6, 2),


(5, 5, 1),


(6, 3, 2),
(6, 2, 1),


(7, 4, 1),


(8, 6, 1);
