

-- Show all students with the programs they are enrolled in.

SELECT * FROM students INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN programs ON enrollments.program_id = programs.program_id



-- Show all programs with their instructors or mentors.
SELECT * FROM programs INNER JOIN program_staff ON programs.program_id = program_staff.program_id
INNER JOIN staff ON program_staff.staff_id = staff.staff_id


-- Show all sessions with program information.
SELECT * FROM sessions INNER JOIN programs ON sessions.program_id = programs.program_id




-- Show attendance with student name and session information.
SELECT * FROM attendance INNER JOIN students ON attendance.student_id = students.student_id 
INNER JOIN sessions ON attendance.session_id = sessions.session_id



-- Show submissions with student name and assignment information.

SELECT * FROM submissions INNER JOIN students ON submissions.student_id = students.student_id
INNER JOIN assignments ON assignments.assignment_id = submissions.assignment_id


-- Show all active students.
SELECT * FROM students
WHERE student_status = 'active'



-- Show all dropped students.

SELECT * FROM students
WHERE student_status = 'dropped'



-- Show all reviewed submissions.
SELECT * FROM submissions
WHERE submission_status = 'reviewed'




-- Show students who are enrolled but do not have much activity yet.
SELECT * FROM students INNER JOIN enrollments ON students.student_id = enrollments.student_id
WHERE student_status != 'active'




-- Show a clean list that management could read without IDs only.
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    p.program_name,
    e.enrollment_status,
    e.enrollment_date
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN programs p
ON e.program_id = p.program_id
ORDER BY student_name;