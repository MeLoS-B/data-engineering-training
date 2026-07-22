

-- • Which courses have the most enrollments?

SELECT course_name,COUNT(*) AS count_enrollments_course  FROM enrollments INNER JOIN courses ON enrollments.course_id = courses.course_id
GROUP BY course_name
ORDER BY count_enrollments_course DESC


-- Which students are active in more than one course?

SELECT students.full_name,COUNT(*) AS course_attendance FROM enrollments INNER JOIN courses ON enrollments.course_id = courses.course_id
INNER JOIN students ON enrollments.student_id = students.student_id
GROUP BY students.student_id
HAVING course_attendance > 1


-- Which course has the strongest average attendance?

SELECT AVG(minutes_attended) AS average_attendance,course_name FROM attendance INNER JOIN enrollments ON attendance.enrollment_id = enrollments.enrollment_id
INNER JOIN courses ON enrollments.course_id = courses.course_id
GROUP BY courses.course_id
ORDER BY average_attendance DESC
LIMIT 1;


-- • Which course has the weakest assignment completion?
SELECT 
    courses.course_name,
    COUNT(submissions.submission_id) AS total_submissions,
    SUM(CASE WHEN submissions.status = 'submitted' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN submissions.status IN ('missing','late') THEN 1 ELSE 0 END) AS incomplete,
    ROUND(
        (SUM(CASE WHEN submissions.status = 'submitted' THEN 1 ELSE 0 END) 
        / COUNT(submissions.submission_id)) * 100,
        2
    ) AS completion_percentage
FROM courses
INNER JOIN assignments 
    ON courses.course_id = assignments.course_id
INNER JOIN submissions 
    ON assignments.assignment_id = submissions.assignment_id
GROUP BY courses.course_id, courses.course_name
ORDER BY completion_percentage ASC;


-- Which students need attention because of missing/late submissions?


SELECT students.full_name,students.student_id ,COUNT(CASE WHEN submissions.status = 'late' THEN 1 ELSE 0 END ) as count_late_submissions
FROM submissions INNER JOIN students ON submissions.student_id = students.student_id
GROUP BY students.student_id
ORDER BY count_late_submissions DESC



--   • Which instructor is responsible for the highest number of active enrollments?

SELECT
    instructors.instructor_id,
    instructors.full_name,
    COUNT(*) AS active_enrollments
FROM instructors
INNER JOIN courses
    ON instructors.instructor_id = courses.instructor_id
INNER JOIN enrollments
    ON enrollments.course_id = courses.course_id
WHERE enrollments.status = 'active'
GROUP BY instructors.instructor_id, instructors.full_name
ORDER BY active_enrollments DESC;


-- • Create one final combined report with: student_name, course_name, instructor_name, enrollment_status, total_sessions,attended_sessions, total_minutes, average_score.

SELECT
    students.full_name AS student_name,
    courses.course_name,
    instructors.full_name AS instructor_name,
    enrollments.status AS enrollment_status,

    COUNT(DISTINCT attendance.attendance_id) AS total_sessions,

    SUM(
        CASE
            WHEN attendance.attended = 1 THEN 1
            ELSE 0
        END
    ) AS attended_sessions,

    SUM(attendance.minutes_attended) AS total_minutes,

    ROUND(AVG(submissions.score), 2) AS average_score

FROM students

INNER JOIN enrollments
    ON students.student_id = enrollments.student_id

INNER JOIN courses
    ON enrollments.course_id = courses.course_id

INNER JOIN instructors
    ON courses.instructor_id = instructors.instructor_id

LEFT JOIN attendance
    ON enrollments.enrollment_id = attendance.enrollment_id

LEFT JOIN assignments
    ON courses.course_id = assignments.course_id

LEFT JOIN submissions
    ON assignments.assignment_id = submissions.assignment_id
    AND submissions.student_id = students.student_id

GROUP BY
    students.student_id,
    students.full_name,
    courses.course_id,
    courses.course_name,
    instructors.full_name,
    enrollments.status

ORDER BY
    students.full_name,
    courses.course_name;