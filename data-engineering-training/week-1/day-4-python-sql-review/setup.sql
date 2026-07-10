

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    city TEXT NOT NULL,
    product TEXT NOT NULL,
    category TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    price REAL NOT NULL,
    status TEXT NOT NULL,
    order_date TEXT NOT NULL
);



INSERT INTO orders 
(order_id, customer_name, city, product, category, quantity, price, status, order_date)
VALUES

(1, 'Arta', 'Vushtrri', 'Laptop', 'Electronics', 1, 700, 'completed', '2026-07-01'),

(2, 'Blend', 'Prishtina', 'Wireless Mouse', 'Accessories', 2, 25, 'completed', '2026-07-01'),

(3, 'Dren', 'Mitrovica', 'Keyboard', 'Accessories', 1, 45, 'cancelled', '2026-07-02'),

(4, 'Era', 'Peja', 'Monitor', 'Electronics', 1, 250, 'completed', '2026-07-03'),

(5, 'Luan', 'Prizren', 'Printer', 'Office', 1, 180, 'pending', '2026-07-03'),

(6, 'Sara', 'Gjilan', 'USB Cable', 'Accessories', 3, 10, 'completed', '2026-07-04'),

(7, 'Besa', 'Prishtina', 'Desk Chair', 'Office', 1, 120, 'pending', '2026-07-05'),

(8, 'Klevis', 'Vushtrri', 'Tablet', 'Electronics', 1, 350, 'completed', '2026-07-06'),

(9, 'Arben', 'Peja', 'Notebook', 'Office', 5, 6, 'cancelled', '2026-07-06'),

(10, 'Lea', 'Prizren', 'Headphones', 'Electronics', 1, 90, 'completed', '2026-07-07'),

(11, 'Valon', 'Mitrovica', 'Keyboard Cover', 'Accessories', 2, 15, 'pending', '2026-07-08'),

(12, 'Diona', 'Gjilan', 'Office Lamp', 'Office', 1, 35, 'completed', '2026-07-09');



SELECT * FROM orders;