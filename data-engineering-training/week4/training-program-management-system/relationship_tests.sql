-- This should fail because the email column has a UNIQUE constraint,
-- and "blerim.kelmendi@gmail.com" already exists in the students table.
INSERT INTO students (first_name,last_name,email,phone_number,date_of_birth,city,registration_date,student_status)
VALUES ("Blerim","Kelmendi","blerim.kelmendi@gmail.com","044759399","2007-11-29","Vushtrri","2003-07-12","dropped");

SELECT * FROM students;


-- This should fail because a student can only have one attendance record
-- for the same session (UNIQUE(student_id, session_id)).
INSERT INTO attendance (student_id,session_id,attendance_status,check_in_time,notes)
VALUES (1,1,"late",FALSE,"Not good");

SELECT * FROM attendance;


-- This should fail because a student can only submit one submission
-- for the same assignment (UNIQUE(assignment_id, student_id)).
INSERT INTO submissions (assignment_id,student_id,github_link,submission_date,score,feedback,submission_status)
VALUES (1,5,'https://github.com/sara/sql-task','2026-01-20',60,NULL,'submitted');

SELECT * FROM submissions;


-- This should fail because the score must be between 0 and 100.
-- A score of 130 violates the CHECK constraint.
INSERT INTO submissions (assignment_id,student_id,github_link,submission_date,score,feedback,submission_status)
VALUES (1,5,'https://github.com/sara/sql-task','2026-01-20',130,NULL,'submitted');

SELECT * FROM submissions;


-- This should fail because the score cannot be negative.
-- A score of -30 violates the CHECK constraint.
INSERT INTO submissions (assignment_id,student_id,github_link,submission_date,score,feedback,submission_status)
VALUES (1,5,'https://github.com/sara/sql-task','2026-01-20',-30,NULL,'submitted');

SELECT * FROM submissions;


-- This should fail because "didnt attend" is not one of the allowed
-- attendance_status values defined by the CHECK constraint.
INSERT INTO attendance(student_id,session_id,attendance_status,check_in_time,notes)
VALUES (1,1,'didnt attend',1,'Good participation');

SELECT * FROM attendance;


-- This should fail because assignment_id 999 does not exist.
-- It violates the FOREIGN KEY constraint between submissions and assignments.
INSERT INTO submissions (assignment_id,student_id,github_link,submission_date,score,feedback,submission_status)
VALUES (999,1,'https://github.com/ardit/sql-task','2026-01-18',95,'Excellent SQL skills','reviewed');

SELECT * FROM submissions;


-- This should fail because session_id 444 does not exist.
-- It violates the FOREIGN KEY constraint between attendance and sessions.
INSERT INTO attendance(student_id,session_id,attendance_status,check_in_time,notes)
VALUES (1,444,'didnt attend',1,'Good participation');

SELECT * FROM attendance;