

CREATE TABLE customers (
   customer_id INT PRIMARY KEY AUTO_INCREMENT,
   customer_name VARCHAR(50) NOT NULL,
   city VARCHAR(50) NOT NULL,
   segment VARCHAR(50)
);

CREATE TABLE products (
	 product_id INT PRIMARY KEY AUTO_INCREMENT,
     product_name VARCHAR(100) NOT NULL,
     category VARCHAR(50),
     price DECIMAL(10,2),
     CONSTRAINT chk_price CHECK(price > 0)
     
);


CREATE TABLE orders (
     order_id INT PRIMARY KEY AUTO_INCREMENT,
     customer_id INT,
     order_date DATE DEFAULT (CURRENT_DATE()),
     status VARCHAR(20),
     channel VARCHAR(20),
     CONSTRAINT chk_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
     CONSTRAINT chk_status CHECK (status IN ("completed","pending","cancelled"))
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    CONSTRAINT chk_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT chk_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT chk_quantity CHECK(quantity > 0)
);

