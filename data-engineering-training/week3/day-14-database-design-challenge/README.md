# Day 14 - Database Design Challenge

## Project Goal

The goal of this project is to design and build a relational database system for managing Unity Tech Hub x Agilyti training programs.

The database helps management track students, programs, instructors, enrollments, attendance, payments, and student risks.

The system allows reliable reporting about student performance, financial status, attendance, and program success.

---

# Business Requirements

The system should support:

- Managing student identity and contact information.
- Managing training programs such as Full Stack Development, Data Engineering, English Language, and After School.
- Tracking instructors responsible for teaching programs.
- Tracking student enrollment status.
- Recording student attendance for each session.
- Tracking monthly payments and payment status.
- Identifying academic and financial risks.
- Producing management reports using relational data.

---

# Database Design

The database contains the following tables:

## Students

Stores basic information about students.

Fields include:
- student_id
- full_name
- email
- phone
- city
- status
- registration_date

Purpose:
This table stores student identity and profile information.

---

## Programs

Stores available training programs.

Fields include:
- program_id
- program_name
- category
- fee
- level
- start_date
- end_date

Purpose:
Stores all training programs offered by Unity Tech Hub.

---

## Instructors

Stores instructor information.

Fields include:
- instructor_id
- full_name
- email
- phone
- specialization
- hire_date
- status

Purpose:
Tracks instructors responsible for teaching students.

---

## Enrollments

Connects students, programs, and instructors.

Fields include:
- enrollment_id
- student_id
- program_id
- instructor_id
- enrollment_date
- enrollment_status

Purpose:
This is the bridge table that manages student-program relationships.

---

## Attendance

Stores attendance records for enrolled students.

Fields include:
- attendance_id
- enrollment_id
- session_date
- attended
- minutes_attended

Purpose:
Allows calculation of attendance rates and student performance.

---

## Payments

Stores financial information.

Fields include:
- payment_id
- enrollment_id
- payment_month
- amount
- payment_status
- payment_date

Purpose:
Tracks collected revenue and unpaid payments.

---

## Risk

Stores academic and financial risk information.

Fields include:
- risk_id
- enrollment_id
- academic_risk
- financial_risk
- attendance_percentage
- unpaid_months
- risk_level
- notes

Purpose:
Helps identify students requiring attention.

---

# Primary Keys and Foreign Keys

## Primary Keys

Each table has its own primary key:

- students → student_id
- programs → program_id
- instructors → instructor_id
- enrollments → enrollment_id
- attendance → attendance_id
- payments → payment_id
- risk → risk_id


## Foreign Keys

Relationships are created using:

- enrollments.student_id → students.student_id
- enrollments.program_id → programs.program_id
- enrollments.instructor_id → instructors.instructor_id
- attendance.enrollment_id → enrollments.enrollment_id
- payments.enrollment_id → enrollments.enrollment_id
- risk.enrollment_id → enrollments.enrollment_id

---

# Relationships

## Students and Enrollments

One student can have many enrollments.

Relationship:
**One-to-Many**

Example:
A student can join Data Engineering and Full Stack Development.

---

## Programs and Enrollments

One program can have many students.

Relationship:
**One-to-Many**

Example:
Many students can enroll in Data Engineering.

---

## Instructors and Enrollments

One instructor can manage many enrollments.

Relationship:
**One-to-Many**

Example:
One instructor can teach multiple students.

---

## Enrollments and Attendance

One enrollment can have many attendance records.

Relationship:
**One-to-Many**

---

## Enrollments and Payments

One enrollment can have many payment records.

Relationship:
**One-to-Many**

---

# Constraints

The database uses constraints to maintain accurate data.

## PRIMARY KEY

Ensures every record has a unique identifier.

Example:
student_id

---

## FOREIGN KEY

Maintains relationships between tables.

Example:

enrollments.student_id references students.student_id

---

## NOT NULL

Prevents important information from being empty.

Examples:
- student name
- email
- city

---

## UNIQUE

Prevents duplicate data.

Examples:
- student email
- instructor email
- phone numbers

---

## CHECK

Validates values.

Examples:

```sql
minutes_attended >= 0