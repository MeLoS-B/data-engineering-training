


--Query 1 SELECT city,email FROM students
SELECT city,email FROM students


--Query 2 Show all courses with instructor name and specialization.

SELECT course_id,course_name,level,full_name,specialization FROM courses INNER JOIN instructors ON courses.instructor_id = instructors.instructor_id

--Query 3 Show all assignments with course name and due date.
SELECT course_name,due_date FROM assignments INNER JOIN courses ON assignments.course_id = courses.course_id

--Query 4 Show all enrollments with student name, course name, enrollment date, and status.
SELECT full_name,course_name,enrollment_date,enrollments.status FROM enrollments INNER JOIN students ON enrollments.student_id = students.student_id 
INNER JOIN courses ON courses.course_id = enrollments.course_id


--Query 5 Show only active enrollments.

SELECT * FROM enrollments
WHERE status = 'active'


--Query 6 Show attendance records with student, course, session date, attended, and minutes_attended.


SELECT 
    
    students.full_name,
    courses.course_name,
    attendance.session_date,
    attendance.attended,
    attendance.minutes_attended
FROM attendance
INNER JOIN enrollments 
    ON attendance.enrollment_id = enrollments.enrollment_id
INNER JOIN students 
    ON students.student_id = enrollments.student_id
INNER JOIN courses 
    ON courses.course_id = enrollments.course_id;



--Query 7  Show submissions with student name, assignment title, course name, score, and status.

SELECT students.full_name,assignments.title,courses.course_name,score,submissions.status FROM submissions
INNER JOIN students ON submissions.student_id = students.student_id
INNER JOIN assignments ON assignments.assignment_id = submissions.assignment_id
INNER JOIN courses ON assignments.course_id = courses.course_id


--Query 8 Count students enrolled in each course.


SELECT 
    courses.course_name,
    COUNT(enrollments.student_id) AS total_students
FROM courses
INNER JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name;

--Query 9 Count students enrolled in each course.

SELECT 
    students.student_id,
    students.first_name,
    students.last_name,
    COUNT(enrollments.course_id) AS total_courses
FROM enrollments
INNER JOIN students 
    ON enrollments.student_id = students.student_id
GROUP BY 
    students.student_id,
    students.first_name,
    students.last_name
HAVING COUNT(enrollments.course_id) > 1;



--Query 10 Show students enrolled in more than one course.
SELECT 
    students.student_id,
    students.full_name,
  
    COUNT(enrollments.course_id) AS total_courses
FROM enrollments
INNER JOIN students 
    ON enrollments.student_id = students.student_id
GROUP BY 
    students.student_id,
    students.full_name
HAVING COUNT(enrollments.course_id) > 1;



--Query 11 Show average attendance minutes by course.

SELECT 
    courses.course_name,
    AVG(attendance.minutes_attended) AS average_minutes
FROM attendance
INNER JOIN enrollments
    ON attendance.enrollment_id = enrollments.enrollment_id
INNER JOIN courses
    ON enrollments.course_id = courses.course_id
GROUP BY 
    courses.course_id,
    courses.course_name;



--Query 12 Show average score by course.
SELECT AVG(submissions.score) as average_score_by_course,courses.course_name FROM assignments 
INNER JOIN courses ON assignments.course_id = courses.course_id
INNER JOIN submissions ON assignments.assignment_id = submissions.assignment_id
GROUP BY courses.course_name


--Query 13 Show missing or late submissions with student and course context.




 SELECT
    students.full_name,
    
    courses.course_name,
   
   
    assignments.due_date,
    submissions.submitted_at,
    CASE
        WHEN submissions.submitted_at IS NULL THEN 'Missing'
        WHEN submissions.submitted_at > assignments.due_date THEN 'Late'
    END AS submission_status
FROM submissions
INNER JOIN students
    ON submissions.student_id = students.student_id
INNER JOIN assignments
    ON submissions.assignment_id = assignments.assignment_id
INNER JOIN courses
    ON assignments.course_id = courses.course_id
WHERE submissions.submitted_at IS NULL
   OR submissions.submitted_at > assignments.due_date;



--Query 14 Use LEFT JOIN to show students with no enrollments.
SELECT * FROM students LEFT JOIN enrollments ON students.student_id = enrollments.student_id



--Query 15 Use LEFT JOIN to show assignments with no submissions.

SELECT * FROM assignments LEFT JOIN submissions ON assignments.assignment_id = submissions.assignment_id

