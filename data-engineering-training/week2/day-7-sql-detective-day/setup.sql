DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;


CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

INSERT INTO customers (customer_name, city) VALUES
('Arta', 'Vushtrri'),
('Blend', 'Prishtina'),
('Dren', 'Mitrovica'),
('Elira', 'Prishtina'),
('Nora', 'Vushtrri'),
('Leart', 'Peja'),
('Faton', 'Prizren'),
('Rina', 'Vushtrri'),
('Arben', 'Ferizaj'),
('Gresa', 'Prishtina');


CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


INSERT INTO products (product_id, product_name, category, price) VALUES
(101, 'Laptop', 'Electronics', 700.00),
(102, 'Mouse', 'Accessories', 15.00),
(103, 'Keyboard', 'Accessories', 40.00),
(104, 'Monitor', 'Electronics', 180.00),
(105, 'Headphones', 'Accessories', 50.00),
(106, 'Desk Chair', 'Office', 120.00),
(107, 'USB Cable', 'Accessories', 8.00),
(108, 'Desk', 'Office', 220.00);


CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO orders (
    customer_id,
    product_id,
    order_date,
    quantity,
    status
) VALUES
(1, 101, '2026-07-01', 1, 'completed'),
(2, 102, '2026-07-01', 2, 'completed'),
(1, 103, '2026-07-02', 1, 'cancelled'),
(3, 104, '2026-07-02', 1, 'completed'),
(4, 102, '2026-07-03', 1, 'completed'),
(3, 101, '2026-07-03', 1, 'pending'),
(5, 105, '2026-07-04', 1, 'completed'),
(6, 104, '2026-07-04', 2, 'completed'),
(7, 106, '2026-07-05', 1, 'completed'),
(2, 107, '2026-07-05', 3, 'completed'),
(8, 101, '2026-07-06', 1, 'cancelled'),
(9, 108, '2026-07-06', 1, 'pending'),
(10, 102, '2026-07-07', 4, 'completed'),
(4, 105, '2026-07-07', 2, 'completed');