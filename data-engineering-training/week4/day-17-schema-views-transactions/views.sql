


--Query 1 student_profile_view - show student name, city, email, phone number, GitHub username, enrollment status.
CREATE VIEW student_profile_view AS 
SELECT CONCAT(first_name," ",last_name) AS full_name,city,email,phone_number,github_username,status FROM students
INNER JOIN enrollments ON students.student_id = enrollments.student_id;
SELECT * FROM student_profile_view

--Query 2 student_submission_report - show student, assignment, score, feedback, review status.


CREATE VIEW student_submission_report AS
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    a.title AS assignment,
    sub.score,
    sub.feedback,

    CASE
        WHEN sub.score >= 90 THEN 'Excellent'
        WHEN sub.score >= 70 THEN 'Good'
        WHEN sub.score >= 50 THEN 'Needs Improvement'
        ELSE 'Poor'
    END AS review_status

FROM submissions sub

INNER JOIN students s
ON sub.student_id = s.student_id

INNER JOIN assignments a
ON sub.assignment_id = a.assignment_id;
	
SELECT * 
FROM student_submission_report




--Query 3 attendance_summary_view - show student, session number, topic, attendance status, notes.

CREATE VIEW attendance_summary_view AS 
SELECT CONCAT(first_name," ",last_name) AS full_name,email,city,session_number,topic,attendance_status,notes FROM students INNER JOIN attendance on students.student_id = attendance.student_id
INNER JOIN sessions ON attendance.session_id = sessions.session_id

--Query 4 missing_feedback_view - show submissions where feedback is NULL or review_status is not reviewed.

CREATE VIEW missing_feedback_view AS
SELECT
    sub.submission_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    a.title AS assignment,
    sub.score,
    sub.feedback,

    CASE
        WHEN sub.feedback IS NULL THEN 'Not Reviewed'
        ELSE 'Reviewed'
    END AS review_status

FROM submissions sub

INNER JOIN students s
ON sub.student_id = s.student_id

INNER JOIN assignments a
ON sub.assignment_id = a.assignment_id

WHERE sub.feedback IS NULL;



--Query 5 student_performance_view - show student, score, and CASE WHEN performance level.


CREATE VIEW student_performance_view AS
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    score,

    CASE
        WHEN score >= 90 THEN 'Excellent'
        WHEN score >= 70 THEN 'Good'
        WHEN score >= 50 THEN 'Average'
        ELSE 'Poor'
    END AS performance_level

FROM students
INNER JOIN submissions 
ON students.student_id = submissions.student_id;



--Query 6 missing_submission_view - show enrolled students who did not submit a specific assignment using LEFT JOIN logic.
SELECT * FROM students INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN programs ON programs.program_id = enrollments.program_id
LEFT JOIN assignments ON assignments.program_id = programs.program_id
WHERE assignment_id IS NULL;