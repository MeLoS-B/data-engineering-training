


--Query 1 Add phone_number to students and fill it for at least 4 students.
ALTER TABLE students
ADD COLUMN phone_number VARCHAR(30);

UPDATE students
SET phone_number = '044222333'
WHERE student_id = 6;
UPDATE students
SET phone_number = '044111222'
WHERE student_id = 2;
UPDATE students
SET phone_number = '044555666'
WHERE student_id = 3;
UPDATE students
SET phone_number = '044777888'
WHERE student_id = 5;


-- Query 2 Add github_username to students and fill it for at least 4 students.
ALTER TABLE students
ADD COLUMN github_username VARCHAR(100);
UPDATE students
SET github_username = 'sA-ra'
WHERE student_id = 6;
UPDATE students
SET github_username = 'bLe_nd'
WHERE student_id = 2;
UPDATE students
SET github_username = 'ARTA'
WHERE student_id  = 1;
UPDATE students
SET github_username = 'luan'
WHERE student_id = 5;
SELECT * FROM students;


-- Query 3 Add review_status to submissions. Use values like 'not reviewed', 'reviewed','needs revision'.
ALTER TABLE submissions
ADD COLUMN review_status VARCHAR(30) CHECK (review_status IN ('not reviewed','reviewed','needs revision'));
SELECT * FROM submissions


-- Query 4 Add reviewed_at to submissions and update at least 3 rows.

ALTER TABLE submissions
ADD COLUMN reviewed_at DATE;
UPDATE submissions
SET reviewed_at = '2026-01-23'
WHERE submission_id = 2;
UPDATE submissions
SET reviewed_at = '2026-05-16'
WHERE submission_id = 6;
UPDATE submissions
SET reviewed_at = '2022-12-16'
WHERE submission_id = 1;


--Query 5 Add corrected_at to attendance and update rows that were corrected.


ALTER TABLE attendance
ADD COLUMN corrected_at DATETIME NULL;
UPDATE attendance
SET
    attendance_status = 'Present',
    corrected_at = NOW()
WHERE attendance_id IN (3, 4, 11, 22);



--Query 6 Add difficulty_level to programs. Example values: beginner, intermediate,advanced.

ALTER TABLE programs
ADD COLUMN difficulty_level VARCHAR(30) CHECK (difficulty_level IN ('beginner','intermediate','advanced'));


--Query 7 Add task_type to assignments. Example values: SQL, Python, Pipeline, Databricks Prep.
ALTER TABLE assignments
ADD COLUMN task_type VARCHAR(50) CHECK(task_type IN ('sql','python','pipeline','databricks prep'));
SELECT * FROM assignments;