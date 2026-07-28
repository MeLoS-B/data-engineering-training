# Day 17 Practice - SQL Schema Evolution, Views, Transactions & Indexes

## Project Goal: What does database schema evolution mean?

Database schema evolution means changing the structure of a database over time as business requirements change.

In real-world projects, databases are not created once and never changed. New requirements appear, and we need to add new columns, modify tables, create new views, or improve performance without losing existing data.

Examples of schema evolution:
- Adding new columns to existing tables.
- Creating new tables.
- Changing database structures to support new reports.
- Improving database performance with indexes.

Schema evolution is important in data engineering because data sources constantly change, and pipelines must handle these changes correctly.

---

# Setup: Tables Used

For this project, I used the following tables:

## Students

Stores information about students.

Columns:
- student_id
- first_name
- last_name
- email
- city
- created_at


## Programs

Stores information about training programs.

Columns:
- program_id
- program_name
- program_type
- start_date
- end_date
- status


## Enrollments

Connects students with programs.

Columns:
- enrollment_id
- student_id
- program_id
- enrollment_date
- status


## Sessions

Stores training sessions for each program.

Columns:
- session_id
- program_id
- session_title
- session_number
- topic


## Attendance

Tracks student attendance.

Columns:
- attendance_id
- session_id
- student_id
- attendance_status
- notes


## Assignments

Stores program assignments.

Columns:
- assignment_id
- program_id
- title
- day_number
- due_date
- max_points


## Submissions

Stores student assignment submissions.

Columns:
- submission_id
- assignment_id
- student_id
- github_link
- submitted_at
- score
- feedback

---

# ALTER TABLE

`ALTER TABLE` was used to evolve the database schema by adding new fields required for reporting.

## Added columns:

### Students table

Added:

- phone_number
- github_username

Reason:

These fields provide additional student profile information that can be useful for reports and tracking student development.


### Submissions table

Added:

- review_status

Reason:

This field helps track whether submissions were reviewed or are still waiting for review.

Example values:
- Reviewed
- Pending Review

---

# Views

Views were created to simplify reporting by combining data from multiple tables.

## student_profile_view

Purpose:

Shows a clean profile report containing student information and enrollment status.

Business question answered:

"Show me student profiles and their current program enrollment information."

---

## student_submission_report

Purpose:

Combines students, assignments, and submissions.

It shows:
- Student name
- Assignment
- Score
- Feedback
- Performance review status

Business question answered:

"How are students performing on their assignments?"

---

## missing_feedback_view

Purpose:

Finds submissions that do not have feedback.

Business question answered:

"Which submissions still need instructor review or feedback?"

This helps instructors identify unfinished evaluation work.

---

## student_performance_view

Purpose:

Classifies students based on their score using CASE WHEN.

Performance levels:

- Excellent
- Good
- Average
- Poor

Business question answered:

"Which students are performing well and which students need improvement?"

---

# Transactions

Transactions help protect data when performing dangerous operations like UPDATE or DELETE.

## ROLLBACK example

Rollback cancels changes made during a transaction.

Example:

```sql
START TRANSACTION;

UPDATE students
SET city = 'Prizren'
WHERE student_id = 1;

ROLLBACK;
```

The change is removed and the original city value remains.

---

## COMMIT example

Commit permanently saves changes.

Example:

```sql
START TRANSACTION;

UPDATE students
SET city = 'Prizren'
WHERE student_id = 1;

COMMIT;
```

After COMMIT, the update becomes permanent.

---

# Indexes

Indexes improve database performance by helping the database find rows faster.

Indexes added:

## submissions.student_id

```sql
CREATE INDEX idx_submissions_student_id
ON submissions(student_id);
```

Why:

This improves joins between students and submissions and makes searching submissions by student faster.


## submissions.assignment_id

```sql
CREATE INDEX idx_submissions_assignment_id
ON submissions(assignment_id);
```

Why:

This improves reports that need to find all submissions for a specific assignment.

Indexes are useful when tables become large because they reduce the amount of data the database needs to scan.

---

# Integration Challenge: final_student_progress_view

The final_student_progress_view combines all important reporting logic into one business-ready view.

It uses:

## LEFT JOIN

LEFT JOIN keeps all students, even if they do not have submissions.

This helps answer:

"Which students are missing submissions?"

---

## COALESCE

COALESCE replaces NULL feedback values.

Example:

Instead of:

```
NULL
```

The report shows:

```
No feedback yet
```

---

## CASE WHEN

CASE WHEN creates performance categories based on scores.

Rules:

- Score >= 90 → Excellent
- Score >= 70 → Good
- Score >= 50 → Average
- Below 50 → Poor
- No score → No Submission

---

The final view provides:

- Student information
- Assignment information
- Scores
- Feedback status
- Performance level
- Review status

This creates a clean reporting layer that can be used by instructors and business users.

---

# What I Can Explain Live

The most important concepts I understand:

1. Schema evolution means changing database structure as requirements change.

2. ALTER TABLE allows adding new fields without rebuilding the database.

3. Views create reusable reports from multiple tables.

4. Tables store real data, while views store query logic.

5. Transactions protect data using COMMIT and ROLLBACK.

6. ROLLBACK cancels changes and COMMIT permanently saves changes.

7. Indexes improve query performance by helping the database find data faster.

8. LEFT JOIN is useful when we need to include records that do not have matching data.

9. COALESCE helps handle NULL values and create cleaner reports.

10. CASE WHEN allows creating business classifications from raw data.

11. Creating reporting views is similar to creating analytics layers in data engineering systems like Databricks and Delta Lake.