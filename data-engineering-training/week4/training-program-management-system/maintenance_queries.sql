


-- Correct a student city.
UPDATE students
SET city = 'prizren'
WHERE student_id = 2;

UPDATE students
SET city = 'Prizren'
WHERE LOWER(city) = 'prizren';
SELECT * FROM students;




-- Update a wrong email.
UPDATE students
SET email = 'valon.zeka@gm.com'
WHERE student_id = 10;

UPDATE students
SET email = NULL
WHERE email NOT LIKE '%@gmail.com';





-- Change a program status.
UPDATE programs
SET program_status = 'dropped'
WHERE program_id = 1;



-- Mark a student as dropped without deleting the student.
UPDATE students
SET student_status = "dropped"
WHERE student_id = 4;
SELECT * FROM students





-- Correct attendance from absent to present.
UPDATE attendance
SET attendance_status = 'present'
WHERE attendance_id = 11;
SELECT * FROM attendance



-- Add feedback to a submission where feedback is missing.
UPDATE submissions
SET feedback = 'Good,but should do better'
WHERE submission_id = 3;
SELECT * FROM submissions




-- Update a score after review.
UPDATE submissions
SET score = 65
WHERE submission_id = 1;
SELECT * FROM submissions;




-- Normalize inconsistent city names.
UPDATE students
SET city = CASE
    WHEN LOWER(city) = 'prishtina' THEN 'Prishtina'
    WHEN LOWER(city) = 'vushtrri' THEN 'Vushtrri'
    WHEN LOWER(city) = 'prizren' THEN 'Prizren'
    WHEN LOWER(city) = 'peja' THEN 'Peja'
	WHEN LOWER(city) = 'gjilan' THEN 'Gjilan'
    WHEN LOWER(city) = 'ferizaj' THEN 'Ferizaj'
    ELSE city
END;
SELECT * FROM students;




-- Test a dangerous delete and explain why it should not be done.
-- is dangerous because it deletes every record inside the students table.

-- There is no WHERE condition, so the database does not know which rows should be removed. As a result, all student information would be permanently deleted.

-- This should not be used in a production environment because it can cause irreversible data loss.

-- A safer approach is to always specify the exact rows that should be deleted:
DELETE FROM students;