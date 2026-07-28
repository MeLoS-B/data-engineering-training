


-- Start a transaction, update one score, verify it changed, then ROLLBACK. Prove the old value returned.

START TRANSACTION;
   UPDATE submissions
   SET score = 94
   WHERE submission_id = 3;

ROLLBACK;



-- Start a transaction, try to delete a student who has submissions or attendance. Explain what happens.

START TRANSACTION;
 
  DELETE FROM students
  WHERE student_id = 2;

COMMIT;
SELECT * FROM students;



-- Start a transaction, soft-delete one enrollment by changing status to dropped, then COMMIT.


START TRANSACTION;
UPDATE  enrollments
SET status = 'dropped'
WHERE enrollment_id = 5;
COMMIT;



-- Start a transaction, make two updates together: update score and feedback for the same submission. COMMIT only if both are correct.
START TRANSACTION;
  UPDATE submissions
  SET score = 54 AND feedback = 'Very good';
COMMIT;
SELECT * FROM submissions



-- Use ROLLBACK when something goes wrong and you want to cancel all changes
-- made during the transaction. It returns the database to the state before
-- START TRANSACTION was executed.

-- Example: You updated the wrong student score, deleted the wrong record,
-- or your data validation failed, so you undo the changes.

ROLLBACK;


-- Use COMMIT when you are sure that all changes inside the transaction are
-- correct and you want to permanently save them in the database.

-- Example: You checked your UPDATE, INSERT, or DELETE results,
-- everything is correct, so you confirm and save the changes.

COMMIT;