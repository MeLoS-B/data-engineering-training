# Day 6 - SQL Business Reporting Sprint

## Goal of the Practice

The goal of this practice was to learn how SQL can be used for business reporting and decision-making. I worked with customers, products, and orders data to create reports that show revenue, sales performance, customer behavior, and business insights.

The focus was not only writing SQL syntax, but understanding how query results can answer real business questions.

---

## Files Included

* `database_setup.sql` - Creates the database tables and inserts sample data.
* `join_reports.sql` - Contains business reports using JOIN operations between tables.
* `customer_reports.sql` - Contains customer-focused reports and analysis.
* `business_report.md` - Contains the business meaning and conclusions from the SQL results.
* `query_explanations.md` - Explains important SQL queries and why each part is needed.
* `README.md` - Documentation for the project.

---

## How to Run SQL Files

Run the SQL files in this order:

1. Open `database_setup.sql`

   * Create the tables.
   * Insert customers, products, and orders data.

2. Run `join_reports.sql`

   * Execute reports that require data from multiple tables.

3. Run `customer_reports.sql`

   * Execute customer and city analysis queries.

4. Review:

   * `business_report.md`
   * `query_explanations.md`

The correct order is important because reports depend on the tables and data created in the setup file.

---

## Tool Used

This SQL practice was completed using:

**SQLiteOnline.com**

SQLiteOnline was used to create tables, insert data, execute SQL queries, and analyze the results.

---

## SQL Concepts Explained

### Basic Aggregation

Basic aggregation uses functions like:

* `COUNT()` - counts rows
* `SUM()` - adds values together
* `AVG()` - calculates averages
* `MAX()` - finds the highest value

It is used when we want a single summary result from data.

Example:

```sql
SELECT SUM(quantity) FROM orders;
```

This calculates the total quantity from all orders.

---

### GROUP BY

`GROUP BY` is used when we want separate calculations for different groups.

Example:

```sql
SELECT city, COUNT(*)
FROM customers
GROUP BY city;
```

This gives the number of customers in each city instead of one total number.

---

### HAVING

`HAVING` filters grouped results after `GROUP BY` has been applied.

Example:

```sql
SELECT customer_id, COUNT(*)
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

It shows only customers who have more than one order.

`WHERE` filters rows before grouping, while `HAVING` filters groups after calculations.

---

### JOIN

`JOIN` combines data from multiple tables using a relationship between columns.

Example:

* Orders table contains `customer_id`
* Customers table contains `customer_name` and `city`

A JOIN allows us to combine this information and create a complete business report.

Without JOIN, we cannot access related information stored in different tables.

---

## Most Important Business Insight

The biggest insight from this report is that **Electronics products generated the highest completed revenue**, especially laptops and monitors.

The business should focus on products with high revenue potential while monitoring pending and cancelled orders because they can affect expected income.

The report also shows which customers and cities contribute the most sales, helping managers make better decisions about marketing, inventory, and customer strategies.
    