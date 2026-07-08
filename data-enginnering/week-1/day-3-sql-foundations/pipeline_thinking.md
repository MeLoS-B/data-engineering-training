# Data Pipeline Thinking - Day 3

## Chosen business:
Online Learning School Payment System

## Source Data:
The source data comes from student registrations, course enrollments, payment records, and student information.
The data includes student names, courses, payment amounts, payment status, bonuses, and payment dates.

## Ingestion:
The data is collected from student registration forms and payment systems, then loaded into a database table called `school`.
The ingestion process brings new student payment records into the system.

## Storage:
The data is stored in a SQL database inside tables where student payments and course information can be managed.
The school table stores payment ID, student name, course, amount, status, bonus, and payment date.

## Cleaning:
The data cleaning process checks for missing student names, incorrect payment statuses, duplicate payments, and invalid payment amounts.
Incorrect or incomplete records are fixed before analysis.

## Transformation:
The data is transformed by calculating total revenue, average payments, completed payments, cancelled payments, and course performance.
New calculated fields such as final payment amount can also be created.

## Business Output:
The final output can be business reports and dashboards showing revenue by course, paid students, pending payments, and cancelled payments.

## Business questions we can answer:
1. Which course generates the highest revenue?
2. How many students have completed their payments?
3. What is the average payment amount for each course?

## Possible data problems:
1. Missing student information or empty course names.
2. Duplicate payment records for the same student.
3. Incorrect payment statuses or invalid payment amounts.