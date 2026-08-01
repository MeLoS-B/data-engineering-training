

---- Create a student program overview view.

CREATE VIEW student_program AS  
SELECT students.*,programs.* FROM students 
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN programs ON enrollments.program_id = programs.program_id
SELECT * FROM student_program




-- Create a student submission overview view.

CREATE VIEW student_submission AS
SELECT 
    students.student_id,
    students.first_name,
    students.last_name,
    submissions.submission_id,
    submissions.assignment_id,
    submissions.submission_date
FROM students
INNER JOIN submissions
ON students.student_id = submissions.student_id;
SELECT * FROM student_submission;




-- Create a student attendance summary view.
CREATE VIEW student_attendance_summary AS
SELECT 
    students.student_id,
    students.first_name,
    students.last_name,
    attendance.attendance_id,
    attendance.session_id,
    attendance.status
FROM students
INNER JOIN attendance 
ON students.student_id = attendance.student_id;
SELECT * FROM student_attendance;



-- Create a student risk analysis view.
CREATE VIEW student_risk_analysis AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,

    COALESCE(sub.submitted_assignments, 0) AS submitted_assignments,
    COALESCE(sub.average_score, 0) AS average_score,
    COALESCE(att.attendance_rate, 0) AS attendance_rate,

    CASE
        WHEN COALESCE(att.attendance_rate, 0) < 60
             OR COALESCE(sub.average_score, 0) < 60
        THEN 'High Risk'

        WHEN COALESCE(att.attendance_rate, 0) < 80
             OR COALESCE(sub.average_score, 0) < 75
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_level

FROM students s

LEFT JOIN (
    SELECT
        student_id,
        COUNT(*) AS submitted_assignments,
        ROUND(AVG(score), 2) AS average_score
    FROM submissions
    WHERE submission_status IN ('submitted', 'reviewed')
    GROUP BY student_id
) sub
ON s.student_id = sub.student_id

LEFT JOIN (
    SELECT
        student_id,
        ROUND(
            SUM(CASE WHEN attendance_status = 'present' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*),
            2
        ) AS attendance_rate
    FROM attendance
    GROUP BY student_id
) att
ON s.student_id = att.student_id;





--


CREATE VIEW student_managment AS 
SELECT 
COUNT(DISTINCT students.student_id) AS total_students,
(SELECT COUNT(CASE WHEN risk_level = 'High Risk' THEN 1 END) FROM student_risk_analysis) AS total_risk_students,
COUNT(CASE WHEN students.student_status = 'active' THEN 1 END) AS total_active_students,
ROUND(AVG(score),2) AS average_score,
ROUND((AVG(CASE WHEN attendance.attendance_status = 'present' THEN 1 ELSE 0 END) * 100 )  ,2) AS average_attendance
FROM students 
LEFT JOIN enrollments ON students.student_id = enrollments.student_id
LEFT JOIN programs ON enrollments.program_id = programs.program_id
LEFT JOIN submissions ON submissions.student_id = students.student_id
LEFT JOIN attendance ON attendance.student_id = students.student_id;




CREATE VIEW assignment_summary AS
SELECT
    COUNT(*) AS total_submissions,
    ROUND(AVG(score),2) AS average_score,
    ROUND(
        COUNT(CASE WHEN submission_status IN ('submitted','reviewed') THEN 1 END)
        * 100.0 / COUNT(*),
        2
    ) AS submission_rate
FROM submissions;


CREATE VIEW attendance_summary AS
SELECT
    ROUND(
        SUM(CASE WHEN attendance_status = 'present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS average_attendance
FROM attendance;


CREATE VIEW risk_summary AS
SELECT
    COUNT(CASE WHEN risk_level = 'High Risk' THEN 1 END) AS high_risk_students,
    COUNT(CASE WHEN risk_level = 'Medium Risk' THEN 1 END) AS medium_risk_students,
    COUNT(CASE WHEN risk_level = 'Low Risk' THEN 1 END) AS low_risk_students
FROM student_risk_analysis;


CREATE VIEW program_summary AS
SELECT
    programs.program_name,
    COUNT(DISTINCT enrollments.student_id) AS students_per_program
FROM programs
LEFT JOIN enrollments
ON programs.program_id = enrollments.program_id
GROUP BY programs.program_name;



CREATE VIEW management_dashboard AS
SELECT
    s.total_students,
    s.active_students,

    a.total_submissions,
    a.average_score,
    a.submission_rate,

    att.average_attendance,

    r.high_risk_students,
    r.medium_risk_students,
    r.low_risk_students

FROM student_summary s

CROSS JOIN assignment_summary a

CROSS JOIN attendance_summary att

CROSS JOIN risk_summary r;