
-- Query 1: Show all orders
SELECT * FROM orders;

-- Query 2: Show only customer_name and product.
SELECT customer_name,product FROM orders;

-- Query 3:Show only order_id, product, and status.
SELECT order_id,product,status FROM orders;

--Query 4:Show customer_name as customer and product as item using aliases.
SELECT customer_name AS customer , product AS item FROM orders;


--Query 5:Show product, quantity, and price only.
SELECT product,quantity,price FROM orders;

--Query 6:Show order_id and customer_name only.
SELECT order_id,customer_name FROM orders;


--Query 7:Show only completed orders.
SELECT * FROM orders
WHERE status = 'completed'

-- Explanation:
-- This query displays only the orders that have a completed status.
-- It filters the table to show finished orders and removes pending or cancelled orders from the results.

--Query 8:Show only pending orders.
SELECT * FROM orders
WHERE status = 'pending'

--Query 9:Show only cancelled orders.
SELECT * FROM orders
WHERE status = 'cancelled'


--Query 10:Show orders where price is greater than 100.
SELECT * FROM orders
WHERE price > 100;


--Query 11:Show orders where price is less than 100.
SELECT * FROM orders
WHERE price < 100;


--Query 12:Show orders where price is greater than or equal to 180.
SELECT * FROM orders
WHERE price >= 180;


--Query 13:Show orders where status is not cancelled.
SELECT * FROM orders
WHERE status != 'cancelled'


--Query 14:Show orders where customer_name is Arta.
SELECT * FROM orders
WHERE customer_name = 'Arta'


--Query 15:Show orders where product is Mouse.
SELECT * FROM orders
WHERE product = 'Mouse'


--Query 16:Show completed orders where price is greater than 50.
SELECT * FROM orders
WHERE status = 'completed' AND price > 50


--Query 17:Show completed orders where product is Mouse.
SELECT * FROM orders
WHERE status = 'completed' AND product = 'Mouse'

--Query 18:Show orders where status is pending OR status is cancelled.
SELECT * FROM orders
WHERE status = 'pending' OR staus = 'cancelled'


--Query 19:Show orders where customer_name is Dren AND status is completed.
SELECT * FROM orders
WHERE customer_name = 'Dren' AND status = 'completed'


--Query 20:Show orders where product is Laptop AND price is 700.
SELECT * FROM orders
WHERE product = 'Laptop' AND price = 700


--Query 21:Show orders where status is completed OR price is greater than 500.
SELECT * FROM orders
WHERE status = 'completed' OR price > 500

--Query 22:Show orders where status is not cancelled AND price is greater than 100.
SELECT * FROM orders
WHERE status != 'cancelled' AND  price > 100


--Query 23:Show all orders from cheapest to most expensive.

SELECT * FROM orders
ORDER BY price ASC;


--Query 24:Show all orders from most expensive to cheapest.
SELECT * FROM orders
ORDER BY price DESC;


--Query 25:Show the top 3 most expensive orders.
SELECT * FROM orders
ORDER BY price DESC
LIMIT 3;

-- Explanation:
-- This query sorts all orders from the highest price to the lowest price.
-- It uses LIMIT 3 to show only the three most expensive orders in the table.

--Query 26:Show the cheapest 2 orders.
SELECT * FROM orders
ORDER BY price ASC
LIMIT 2;

--Query 27:Show completed orders from highest price to lowest price.
SELECT * FROM orders
WHERE status = 'completed'
ORDER BY price DESC;


--Query 28:Show products sorted alphabetically by product name.
SELECT * FROM orders
ORDER BY product ASC;


--Query 29:Show customers sorted alphabetically by customer_name.
SELECT * FROM orders
ORDER BY customer_name ASC;



--Query 30:Show customer_name, product, quantity, price, and total_amount.
SELECT customer_name,
product,
quantity,
price,
quantity * price AS total_amount
FROM orders;

-- Explanation:
-- This query selects important order details and calculates the total amount for each order.
-- The total_amount is calculated by multiplying quantity with price, which shows the total value of each order.

--Query 31:Show only completed orders with total_amount.

SELECT customer_name,
product,
quantity,
price,
quantity * price AS total_amount
FROM orders
WHERE status = 'completed';

-- Explanation:
-- This query shows only completed orders and calculates their total_amount.
-- It helps analyze the revenue from orders that have already been finished.

--Query 32:Show completed orders with total_amount sorted from highest to lowest.

SELECT *,
quantity * price AS total_amount
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;

--Query 33:Show cancelled or pending orders with total_amount.

SELECT *,
quantity * price AS total_amount
FROM orders
WHERE status = 'cancelled' 
OR status = 'pending';



--Query 34:Show customer_name as customer, product as item, and quantity * price as total_amount.
SELECT 
customer_name AS customer,
product AS item,
quantity * price AS total_amount
FROM orders;

--Query 35:Show the top 3 orders by total_amount.


