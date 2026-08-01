


-- One transaction that updates data and uses ROLLBACK.
SET AUTOCOMMIT = OFF;
UPDATE students
SET email = "melos@gmail.com"
WHERE student_id = 1;
ROLLBACK;
SELECT * FROM students;



-- One transaction that updates data and uses COMMIT.
SET AUTOCOMMIT = OFF;
UPDATE students
SET first_name = "Dreni"
WHERE student_id = 4;
COMMIT;
SELECT * FROM students;



-- One transaction that updates data and uses COMMIT.
SET AUTOCOMMIT = OFF;
DELETE FROM submissions
WHERE submission_id > 4;
ROLLBACK;
SELECT * FROM submissions;




-- Before ROLLBACK or COMMIT, run SELECT queries to check the temporary result.

START TRANSACTION;
UPDATE students
SET phone_number = "044998889"
WHERE student_id = 1;
SELECT * FROM students;
ROLLBACK;




-- After ROLLBACK or COMMIT, run SELECT queries again to verify what happened.

START TRANSACTION;
UPDATE students
SET phone_number = "044998889"
WHERE student_id = 1;
COMMIT;
SELECT * FROM students;




-- Difference between COMMIT and ROLLBACK
-- COMMIT	ROLLBACK
-- Saves changes permanently	Removes changes
-- Ends the transaction	Ends the transaction
-- Cannot undo after committing	Returns database to previous state
-- Used when data is correct	Used when something went wrong