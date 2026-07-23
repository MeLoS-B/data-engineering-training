


--Query 1 Show programs with more than 3 enrollments.


SELECT programs.program_id,programs.program_name,COUNT(enrollments.enrollment_id) AS total_enrollments FROM programs INNER JOIN enrollments ON programs.program_id = enrollments.program_id
GROUP BY programs.program_id
HAVING total_enrollments > 3


--Query 2 Show cities with more than 2 students.


SELECT city,COUNT(*) AS total_students FROM students
GROUP BY city
HAVING total_students > 2


--Query 3 Show students with attendance rate below 70%.

 SELECT
    s.student_id,
    s.full_name,
    ROUND(
        (SUM(a.attended) / COUNT(a.attendance_id)) * 100,
        2
    ) AS attendance_rate
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id, s.full_name
HAVING attendance_rate < 70;


--Query 4 Show programs with collected revenue greater than 300.

SELECT SUM(amount) AS total_amount,programs.program_name,programs.program_id FROM programs INNER JOIN enrollments ON programs.program_id = enrollments.program_id
INNER JOIN payments  ON payments.enrollment_id = enrollments.enrollment_id
GROUP BY programs.program_id
HAVING total_amount > 300


--Query 5 Show instructors with more than 3 active enrollments.

SELECT instructors.instructor_id,instructors.full_name,COUNT(enrollment_id) AS total_enrollments FROM instructors INNER JOIN enrollments ON instructors.instructor_id = enrollments.instructor_id
GROUP BY instructors.instructor_id
HAVING total_enrollments > 3


--Query 6 Show programs with unpaid or partial payment amount greater than 100.



SELECT
    p.program_id,
    p.program_name,
    SUM(pay.amount) AS unpaid_amount
FROM programs p
INNER JOIN enrollments e
    ON p.program_id = e.program_id
INNER JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE pay.payment_status IN ('pending','overdue')
GROUP BY p.program_id, p.program_name
HAVING SUM(pay.amount) > 100;


