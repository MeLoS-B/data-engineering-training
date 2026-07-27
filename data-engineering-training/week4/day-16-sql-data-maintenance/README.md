# Student Management Database – README

## Project Goal

The goal of this project is to practice **data maintenance** using MySQL. Data maintenance means keeping data accurate, complete, and up to date by inserting new records, updating existing information, deleting unnecessary records safely, handling missing values, and creating reports from the stored data.

---

## Setup

I created the following tables for the project:

* **students** – stores student information.
* **programs** – stores available study programs.
* **instructors** – stores instructor information.
* **courses** – stores course details.
* **enrollments** – connects students with courses.
* **attendance** – stores attendance records.
* **assignments** – stores assignment information.
* **submissions** – stores assignment submissions.
* **payments** – stores student payment information.

The tables are connected using **primary keys** and **foreign keys** to maintain data integrity.

---

## Safe Updates

A `WHERE` clause is required in an `UPDATE` statement because it specifies which rows should be modified. Without a `WHERE` clause, every row in the table would be updated, which could accidentally change all of the data. Using `WHERE` makes updates safe and targeted.

---

## Delete Logic

A **hard delete** permanently removes a record from the database using the `DELETE` statement. Once deleted, the data cannot be recovered unless a backup exists.

A **soft delete** keeps the record in the database but marks it as deleted, usually by changing a status column such as `active` to `deleted` or `inactive`. Soft deletes are safer because they prevent accidental data loss, preserve historical information, and allow records to be restored if necessary.

---

## NULL Handling

`IS NULL` is used to find rows where a column has no value stored. It helps identify missing or incomplete information.

`COALESCE()` replaces `NULL` values with a default value. For example, if a student's notes are `NULL`, `COALESCE(notes, 'No notes yet')` displays `"No notes yet"` instead of `NULL`, making reports easier to read.

---

## CASE WHEN

`CASE WHEN` is used to classify data based on business rules. For example, attendance records can be grouped into categories such as:

* **Excellent** – attendance is very high.
* **Good** – attendance is acceptable.
* **Needs Improvement** – attendance is below expectations.

This allows data to be grouped into meaningful categories for reporting and analysis.

---

## LEFT JOIN

A `LEFT JOIN` returns all records from the left table, even if there is no matching record in the right table.

I used a `LEFT JOIN` between the **students** table and the **submissions** table to find students who did not submit an assignment. Students without a matching submission have `NULL` values in the submission columns, making them easy to identify using `WHERE submission_id IS NULL`.

---

## What I Can Explain Live

I can explain:

* How primary keys and foreign keys connect tables.
* The difference between `INNER JOIN` and `LEFT JOIN`.
* Why `WHERE` is important in `UPDATE` and `DELETE` statements.
* The difference between hard delete and soft delete.
* How `IS NULL` and `COALESCE()` handle missing data.
* How `CASE WHEN` is used to classify data.
* How `GROUP BY` and aggregate functions create reports.
* How foreign key constraints protect related data.
* Why normalization reduces duplicate data.
* How SQL queries can answer real business questions using joins, filtering, and aggregation.
