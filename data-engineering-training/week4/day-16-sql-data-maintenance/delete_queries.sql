-- SAFE DELETE:
-- This is safe only if program_id = 3 has no related enrollments, sessions, assignments,
-- or other historical records connected to it.
-- If related records exist, MySQL will reject the deletion because of foreign keys.

DELETE FROM programs
WHERE program_id = 3;



-- UNSAFE DELETE:
-- This is unsafe because student_id = 3 has important history.
-- The student is connected to attendance records and submissions.
-- MySQL blocks the deletion to prevent orphaned records and preserve data integrity.

DELETE FROM students
WHERE student_id = 3;



-- UNSAFE DELETE:
-- This is unsafe because assignment_id = 3 has submissions connected to it.
-- Deleting the assignment would leave submissions without a valid assignment reference.
-- MySQL prevents this deletion because of the foreign key relationship.

DELETE FROM assignments
WHERE assignment_id = 3;



-- SAFE DELETE:
-- This is safe because this is a test student created only for testing purposes.
-- Before deleting, we verified that this student has no attendance, enrollment,
-- or submission history connected to it.
-- Removing this record will not affect important historical data.

INSERT INTO students 
(first_name, last_name, email, city, created_at)
VALUES
('Test','User','test@gmail.com','London','2026-03-22');


DELETE FROM students
WHERE student_id = 8;