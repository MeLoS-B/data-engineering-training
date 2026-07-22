


-- ============================================
-- 1. Invalid course instructor
-- Insert course with instructor_id = 999
-- Expected: FAIL
-- Reason: instructor_id does not exist in instructors table.
-- ============================================

-- INSERT INTO courses(course_name, level, instructor_id)
-- VALUES ('Advanced SQL', 'Advanced', 999);



-- ============================================
-- 2. Invalid enrollment student
-- Insert enrollment with student_id = 999
-- Expected: FAIL
-- Reason: student does not exist.
-- ============================================

-- INSERT INTO enrollments(student_id, course_id)
-- VALUES (999, 1);



-- ============================================
-- 3. Invalid enrollment course
-- Insert enrollment with course_id = 999
-- Expected: FAIL
-- Reason: course does not exist.
-- ============================================

-- INSERT INTO enrollments(student_id, course_id)
-- VALUES (1, 999);



-- ============================================
-- 4. Duplicate enrollment
-- Same student cannot enroll in same course twice.
-- Expected: FAIL
-- Reason: UNIQUE(student_id, course_id)
-- ============================================


-- First enrollment (should work)
-- INSERT INTO enrollments(student_id, course_id)
-- VALUES (1, 1);


-- Duplicate enrollment (should fail)
-- INSERT INTO enrollments(student_id, course_id)
-- VALUES (1, 1);



-- ============================================
-- 5. Invalid attendance enrollment
-- enrollment_id = 999 does not exist.
-- Expected: FAIL
-- Reason: Foreign Key constraint.
-- ============================================

-- INSERT INTO attendance(
--     enrollment_id,
--     session_date,
--     attended,
--     minutes_attended
-- )
-- VALUES(
--     999,
--     CURRENT_DATE(),
--     1,
--     60
-- );



-- ============================================
-- 6. Invalid attendance minutes
-- minutes_attended cannot be negative.
-- Expected: FAIL
-- Reason: CHECK(minutes_attended >= 0)
-- ============================================

-- INSERT INTO attendance(
--     enrollment_id,
--     session_date,
--     attended,
--     minutes_attended
-- )
-- VALUES(
--     1,
--     CURRENT_DATE(),
--     1,
--     -10
-- );



-- ============================================
-- 7. Invalid course level
-- Allowed:
-- Beginner
-- Intermediate
-- Advanced
--
-- Expected: FAIL
-- Reason: CHECK constraint.
-- ============================================

-- INSERT INTO courses(
--     course_name,
--     level,
--     instructor_id
-- )
-- VALUES(
--     'Cyber Security',
--     'Expert',
--     1
-- );



-- ============================================
-- 8. Invalid submission assignment
-- assignment_id = 999 does not exist.
-- Expected: FAIL
-- Reason: Foreign Key constraint.
-- ============================================

-- INSERT INTO submissions(
--     assignment_id,
--     student_id,
--     score
-- )
-- VALUES(
--     999,
--     1,
--     80
-- );



-- ============================================
-- 9. Invalid submission score
--
-- Trying score bigger than max_score.
-- Example:
-- max_score = 100
-- score = 150
--
-- Expected: FAIL if trigger exists.
--
-- Explanation:
-- MySQL CHECK cannot compare values
-- from another table.
--
-- A trigger is needed:
-- submissions.score <= assignments.max_score
-- ============================================


-- INSERT INTO submissions(
--     assignment_id,
--     student_id,
--     score
-- )
-- VALUES(
--     1,
--     1,
--     150
-- );



-- ============================================
-- 10. Duplicate email
-- Expected: FAIL
-- Reason: students.email has UNIQUE constraint.
-- ============================================


-- First student
-- INSERT INTO students(
--     first_name,
--     last_name,
--     email,
--     city
-- )
-- VALUES(
--     'Test',
--     'User',
--     'test@gmail.com',
--     'Prishtina'
-- );


-- Second student with same email
-- Expected to fail
-- INSERT INTO students(
--     first_name,
--     last_name,
--     email,
--     city
-- )
-- VALUES(
--     'Another',
--     'User',
--     'test@gmail.com',
--     'Prizren'
-- );



