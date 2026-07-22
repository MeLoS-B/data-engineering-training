# Day 13 - Intensive Relationships and Foreign Keys

## Project Goal

The goal of this project was to design a relational database for a training management system using MySQL. The project focused on creating relationships between tables, enforcing data integrity with constraints, inserting realistic seed data, and writing SQL JOIN queries to generate meaningful business reports.

---

## Database Design

The database models a training platform where students enroll in courses taught by instructors. Each course contains assignments, students submit their work, and attendance is recorded for every enrollment.

The design follows database normalization principles by separating data into related tables to reduce duplication and improve consistency.

---

## Tables and Relationships

### Tables

* **students** – Stores student information.
* **instructors** – Stores instructor information.
* **courses** – Stores available training courses.
* **enrollments** – Bridge table connecting students and courses.
* **attendance** – Stores attendance records for each enrollment.
* **assignments** – Stores assignments for each course.
* **submissions** – Stores student assignment submissions.

### Relationships

* One instructor → Many courses
* One course → Many assignments
* One course → Many enrollments
* One student → Many enrollments
* One enrollment → Many attendance records
* One assignment → Many submissions
* One student → Many submissions

---

## Primary Keys, Foreign Keys, and Constraints

The database uses:

* Primary Keys to uniquely identify every record.
* AUTO_INCREMENT to generate unique IDs automatically.
* Foreign Keys to enforce relationships between tables.
* UNIQUE constraint to prevent duplicate student enrollments.
* CHECK constraints to validate values such as:

  * Course level
  * Enrollment status
  * Submission status
  * Attendance values
  * Scores
  * Minutes attended

These constraints help maintain accurate and reliable data.

---

## Seed Data

Realistic seed data was inserted into every table, including:

* 8 students
* 3 instructors
* 5 courses
* 12 enrollments
* 18 attendance records
* 6 assignments
* 12 submissions

The data includes multiple student enrollments, different attendance scenarios, submitted, late, and missing assignments, and one student with no enrollment for LEFT JOIN testing.

---

## Constraint Tests

Several constraint tests were performed to verify that the database correctly rejects invalid data.

Examples include:

* Duplicate email addresses
* Duplicate student-course enrollments
* Invalid foreign keys
* Invalid course levels
* Invalid enrollment statuses
* Invalid submission statuses
* Negative scores
* Negative attendance minutes

---

## JOIN Reports

Multiple SQL reports were created using JOINs, including:

* Students enrolled in each course
* Students enrolled in multiple courses
* Attendance summaries
* Average attendance by course
* Assignment completion reports
* Missing and late submissions
* Active enrollments by instructor
* Revenue-style business reporting using GROUP BY and aggregate functions

The project uses INNER JOIN, LEFT JOIN, GROUP BY, HAVING, COUNT, SUM, AVG, and CASE statements.

---

## Manager Report

A final business report combines information from multiple tables into a single view containing:

* Student name
* Course name
* Instructor name
* Enrollment status
* Total attendance sessions
* Attended sessions
* Total minutes attended
* Average assignment score

This report demonstrates how relational databases can be used to create management dashboards.

---

## Screenshots

Include screenshots of:

* All created tables
* Seed data inserted successfully
* Constraint test results
* JOIN query outputs
* Final manager report
* Database diagram (if available)

---

## What I Can Explain Live

I can explain:

* Primary keys and foreign keys
* One-to-many and many-to-many relationships
* Bridge tables
* Database normalization
* CHECK, UNIQUE, and FOREIGN KEY constraints
* INNER JOIN vs LEFT JOIN
* GROUP BY and aggregate functions
* CASE statements
* Manager reporting queries
* Why relational database design is important for analytics and reporting

---

## What I Would Improve Next

If I continued this project, I would:

* Add indexes to improve query performance.
* Implement stored procedures for reporting.
* Create views for frequently used reports.
* Add triggers for automatic auditing.
* Introduce user authentication and roles.
* Expand the dataset with more realistic training sessions and assignments.
* Migrate the project to Databricks and build Bronze, Silver, and Gold reporting layers using Spark.
