

-- Query 1
UPDATE students
SET city = 'Prishtina'
WHERE student_id = 7;



-- Query 2
UPDATE students
SET email = "melosbeqiri123@gmail.com"
WHERE student_id = 7;


-- Query 3

UPDATE programs
SET status = 'planned'
WHERE program_id = 2;



-- Query 4

UPDATE enrollments
SET status = 'dropped'
WHERE student_id = 4;


-- Query 5


UPDATE attendance
SET
    status = 'present',
    notes = 'Student arrived late'
WHERE attendance_id = 17;
SELECT * FROM attendance;


-- Query 6
UPDATE submissions
SET 
   feedback = 'nice work',
   score = 92
WHERE submission_id = 5;



--Query 7 
UPDATE students
SET city = 'London'
WHERE city = 'london';
