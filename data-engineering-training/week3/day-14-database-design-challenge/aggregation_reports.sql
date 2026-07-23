


--Query 1 Count students by city.
SELECT COUNT(*) as count_city,city FROM students
GROUP BY city


--Query 2 Count enrollments by status.

SELECT COUNT(*) as count_status,enrollment_status FROM enrollments
GROUP BY enrollment_status


--Query 3 Count enrollments by program.

SELECT programs.program_id,COUNT(*) count_enrollments FROM enrollments INNER JOIN programs ON enrollments.program_id = programs.program_id
GROUP BY programs.program_id



--Query 4 Count active enrollments by program.

SELECT programs.program_id,COUNT(*) count_active_enrollments FROM enrollments INNER JOIN programs ON enrollments.program_id = programs.program_id
WHERE enrollments.enrollment_status = 'active'
GROUP BY programs.program_id


--Query 5 Calculate total paid amount by program.




SELECT
    p.program_name,
    SUM(pay.amount) AS total_paid
FROM programs p
INNER JOIN enrollments e
    ON p.program_id = e.program_id
INNER JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status = 'paid'
GROUP BY p.program_name;



-- Query 6  Calculate unpaid or partial amount by program.

SELECT
    p.program_name,
    SUM(pay.amount) AS total_paid
FROM programs p
INNER JOIN enrollments e
    ON p.program_id = e.program_id
INNER JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status in ('overdue','pending')
GROUP BY p.program_name;


--Query 7 Calculate collected revenue by city.
SELECT students.city,SUM(amount) as total_amout_by_city FROM students INNER JOIN enrollments
ON students.student_id = enrollments.student_id
INNER JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
GROUP BY students.city


-- Query 8 Calculate average attendance rate by student.

SELECT 
ROUND(
        (AVG(attended) / COUNT(attendance_id)) * 100,
        2
) AS attendance_rate,
students.student_id FROM attendance INNER JOIN enrollments ON attendance.enrollment_id = enrollments.enrollment_id
INNER JOIN students ON enrollments.student_id = students.student_id
GROUP BY students.student_id;


-- Query 9 Calculate average attendance rate by program.

SELECT 
ROUND(
        (AVG(attended) / COUNT(attendance_id)) * 100,
        2
) AS attendance_rate,
programs.program_id FROM attendance INNER JOIN enrollments ON attendance.enrollment_id = enrollments.enrollment_id
INNER JOIN programs ON enrollments.program_id = programs.program_id
GROUP BY programs.program_id;



--Query 10 Show top 5 students by attendance rate.


SELECT
    s.student_id,
    s.full_name,
    ROUND(
        (SUM(attended) / COUNT(attendance_id)) * 100,
        2
	) AS attendance_rate
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id, s.full_name
ORDER BY attendance_rate DESC
LIMIT 5;


--Query 11 Show top 5 programs by collected revenue.

SELECT SUM(amount) AS full_amount_by_program,programs.program_name,programs.program_id FROM payments INNER JOIN enrollments ON payments.enrollment_id = enrollments.enrollment_id
INNER JOIN students ON enrollments.student_id = enrollments.student_id
INNER JOIN programs ON programs.program_id = enrollments.program_id
GROUP BY programs.program_id
ORDER BY full_amount_by_program DESC
LIMIT 5;



-- Query 12 Show instructors ranked by number of active students.

SELECT COUNT(*) AS number_of_active_students,instructors.instructor_id,instructors.full_name,students.status FROM instructors INNER JOIN enrollments ON instructors.instructor_id = enrollments.instructor_id
INNER JOIN students ON students.student_id = enrollments.student_id
WHERE students.status = 'active'
GROUP BY instructors.instructor_id
ORDER BY number_of_active_students DESC;
  

