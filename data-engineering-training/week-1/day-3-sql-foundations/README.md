

Part 2 - Table understanding checkpoint
Before writing many queries, write short answers in your README.md. This is important because SQL becomes
easier when you understand the table structure.
● What is the table name?
● What does one row represent?
● Which columns are text?
● Which columns are numbers?
● Which column shows the order status?
● Which column can be used to calculate order value?
● What does quantity * price mean in this table?


Answers
● orders
● one customers orders
● customer,product,status
● order_id,quantity,price
● status
● quantity and price
● it gives the total value of that order/item   




# Day 3 SQL Foundations Practice

This folder contains SQL practice completed during the Unity Tech Hub x Agilyti Data Engineering / Databricks training.

## Files:
- `setup.sql` - Creates and inserts data into the orders table.
- `sql_practice.sql` - Contains SQL practice queries and explanations.
- `custom_business_table.sql` - Custom school payment table and business queries.
- `pipeline_thinking.md` - Explains the data pipeline flow for the chosen business.
- `daily_report.txt` - Short end-of-day learning report.

## Tools used:
- SQLite
- VS Code
- SQLite extension

## What I practiced:
- CREATE TABLE
- INSERT INTO
- SELECT
- WHERE filtering
- AND / OR conditions
- ORDER BY sorting
- LIMIT results
- Calculated columns
- Aggregate functions (COUNT, SUM, AVG)
- GROUP BY business reports

## Custom Business:
The custom business is an online learning school payment system.
The database stores student payments, courses, payment status, bonuses, and payment dates.

## Business Analysis Examples:
- Finding total revenue by course.
- Checking paid and pending payments.
- Calculating average payments per course.