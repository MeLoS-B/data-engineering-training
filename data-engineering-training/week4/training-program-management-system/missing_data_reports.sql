


-- Students who did not submit a specific assignment.

SELECT students.*
FROM students
LEFT JOIN submissions 
ON students.student_id = submissions.student_id
AND submissions.assignment_id = 3
WHERE submissions.submission_id IS NULL;




-- Students who have no submissions at all.

SELECT students.*
FROM students
LEFT JOIN submissions 
ON students.student_id = submissions.student_id
WHERE submissions.submission_id IS NULL;



-- -- Submissions without feedback.

SELECT * FROM submissions
WHERE feedback IS NULL OR feedback = ''



-- -- Students without attendance for a specific session.
SELECT students.* FROM students
LEFT JOIN attendance ON students.student_id = attendance.student_id
AND session_id = 1
WHERE attendance.attendance_id IS NULL