# Schema Evolution Notes

## 15. What is the difference between changing data and changing schema?

Changing data means modifying the values stored inside existing rows.

Example:
- Updating a student's city from "Prishtina" to "Prizren".
- Changing a submission score from 80 to 90.

Changing schema means modifying the structure of the database.

Example:
- Adding a new column like `github_username`.
- Creating a new table.
- Changing a column data type.

Data changes affect the information stored, while schema changes affect how the information is organized.

---

## 16. Why do real databases need ALTER TABLE?

Real databases change over time because business requirements change.

`ALTER TABLE` allows us to modify existing tables without deleting the data.

Examples:
- Adding new columns.
- Removing columns.
- Changing column types.
- Adding constraints.

For example, if a company starts tracking GitHub profiles for students, they can add a new column instead of creating a completely new database.

---

## 17. What is a view and why is it useful?

A view is a virtual table created from a SQL query.

It does not usually store the data itself. Instead, it stores the query logic and shows the latest data from the original tables.

Views are useful because:
- They simplify complex queries.
- They create reusable reports.
- They improve security by hiding unnecessary columns.
- They provide a clean reporting layer.

Example:

A student progress view can combine students, assignments, and submissions into one report.

---

## 18. What is the difference between a table and a view?

A table stores actual data physically inside the database.

A view stores a SQL query that displays data from one or more tables.

Difference:

| Table | View |
|---|---|
| Stores data | Stores query logic |
| Takes storage space | Usually does not store data |
| Can directly insert/update data | Mostly used for reading/reporting |
| Main data source | Reporting layer |

---

## 19. What does ROLLBACK do?

`ROLLBACK` cancels changes made during a transaction before they are permanently saved.

Example:

```sql
START TRANSACTION;

UPDATE students
SET city = 'Prizren'
WHERE student_id = 1;

ROLLBACK;
```

The update will be undone and the old value will return.

It is useful when a mistake happens during an operation.

---

## 20. What does COMMIT do?

`COMMIT` permanently saves changes made during a transaction.

Example:

```sql
START TRANSACTION;

UPDATE students
SET city = 'Prizren'
WHERE student_id = 1;

COMMIT;
```

After `COMMIT`, the changes cannot be undone using `ROLLBACK`.

---

## 21. Why are transactions useful before dangerous updates/deletes?

Transactions provide safety when performing risky operations.

Before running a large UPDATE or DELETE, we can test the operation first.

Example:

```sql
START TRANSACTION;

DELETE FROM submissions
WHERE score < 50;

SELECT * FROM submissions;

ROLLBACK;
```

If the result is wrong, we can cancel it.

If everything is correct:

```sql
COMMIT;
```

Transactions help prevent accidental data loss.

---

## 22. What is an index in simple words?

An index is like an organized lookup list in a book.

Without an index, the database may need to scan every row to find information.

With an index, the database can find matching rows faster.

Example:

Searching for a student by `student_id` is faster when that column has an index.

Indexes improve read performance, especially when tables become very large.

---

## 23. Which columns did you index and why?

I created indexes on:

### submissions.student_id

```sql
CREATE INDEX idx_submissions_student_id
ON submissions(student_id);
```

Reason:
- Used when joining submissions with students.
- Helps find all submissions from a specific student faster.


### submissions.assignment_id

```sql
CREATE INDEX idx_submissions_assignment_id
ON submissions(assignment_id);
```

Reason:
- Helps find all submissions for a specific assignment.
- Improves assignment reports and joins.

---

## 24. How does this prepare you for Databricks tables and views?

This prepares me for Databricks because the same database concepts are used in data engineering.

Tables in Databricks store data, similar to SQL tables.

Views create reusable queries for analysis and reporting, similar to SQL views.

Schema evolution is also important in Databricks because data changes over time. New columns may appear, and pipelines need to handle those changes.

Understanding:
- schemas,
- tables,
- views,
- transactions,
- and data organization

helps build better ETL pipelines and data warehouse solutions using technologies like Databricks, Delta Lake, and PySpark.