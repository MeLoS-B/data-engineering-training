

-- Average score by student.
SELECT AVG(score) AS average_score_per_student,CONCAT(first_name," ",last_name) AS full_name FROM students INNER JOIN submissions ON students.student_id = submissions.student_id
GROUP BY students.student_id





-- Average score by assignment.
SELECT AVG(score) AS average_score_per_assignment,assignments.assignment_id FROM submissions 
INNER JOIN assignments ON submissions.assignment_id = assignments.assignment_id
GROUP BY assignments.assignment_id




-- Attendance summary by student.
SELECT
    students.student_id,
    COUNT(*) AS total_records
FROM attendance
JOIN students
ON attendance.student_id = students.student_id
GROUP BY students.student_id;




-- Submission count by student.
SELECT students.student_id,COUNT(submission_id) AS count_submission_per_student FROM submissions INNER JOIN students ON submissions.student_id = students.student_id
GROUP BY students.student_id



-- Missing submission count by student.
SELECT COUNT(*) AS missing_submission,students.student_id FROM students LEFT JOIN submissions ON students.student_id = submissions.student_id
WHERE submissions.submission_id IS NULL
GROUP BY students.student_id 



-- Feedback missing count.

SELECT COUNT(*) AS missing_feedback_count,students.student_id FROM students LEFT JOIN submissions ON students.student_id = submissions.student_id
WHERE feedback IS NULL 
GROUP BY students.student_id


-- Program performance summary.
SELECT COUNT(*) AS count_by_status,program_status FROM programs 
GROUP BY program_status



-- Students with average score below 70.

SELECT AVG(score) AS average_score_per_student,CONCAT(first_name," ",last_name) AS full_name FROM students INNER JOIN submissions ON students.student_id = submissions.student_id
GROUP BY students.student_id
HAVING average_score_per_student < 70



-- Students with 2 or more absences.


SELECT COUNT(*) AS count_absent_attendance,students.student_id FROM students INNER JOIN attendance ON students.student_id = attendance.student_id
WHERE attendance_status = 'absent'
GROUP BY students.student_id
HAVING count_absent_attendance > 1;




-- Students who need support.

SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    p.program_name,
    ROUND(
        (SUM(CASE WHEN a.attendance_status = 'present' THEN 1 ELSE 0 END) 
        / COUNT(a.attendance_id)) * 100, 
        2
    ) AS attendance_rate,
    ROUND(AVG(sub.score), 2) AS average_score,
    COUNT(CASE WHEN sub.submission_status = 'missing' THEN 1 END) AS missing_submissions
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN programs p
    ON e.program_id = p.program_id
LEFT JOIN sessions se
    ON p.program_id = se.program_id
LEFT JOIN attendance a
    ON s.student_id = a.student_id 
    AND se.session_id = a.session_id
LEFT JOIN submissions sub
    ON s.student_id = sub.student_id
WHERE e.enrollment_status IN ('active', 'completed')
GROUP BY 
    s.student_id,
    s.first_name,
    s.last_name,
    p.program_name
HAVING 
    attendance_rate < 70
    OR average_score < 60
    OR missing_submissions > 0;










-- Students who look ready for the next phase.
SELECT students.student_id,CONCAT(first_name," ",last_name) AS full_name,
    ROUND(
        (SUM(CASE WHEN attendance.attendance_status = 'present' THEN 1 ELSE 0 END) 
        / COUNT(attendance.attendance_id)) * 100, 
        2
    ) AS attendance_rate,
    AVG(score) as average_score,
    SUM(CASE WHEN submission_status = 'late' THEN 1 ELSE 0 END) as missing_submission
FROM students 
INNER JOIN attendance ON students.student_id = attendance.student_id
INNER JOIN submissions ON students.student_id = submissions.student_id
GROUP BY students.student_id
HAVING missing_submission = 0 AND  average_score > (
      SELECT AVG(score) FROM submissions
);




-- Program-level summary that includes students, attendance, scores, and missing work.

SELECT 
programs.program_name,
COUNT(DISTINCT students.student_id) AS count_attendance_by_student,
ROUND((SUM(CASE WHEN attendance.attendance_status = 'present' THEN 1 ELSE 0 END) / COUNT(attendance.attendance_id) * 100),2) AS attendance_rate,
AVG(score) AS average_score,
SUM(CASE WHEN assignments.assignment_id IS NULL THEN 1 ELSE 0 END) AS missing_work
FROM programs 
INNER JOIN enrollments ON programs.program_id = enrollments.program_id
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN attendance ON attendance.student_id = students.student_id
INNER JOIN submissions ON submissions.student_id = students.student_id
LEFT JOIN assignments ON assignments.assignment_id = submissions.assignment_id
GROUP BY programs.program_name;




-- Students without review or evaluation.

SELECT * FROM students 
LEFT JOIN submissions ON students.student_id = submissions.student_id
WHERE submission_status != 'reviewed'




-- Programs without enough sessions.

SELECT programs.program_id,programs.program_name,COUNT(sessions.session_id) AS count_sessions FROM programs 
INNER JOIN sessions ON programs.program_id = sessions.program_id
GROUP BY programs.program_id
HAVING count_sessions > 3




-- Assignments without submissions.

SELECT assignments.* FROM assignments LEFT JOIN submissions ON assignments.assignment_id = submissions.assignment_id
WHERE submissions.submission_id IS NULL




-- Active students with no recent activity.

SELECT submission_date,students.* FROM students
INNER JOIN submissions ON students.student_id = submissions.student_id
WHERE students.student_status = 'active' AND submission_date < "2026-04-01"




-- Students who have attendance but no submission history.

SELECT students.* FROM students INNER JOIN attendance ON students.student_id = attendance.student_id
LEFT JOIN submissions ON students.student_id = submissions.student_id
WHERE submissions.submission_id IS NULL
GROUP BY students.student_id



-- Students who have submissions but no feedback yet.

SELECT students.*
FROM students
INNER JOIN submissions 
    ON students.student_id = submissions.student_id
WHERE submissions.feedback IS NULL
GROUP BY students.student_id;



-- 