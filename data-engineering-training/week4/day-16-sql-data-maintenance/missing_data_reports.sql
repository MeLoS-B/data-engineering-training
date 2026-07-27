


-- • Show all students and their submissions, including students with no submission.
SELECT
	s.student_id,
	s.first_name,
	s.last_name,
	sub.submission_id
FROM students s
LEFT JOIN submissions sub
ON s.student_id = sub.student_id


-- Explanation:
-- A LEFT JOIN is used because we want to show all students, even if they have not submitted anything.
-- Students with submissions will show their submission_id.
-- Students without submissions will have NULL in the submission_id column.
-- This helps identify students who have not completed any assignments.


-- • Show students who did not submit a specific assignment.

SELECT * FROM students LEFT JOIN submissions ON students.student_id = submissions.student_id
WHERE submission_id IS NULL


--The LEFT JOIN keeps all students and tries to find matching submissions.
-- filters only students who do not have any submission record.
-- These students are identified as students who have not submitted the assignment.

-- • Show students who have no feedback yet.

SELECT * FROM students LEFT JOIN submissions ON students.student_id = submissions.student_id
WHERE feedback IS NULL


-- The query uses LEFT JOIN to keep all students and check their submission feedback.
-- If the feedback column is NULL, it means:
-- The student submitted an assignment but the instructor has not provided feedback yet.
-- Or the student has no submission record.
-- This query helps find submissions that still need review or feedback.




-- Show enrolled students with missing attendance for a session.


SELECT * FROM students 
INNER JOIN enrollments ON students.student_id = enrollments.student_id
LEFT JOIN attendance ON attendance.student_id = students.student_id
LEFT JOIN sessions ON sessions.session_id = attendance.session_id
WHERE attendance.attendance_id IS NULL



-- First, the INNER JOIN with enrollments ensures that we only check students who are actually enrolled in a program.
-- Then, the LEFT JOIN with attendance keeps all enrolled students, even if they do not have an attendance record.