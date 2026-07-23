# Database Design Plan

## Project Goal

The goal of this database is to manage an online training platform. It stores information about students, instructors, courses, enrollments, attendance, assignments, and submissions. The database is designed to keep data organized, maintain data integrity, and make it easy to generate reports about student progress, course performance, attendance, and assignment completion.

---

# Tables

## students

Stores information about every student registered in the platform.

**Purpose:**

* Keep student personal information.
* Connect students to enrollments and assignment submissions.

---

## instructors

Stores information about instructors who teach courses.

**Purpose:**

* Keep instructor details.
* Assign instructors to courses.

---

## courses

Stores all available training courses.

**Purpose:**

* Store course information.
* Link each course to one instructor.
* Track enrollments and assignments.

---

## enrollments

Represents the relationship between students and courses.

**Purpose:**

* Record which students are enrolled in which courses.
* Store enrollment date and status.
* Resolve the many-to-many relationship between students and courses.

---

## attendance

Stores attendance records for each enrolled student.

**Purpose:**

* Track attendance for every class session.
* Record attendance status and minutes attended.

---

## assignments

Stores assignments created for each course.

**Purpose:**

* Keep assignment information.
* Associate assignments with courses.

---

## submissions

Stores student assignment submissions.

**Purpose:**

* Record submission dates.
* Store grades.
* Track whether assignments were submitted.

---

# Primary Keys

| Table       | Primary Key   |
| ----------- | ------------- |
| students    | student_id    |
| instructors | instructor_id |
| courses     | course_id     |
| enrollments | enrollment_id |
| attendance  | attendance_id |
| assignments | assignment_id |
| submissions | submission_id |

Primary keys uniquely identify every record in each table and prevent duplicate rows.

---

# Foreign Keys

| Table       | Foreign Key   | References                 |
| ----------- | ------------- | -------------------------- |
| courses     | instructor_id | instructors(instructor_id) |
| enrollments | student_id    | students(student_id)       |
| enrollments | course_id     | courses(course_id)         |
| attendance  | enrollment_id | enrollments(enrollment_id) |
| assignments | course_id     | courses(course_id)         |
| submissions | assignment_id | assignments(assignment_id) |
| submissions | enrollment_id | enrollments(enrollment_id) |

Foreign keys ensure that related records exist before data can be inserted.

---

# Relationship Types

### One-to-Many Relationships

* One instructor can teach many courses.
* One course can have many enrollments.
* One student can have many enrollments.
* One enrollment can have many attendance records.
* One course can have many assignments.
* One assignment can have many submissions.
* One enrollment can have many assignment submissions.

### Many-to-Many Relationship

Students and courses have a many-to-many relationship because:

* A student can enroll in multiple courses.
* A course can have multiple students.

This relationship is implemented using the **enrollments** table.

---

# Constraints

### NOT NULL

Used on important columns that must always contain a value, such as:

* Student name
* Instructor name
* Course title
* Enrollment date

This prevents incomplete records.

---

### UNIQUE

Used on values that should never be duplicated, such as:

* Student email
* Instructor email
* Combination of student_id and course_id in the enrollments table

This prevents duplicate users and duplicate course enrollments.

---

### CHECK

Used to validate acceptable values, for example:

* Course level must be Beginner, Intermediate, or Advanced.
* Attendance status must be 0 or 1.
* Minutes attended must be greater than or equal to 0.
* Grades must be between valid limits.

This ensures only valid data is stored.

---

### Foreign Key Constraints

Foreign keys prevent orphan records by ensuring related data already exists before insertion.

For example:

* A course cannot reference an instructor that does not exist.
* An attendance record cannot exist without an enrollment.
* A submission cannot exist without an assignment and an enrollment.

---

# Report Readiness

This database design supports a wide variety of reports without unnecessary duplication of data. Because the tables are properly normalized and connected through primary and foreign keys, SQL JOIN operations can easily generate business reports.

Examples of reports include:

* Students enrolled in each course.
* Courses with the highest number of enrollments.
* Attendance percentage by course.
* Average attendance minutes by course.
* Assignment completion rates.
* Missing or late submissions.
* Students enrolled in multiple courses.
* Instructor performance reports.
* Student progress and grades.
* Overall training platform statistics.

The design follows relational database principles, maintains data integrity through constraints, and provides a strong foundation for future expansion.
