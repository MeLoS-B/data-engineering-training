
## Hard Delete vs Soft Delete

### Hard Delete

A hard delete permanently removes data from the database using the `DELETE` statement. Once the data is deleted, it cannot be recovered unless there is a backup.

Example:

```sql
DELETE FROM students
WHERE student_id = 10;


Soft Delete

A soft delete does not remove the data permanently. Instead, it marks the record as deleted by using a column such as is_deleted or deleted_at.

Example:

UPDATE students
SET deleted_at = NOW()
WHERE student_id = 10;




# Student Management Database Project

## Project Goal

The goal of this project is to design and build a relational database system that helps an organization manage students, programs, courses, attendance, assignments, submissions, payments, and performance tracking.

The database allows management to understand student progress, identify students who need support, analyze attendance and scores, and generate useful reports for decision-making.

---

# Client Problem

The client needed a structured system to organize student information and track student performance.

Before creating this database, information about students, programs, attendance, assignments, and payments could become difficult to manage because data was stored separately.

The main problems were:

- Difficulty tracking student attendance.
- Difficulty identifying students who are falling behind.
- No simple way to analyze student performance.
- Missing visibility into assignment submissions and feedback.
- Difficulty generating management reports.

This database solves these problems by connecting all important information in one relational system.

---

# Database Design

The database was designed using a relational database model.

The main tables created are:

- students
- programs
- instructors
- enrollments
- attendance
- assignments
- submissions
- payments


Each table has a specific purpose and stores only related information to reduce duplicate data.

The database follows normalization principles by separating different types of information into different tables and connecting them using relationships.

---

# Why These Tables Were Created

## Students Table

Stores basic information about every student.

Examples:
- Student name
- Email
- Phone
- Status


## Programs Table

Stores information about available programs.

Examples:
- Program name
- Duration


## Instructors Table

Stores information about instructors who manage programs.


## Enrollments Table

Connects students with programs.

A student can enroll in a program, and a program can have many students.


## Attendance Table

Tracks student attendance records.

This allows calculating attendance percentage and identifying students with attendance problems.


## Assignments Table

Stores assignments created for students.


## Submissions Table

Tracks submitted assignments, scores, and feedback.


## Payments Table

Stores payment information and allows financial tracking.

---

# Important Relationships

The most important relationships are:

## Students → Enrollments

One student can have multiple enrollments.

Relationship:
One-to-Many


## Programs → Enrollments

One program can contain many students.

Relationship:
One-to-Many


## Students → Attendance

One student can have many attendance records.

Relationship:
One-to-Many


## Students → Submissions

One student can submit multiple assignments.

Relationship:
One-to-Many


## Assignments → Submissions

One assignment can have many submissions.

Relationship:
One-to-Many

---

# Primary Keys Used

Primary keys were used to uniquely identify every record.

Examples:

- students.student_id
- programs.program_id
- instructors.instructor_id
- assignments.assignment_id
- submissions.submission_id


Primary keys prevent duplicate records and allow tables to connect correctly.

---

# Foreign Keys Used

Foreign keys were used to create relationships between tables.

Examples:

- enrollments.student_id references students.student_id
- enrollments.program_id references programs.program_id
- attendance.student_id references students.student_id
- submissions.assignment_id references assignments.assignment_id
- payments.student_id references students.student_id


Foreign keys maintain data consistency and prevent invalid relationships.

---

# Unique Constraints Used

Unique constraints were added to columns that should not contain duplicate values.

Examples:

- Student email
- Program names


This prevents duplicate information from entering the database.

---

# CHECK Constraints Used

CHECK constraints were used to control allowed values.

Examples:

Attendance status:
