# Database Design

## Overview

Before creating the database, it is important to understand how the information is organized. The goal of this database is to manage a training system where students enroll in courses, instructors teach those courses, assignments are created, attendance is tracked, and students submit their work.

Each table stores one type of information only. This reduces duplicate data, keeps the database organized, and makes updates much easier.

---

# Database Tables

## students

Represents all students attending the training program.

**Primary Key**
- student_id

Each student can enroll in multiple courses and submit multiple assignments.

---

## instructors

Represents instructors who teach courses.

**Primary Key**
- instructor_id

Each instructor can teach multiple courses.

---

## courses

Represents all available training courses.

**Primary Key**
- course_id

**Foreign Key**
- instructor_id → instructors(instructor_id)

Each course belongs to one instructor.

---

## enrollments

Represents students enrolled in courses.

This is a bridge table that connects students and courses.

**Primary Key**
- enrollment_id

**Foreign Keys**
- student_id → students(student_id)
- course_id → courses(course_id)

One student can enroll in many courses, and one course can have many students.

---

## attendance

Stores attendance records for each enrollment.

**Primary Key**
- attendance_id

**Foreign Key**
- enrollment_id → enrollments(enrollment_id)

Each enrollment can have multiple attendance records.

---

## assignments

Represents assignments created for a course.

**Primary Key**
- assignment_id

**Foreign Key**
- course_id → courses(course_id)

Each course can contain multiple assignments.

---

## submissions

Stores student submissions for assignments, including scores and submission status.

**Primary Key**
- submission_id

**Foreign Keys**
- student_id → students(student_id)
- assignment_id → assignments(assignment_id)

Each student can submit many assignments, and each assignment can receive submissions from many students.

---

# Primary Keys

| Table | Primary Key |
|--------|-------------|
| students | student_id |
| instructors | instructor_id |
| courses | course_id |
| enrollments | enrollment_id |
| attendance | attendance_id |
| assignments | assignment_id |
| submissions | submission_id |

---

# Foreign Keys

| Child Table | Foreign Key | References |
|-------------|-------------|------------|
| courses | instructor_id | instructors(instructor_id) |
| enrollments | student_id | students(student_id) |
| enrollments | course_id | courses(course_id) |
| attendance | enrollment_id | enrollments(enrollment_id) |
| assignments | course_id | courses(course_id) |
| submissions | student_id | students(student_id) |
| submissions | assignment_id | assignments(assignment_id) |

---

# One-to-Many Relationships

### 1. Instructor → Courses

One instructor can teach many courses.

```
Instructor
    |
    |---- Course 1
    |---- Course 2
    |---- Course 3
```

---

### 2. Course → Assignments

One course can have many assignments.

```
Course
   |
   |---- Assignment 1
   |---- Assignment 2
   |---- Assignment 3
```

---

### 3. Student → Enrollments

One student can enroll in multiple courses.

```
Student
   |
   |---- Enrollment 1
   |---- Enrollment 2
```

---

### 4. Enrollment → Attendance

One enrollment can have many attendance records.

```
Enrollment
     |
     |---- Attendance 1
     |---- Attendance 2
     |---- Attendance 3
```

---

### 5. Assignment → Submissions

One assignment can receive submissions from many students.

```
Assignment
      |
      |---- Submission
      |---- Submission
      |---- Submission
```

---

# Many-to-Many Relationship

The relationship between **students** and **courses** is many-to-many.

- One student can enroll in many courses.
- One course can have many students.

This cannot be represented directly, so a bridge table called **enrollments** is used.

```
Students
    |
    |
Enrollments
    |
    |
Courses
```

The **enrollments** table stores one record for each student-course combination.

Example:

| enrollment_id | student_id | course_id |
|---------------|------------|-----------|
| 1 | 1 | 2 |
| 2 | 1 | 3 |
| 3 | 2 | 2 |

---

# Why course_name Should Not Be Stored Inside Students

The `course_name` should not be stored repeatedly in the `students` table because:

- A student can enroll in multiple courses.
- Multiple students can take the same course.
- Repeating course names creates duplicate data.
- If a course name changes, it would need to be updated in many student records.
- Keeping course information only in the `courses` table follows database normalization and keeps the data consistent.

Instead, the relationship between students and courses is managed through the `enrollments` table.

---

# Database Relationship Diagram

```
instructors
      |
      v
   courses
      |
      +----------------+
      |                |
      v                v
assignments      enrollments
      |             ^
      |             |
      v             |
 submissions    students
      ^
      |
attendance
(enrollment_id)
```