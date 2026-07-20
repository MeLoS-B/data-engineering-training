DROP TABLE IF EXISTS clean_orders;

CREATE TABLE clean_orders (
    order_id INTEGER,
    customer_name TEXT,
    city TEXT,
    segment TEXT,
    product_name TEXT,
    category TEXT,
    quantity INTEGER,
    price REAL,
    status TEXT,
    channel TEXT,
    total_amount REAL
);


INSERT INTO clean_orders (
    order_id,
    customer_name,
    city,
    segment,
    product_name,
    category,
    quantity,
    price,
    status,
    channel
   
)
VALUES
(1,'Arta','Vushtrri','Individual','Laptop','Electronics',1,700,'completed','online'),

(2,'Blend','Prishtina','Individual','Mouse','Accessories',2,15,'completed','store'),

(3,'Dren','Mitrovica','Business','Monitor','Electronics',NULL,180,'completed','online'),

(4,'Elira','Vushtrri','Individual','Keyboard','Accessories',1,40,'cancelled','store'),

(5,'Arta','Vushtrri','Individual','Mouse','Accessories',3,15,'completed','online'),

(8,'Gresa','Prishtina','Business','Mouse','Accessories',2,15,NULL,'online'),

(9,'Nora','Ferizaj','Individual','USB Cable','Accessories',1,8,'completed','store'),

(10,'Jon','Prishtina','Business','Headphones','Accessories',4,50,'pending','store'),

(11,'Era','Vushtrri','Individual','Laptop','Electronics',1,700,'completed','online'),

(12,'Noar','Gjilan','Individual','Webcam','Electronics',2,90,'completed','bank'),

(13,'Sara','Peja','Business','Notebook','Office',1,5,'cancelled','online'),

(14,'Blend','Prishtina','Individual','Monitor','Electronics',2,180,'returned','online'),

(15,'Elira','Vushtrri','Individual','Keyboard','Accessories',5,40,'completed','store'),

(16,'Gresa','Prishtina','Business','Mouse','Accessories',2,15,'completed','online'),

(18,'Leart','Peja','Business','Desk','Office',1,220,'completed',NULL),

(19,'Faton','Prizren','Individual','Chair','Office',3,120,'pending','web'),

(20,'Gresa','Prishtina','Business','USB Cable','Accessories',2,8,'completed','online'),

(21,'Nora','Ferizaj','Individual','Headphones','Accessories',1,50,'completed','store'),

(23,'Jon','Prishtina','Business','Notebook','Office',2,5,'completed','online'),

(24,'Noar','Gjilan','Individual','Laptop','Electronics',1,700,'completed','store');