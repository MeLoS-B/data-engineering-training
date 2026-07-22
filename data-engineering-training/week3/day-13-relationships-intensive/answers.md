# Part 7 - Answers and Explanation

## 1. What problem does a primary key solve?

A primary key uniquely identifies each row in a table. It prevents duplicate records and allows other tables to reference a specific row.

---

## 2. What problem does AUTOINCREMENT solve?

AUTOINCREMENT automatically generates a unique ID for every new row. It removes the need to manually assign IDs and avoids duplicate primary key values.

---

## 3. What problem does a foreign key solve?

A foreign key maintains relationships between tables and ensures referential integrity. It prevents inserting records that reference non-existent data in another table.

---

## 4. Why is enrollments a bridge table?

The `enrollments` table connects students and courses. Since one student can enroll in many courses and one course can have many students, it resolves a many-to-many relationship.

---

## 5. Why is submissions also a relationship table?

The `submissions` table connects students with assignments. It stores each student's submission, score, and submission status for a specific assignment.

---

## 6. What is one-to-many in your project? Give two examples.

**Example 1:** One instructor can teach many courses.

**Example 2:** One course can have many assignments.

---

## 7. What is many-to-many in your project? Give one example.

Students and courses have a many-to-many relationship because one student can enroll in many courses, and one course can have many students. This relationship is implemented using the `enrollments` table.

---

## 8. Why should we not store instructor_name directly inside every course report table?

Storing the instructor's name in multiple places creates duplicate data. If the instructor's name changes, it would have to be updated everywhere. Keeping it in one table avoids redundancy and maintains data consistency.

---

## 9. What is the difference between INNER JOIN and LEFT JOIN?

`INNER JOIN` returns only rows that have matching records in both tables.

`LEFT JOIN` returns all rows from the left table, even if there is no matching row in the right table.

---

## 10. Which constraint test was most important and why?

The foreign key constraint was the most important because it ensured that enrollments, attendance records, assignments, and submissions could only reference existing records. This protects the database from invalid relationships.

---

## 11. How does this prepare you for Databricks tables and reporting?

This project builds the foundation for working with Databricks by teaching how to design relational data models, enforce data quality with constraints, connect datasets using joins, and create business reports from multiple related tables. These are essential skills for building reliable data pipelines and analytics solutions.
