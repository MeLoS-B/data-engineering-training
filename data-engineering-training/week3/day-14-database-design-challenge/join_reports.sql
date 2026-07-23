


--Query 1 Show all students with their programs and instructors.

SELECT * FROM enrollments INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN programs ON enrollments.program_id = programs.program_id
INNER JOIN instructors ON  instructors.instructor_id = enrollments.instructor_id


--Query 2 Show active enrollments only, including student name, program name, instructor name, and status.

SELECT enrollment_date,enrollment_status,enrollments.enrollment_id,students.full_name,programs.program_name,instructors.full_name FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN programs ON enrollments.program_id = programs.program_id
INNER JOIN instructors ON instructors.instructor_id = enrollments.instructor_id
WHERE enrollment_status = 'active'



--Query 3 Show completed enrollments with student and program information.


SELECT * FROM enrollments INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN programs ON enrollments.program_id = programs.program_id
WHERE status = 'active'



--Query 4 Show dropped students and the program they dropped from.




SELECT 
    students.full_name,
    programs.program_name,
    enrollments.enrollment_status
FROM enrollments
INNER JOIN students 
    ON enrollments.student_id = students.student_id
INNER JOIN programs 
    ON enrollments.program_id = programs.program_id
WHERE enrollments.enrollment_status = 'dropped';



--Query 5 Show attendance records with student name, program name, date, and attended value.

SELECT attended,minutes_attended,session_date,students.full_name,programs.program_name FROM attendance INNER JOIN enrollments ON attendance.enrollment_id = enrollments.enrollment_id
INNER JOIN students ON students.student_id = enrollments.student_id
INNER JOIN programs ON enrollments.program_id = programs.program_id


-- Query 6 Show payment records with student name, program name, payment month, status, and amount.

SELECT 
    students.full_name,
    programs.program_name,
    payments.payment_month,
    payments.payment_status,
    payments.amount
FROM payments
INNER JOIN enrollments 
    ON payments.enrollment_id = enrollments.enrollment_id
INNER JOIN students 
    ON students.student_id = enrollments.student_id
INNER JOIN programs 
    ON enrollments.program_id = programs.program_id;





--Query 7 Show each student with city and all programs they are enrolled in.


SELECT students.full_name,students.student_id,students.city,programs.program_name
FROM enrollments
INNER JOIN programs
    ON enrollments.program_id = programs.program_id
INNER JOIN students 
    ON students.student_id = enrollments.student_id



--Query 8 Show instructors and the students/programs they are responsible for.
SELECT
    i.full_name AS instructor,
    s.full_name AS student,
    p.program_name,
    e.enrollment_status
FROM instructors i
INNER JOIN enrollments e
    ON i.instructor_id = e.instructor_id
INNER JOIN students s
    ON e.student_id = s.student_id
INNER JOIN programs p
    ON e.program_id = p.program_id
ORDER BY i.full_name, p.program_name, s.full_name;