-- Enable foreign keys enforcement at connection level
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    city TEXT,
    country TEXT NOT NULL,
    created_at TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('active', 'inactive'))
);

CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL CHECK (price > 0),
    currency TEXT NOT NULL CHECK (currency IN ('EUR', 'USD')),
    stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0),
    supplier_id TEXT,
    status TEXT NOT NULL CHECK (status IN ('active', 'inactive'))
);

CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    order_date TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('new', 'processing', 'shipped', 'delivered', 'cancelled', 'completed')),
    shipping_city TEXT,
    shipping_country TEXT,
    payment_method TEXT CHECK (payment_method IN ('card', 'bank_transfer', 'cash', 'paypal', '')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price REAL NOT NULL CHECK (unit_price > 0),
    discount_amount REAL NOT NULL DEFAULT 0.0 CHECK (discount_amount >= 0.0 AND discount_amount <= (quantity * unit_price)),
    line_total REAL NOT NULL CHECK (line_total >= 0.0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    payment_date TEXT NOT NULL,
    amount REAL NOT NULL CHECK (amount > 0),
    currency TEXT NOT NULL CHECK (currency IN ('EUR', 'USD')),
    payment_method TEXT NOT NULL CHECK (payment_method IN ('card', 'bank_transfer', 'cash', 'paypal')),
    status TEXT NOT NULL CHECK (status IN ('paid', 'pending', 'failed', 'refunded')),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