SELECT *,quantity * price AS total_amount FROM orders
ORDER BY total_amount DESC
LIMIT 3;
-- Explanation:
-- This query calculates the total amount for every order and sorts them from highest to lowest value.
-- It returns the three orders that generated the highest total amount.

--Query 36:Show only orders where total_amount is greater than 100. Hint: repeat the calculation in WHERE or filter by price/quantity if needed.


SELECT *,quantity * price AS total_amount FROM orders
WHERE total_amount > 100;







-- Custom business table challenge

CREATE TABLE school (
     payment_id INT,
     student_name VARCHAR(100),
     course VARCHAR(100),
     amount DECIMAL(10,2),
     status VARCHAR(100),
     bonus DECIMAL(5,2),
     payment_date DATE DEFAULT (CURRENT_DATE())
);


INSERT INTO school (payment_id, student_name, course, amount, status,bonus, payment_date)
VALUES
(1, 'Arta', 'Python', 250.00, 'Paid',20, '2026-07-01'),
(2, 'Dren', 'SQL', 180.00, 'Paid',40, '2026-07-02'),
(3, 'Lira', 'Web Development', 300.00, 'Pending',60, '2026-07-03'),
(4, 'Blerim', 'Data Science', 450.00, 'Paid',90, '2026-07-04'),
(5, 'Era', 'JavaScript', 220.00, 'Cancelled',120, '2026-07-05'),
(6, 'Klea', 'React', 350.00, 'Paid',240, '2026-07-06');




--Query 37:Show all rows from your custom table.
SELECT * FROM school;

--Query 38:Show only 2 or 3 selected columns.
SELECT student_name,course,status FROM school;


--Query 39:Filter rows by a text/status column.

SELECT * FROM school
WHERE status = 'Paid';


--Query 40:Filter rows by a numeric column using > or <.

SELECT * FROM school
WHERE amount > 300;


--Query 41:Combine two conditions using AND.

SELECT * FROM school
WHERE amount > 200 AND status = 'Paid';


--Query 42:Combine two conditions using OR.

SELECT * FROM school 
WHERE course = 'Python' OR course = 'SQL';


--Query 43:Sort rows from highest to lowest by a numeric column.

SELECT * FROM school
ORDER BY amount DESC;


--Query 44:Limit the result to the top 3 rows.

SELECT * FROM school
ORDER BY amount DESC
LIMIT 3;


--Query 45:Create one calculated column using two existing columns.

SELECT *, amount - bonus AS final_amount
FROM school;



-- Query 46: Show a business summary report by course.
SELECT 
    course,
    COUNT(student_name) AS total_students,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_payment
FROM school
WHERE status = 'Paid'
GROUP BY course
ORDER BY total_revenue DESC;







-- bonus tasks



--Create a second table for your custom business and explain how it could connect to the first table. Do not use JOIN yet unless you already understand it.
CREATE TABLE courses (
    course_id INT,
    course_name VARCHAR(100),
    instructor VARCHAR(100),
    duration_months INT
);

INSERT INTO courses (course_id, course_name, instructor, duration_months)
VALUES
(1, 'Python', 'Arben', 3),
(2, 'SQL', 'Elira', 2),
(3, 'Web Development', 'Besa', 6),
(4, 'Data Science', 'Driton', 5),
(5, 'JavaScript', 'Luan', 4),
(6, 'React', 'Sara', 3);




--Add more rows to the orders table and check if your queries still work correctly.

INSERT INTO orders 
(order_id, customer_name, product, quantity, price, status, total_amount)
VALUES
(7, 'Arta', 'Keyboard', 1, 50, 'completed', 50),
(8, 'Dren', 'Mouse', 2, 25, 'pending', 50),
(9, 'Lira', 'Monitor', 1, 200, 'completed', 200),
(10, 'Blerim', 'Laptop Stand', 1, 40, 'cancelled', 40);

SELECT * FROM orders;

SELECT *
FROM orders
WHERE status = 'completed';

SELECT *
FROM orders
ORDER BY total_amount DESC;




--Create a query that shows only business-ready completed orders with customer_name, product, total_amount,and status.

SELECT 
    customer_name,
    product,
    total_amount,
    status
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;



--Write 5 common mistakes you made today and how you fixed them.


1. Mistake: Using double quotes for text values in SQLite.
   Fix: Used single quotes for strings, for example status = 'Paid'.

2. Mistake: Putting INSERT values in the wrong column order.
   Fix: Checked the table columns before inserting data.

3. Mistake: Forgetting commas between selected columns.
   Fix: Reviewed SQL syntax carefully.

4. Mistake: Using wrong column names in queries.
   Fix: Checked the CREATE TABLE statement before writing queries.

5. Mistake: Creating queries without thinking about business needs.
   Fix: Practiced writing reports that answer real business questions.




--Prepare 3 questions for the instructor about SQL or Data Engineering.
1. What is the best database structure for large Data Engineering projects?

2. When should we use SQL JOINs instead of storing all information in one table?

3. How is SQL used inside real Data Engineering pipelines with tools like Databricks?