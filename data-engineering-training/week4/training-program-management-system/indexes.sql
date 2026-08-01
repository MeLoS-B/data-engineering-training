

-- indexes.sql

-- ==========================================
-- Index 1: Students program_id
-- ==========================================

CREATE INDEX idx_enrollments_program_id
ON enrollments(program_id);

-- Why:
-- enrollments.program_id is used when joining enrollments with programs.
-- This helps MySQL find enrollments belonging to a specific program faster.

-- Query that benefits:

SELECT 
    programs.program_name,
    COUNT(students.student_id) AS total_students
FROM programs
JOIN students 
ON programs.program_id = students.program_id
GROUP BY programs.program_name;



-- ==========================================
-- Index 2: Attendance student_id
-- ==========================================

CREATE INDEX idx_attendance_student_id
ON attendance(student_id);

-- Why:
-- Attendance data is frequently searched by student.
-- This improves queries that calculate attendance summaries per student.

-- Query that benefits:

SELECT
    student_id,
    AVG(attendance_rate) AS avg_attendance
FROM attendance
GROUP BY student_id;



-- ==========================================
-- Index 3: Submissions assignment_id
-- ==========================================

CREATE INDEX idx_submissions_assignment_id
ON submissions(assignment_id);

-- Why:
-- Assignments are often joined with submissions.
-- The index helps MySQL quickly find submissions for an assignment.

-- Query that benefits:

SELECT
    assignments.assignment_name,
    COUNT(submissions.submission_id) AS total_submissions
FROM assignments
LEFT JOIN submissions
ON assignments.assignment_id = submissions.assignment_id
GROUP BY assignments.assignment_name;



-- ==========================================
-- Index 4: Students student_status
-- ==========================================

CREATE INDEX idx_students_status
ON students(student_status);

-- Why:
-- Reports often filter students by their status
-- (Active, Inactive, Graduated).

-- Query that benefits:

SELECT *
FROM students
WHERE student_status = 'Active';



-- ==========================================
-- Index 5: Payments payment_status
-- ==========================================

CREATE INDEX idx_payments_status
ON payments(payment_status);

-- Why:
-- Payment reports frequently filter unpaid or pending payments.

-- Query that benefits:

SELECT *
FROM payments
WHERE payment_status = 'Unpaid';



-- An index is a database structure that helps MySQL find rows faster without scanning the entire table.
-- Indexes do not change the data or the result of a query.
-- When tables are small, searching all rows is acceptable.
-- A full scan is fast.
-- But when the table grows:
-- Searching every row becomes slow.
-- Indexes allow MySQL to locate the required data faster instead of checking every record.