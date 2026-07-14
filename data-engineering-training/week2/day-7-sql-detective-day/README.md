# Day 7 - SQL Detective Day

## Practice Goal

The goal of this practice was to improve my SQL debugging and data validation skills. I worked with a business database containing customers, products, and orders. I fixed broken SQL queries, checked data accuracy, created validation queries, and used SQL results to build a verified business report.

This practice helped me understand how SQL is used in real business situations, especially for checking revenue, customer activity, and order performance.

---

## Files Included

The project folder contains:

* `setup.sql` - Creates database tables and inserts sample data.
* `table_inspection.sql` - Checks table structures and understands available data.
* `fixed_queries.sql` - Contains corrected versions of broken SQL queries.
* `validation_queries.sql` - Contains SQL queries used to verify business numbers.
* `verified_business_report.md` - Business report created using verified SQL results.
* `query_explanations.md` - Explanation of fixed and validation queries.
* `daily_report.txt` - Summary of my Day 7 practice.

---

## How to Run SQL Files

Run the SQL files in this order:

1. `setup.sql`

   * Creates the database structure and inserts the required data.

2. `table_inspection.sql`

   * Reviews tables, columns, and relationships.

3. `fixed_queries.sql`

   * Runs the corrected SQL queries after debugging mistakes.

4. `validation_queries.sql`

   * Checks that business calculations and results are correct.

5. Review:

   * `verified_business_report.md`
   * This report contains the final business insights based on verified SQL results.

---

## What I Learned About Debugging SQL

During this practice, I learned how to identify and fix common SQL problems such as:

* Using the wrong table name.
* Missing JOIN conditions.
* Incorrect filtering conditions.
* Missing commas or incorrect SQL syntax.
* Using GROUP BY incorrectly.
* Understanding when JOINs are required between tables.

I also learned that debugging SQL is not only about making queries run, but also making sure the results are logically correct.

---

## What I Learned About Verifying Business Reports

I learned that business reports should always be supported by SQL evidence.

Before creating a report, I need to verify:

* Total number of orders.
* Completed orders only.
* Real revenue excluding pending and cancelled orders.
* Revenue by product and category.
* Customer and city performance.

SQL validation helps prevent incorrect business decisions based on inaccurate data.
