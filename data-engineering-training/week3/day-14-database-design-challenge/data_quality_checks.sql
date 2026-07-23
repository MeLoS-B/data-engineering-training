

-- Query 1 Find students with no enrollments.

SELECT * FROM students LEFT JOIN enrollments ON students.student_id = enrollments.student_id
WHERE enrollments.enrollment_id IS NULL


-- Query 2 Find programs with no enrollments.

SELECT * FROM programs LEFT JOIN enrollments ON programs.program_id = enrollments.program_id
WHERE enrollments.enrollment_id IS NULL


-- Query 3 Find enrollments with no payment record.

SELECT * FROM enrollments LEFT JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_id IS NULL


-- Query 4 Find enrollments with no attendance records.

SELECT * FROM enrollments LEFT JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
WHERE attendance.attendance_id IS NULL


-- Query 5 Find active students with unpaid or partial payments.

SELECT
    s.student_id,
    s.full_name,
    s.city,
    p.payment_status,
    p.amount
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
LEFT JOIN payments p
    ON e.enrollment_id = p.enrollment_id
WHERE s.status = 'active'
AND (p.payment_status IN ('pending','overdue') OR p.payment_status IS NULL);


-- Query 6 Find students with low attendance but paid payment.

SELECT ROUND(
    (SUM(attendance.attended) / COUNT(attendance.attendance_id)) * 100
,2) as total_attendance,students.full_name
FROM students LEFT JOIN enrollments ON students.student_id = enrollments.student_id 
LEFT JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
LEFT JOIN attendance ON attendance.enrollment_id = enrollments.enrollment_id
WHERE payment_status = 'paid'
GROUP BY students.full_name
ORDER BY total_attendance


-- Query 7 Find students with high attendance but unpaid or partial payment.

SELECT ROUND(
    (SUM(attendance.attended) / COUNT(attendance.attendance_id)) * 100
,2) as total_attendance,students.full_name
FROM students LEFT JOIN enrollments ON students.student_id = enrollments.student_id 
LEFT JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
LEFT JOIN attendance ON attendance.enrollment_id = enrollments.enrollment_id
WHERE payment_status IN ('pending','overdue')
GROUP BY students.full_name
ORDER BY total_attendance DESC

-- Query 8 Find dropped students who still have paid or partial payment records.

SELECT
    s.student_id,
    s.full_name,
    p.program_name,
    e.enrollment_status,
    pay.payment_status,
    pay.amount
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
LEFT JOIN programs p
    ON e.program_id = p.program_id
LEFT JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE e.enrollment_status = 'dropped'
AND pay.payment_status IN ('paid','pending');


-- Query 9 Find instructors with no active students.

SELECT instructors.instructor_id,instructors.full_name FROM instructors LEFT JOIN	enrollments ON instructors.instructor_id  = enrollments.instructor_id 
LEFT JOIN students ON students.student_id  = enrollments.student_id AND students.status = 'active'
GROUP BY instructors.instructor_id
HAVING COUNT(students.student_id) = 0


-- Query 10 Find any records that look risky, inconsistent, or incomplete based on your own design.

SELECT
    s.student_id,
    s.full_name,
    p.program_name,
    pay.payment_status,
    pay.amount
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN programs p
    ON e.program_id = p.program_id
INNER JOIN payments pay
    ON e.enrollment_id = pay.enrollment_id
WHERE s.status = 'active'
AND pay.payment_status IN ('pending','overdue');