-- Test 1: Insert enrollment with student ID that does not exist
-- This should fail because student_id = 99 does not exist in the students table.
-- The enrollments table has a FOREIGN KEY constraint that only allows existing students.


INSERT INTO enrollments (student_id,program_id,instructor_id,enrollment_date,enrollment_status)
VALUES (99,1,2,"2026-04-24","active");


-- Test 2: Insert enrollment with program ID that does not exist
-- This should fail because program_id = 100 does not exist in the programs table.
-- The FOREIGN KEY constraint prevents creating an enrollment for a program that is not registered.


INSERT INTO enrollments (student_id,program_id,instructor_id,enrollment_date,enrollment_status)
VALUES (2,100,2,"2026-04-24","active");


-- Test 3: Insert attendance with enrollment ID that does not exist
-- This should fail because enrollment_id = 200 does not exist in the enrollments table.
-- Attendance records must belong to a real enrollment, so the FOREIGN KEY blocks this insert.


INSERT INTO attendance (enrollment_id,session_date,attended,minutes_attended)
VALUES (200,"2026-05-23",1,95);


-- Test 4: Insert payment with enrollment ID that does not exist
-- This should fail because enrollment_id = 230 is not found in the enrollments table.
-- Payments cannot be created for an enrollment that does not exist.


INSERT INTO payments (enrollment_id,payment_month,amount,payment_status,payment_date)
VALUES (230,"2026-01-09",220,"pending","2026-01-03");


-- Test 5: Insert student with duplicate email
-- This should fail because the email column has a UNIQUE constraint.
-- The database does not allow two students to have the same email address.


INSERT INTO students(full_name,email,phone,city,status,registration_date)
VALUES ("melos beqiri","era@gmail.com","044111222","Vushtrri","2026-04-29");


-- Test 6: Insert payment with negative amount
-- This should fail because amount should have a CHECK constraint like amount >= 0.
-- Negative payments are not valid because a payment value cannot be less than zero.


INSERT INTO payments (enrollment_id,payment_month,amount,payment_status,payment_date)
VALUES (2,"2026-01-14",-200,"overdue","2026-02-19");


-- Test 7: Insert enrollment with invalid status
-- This should fail because enrollment_status has a CHECK constraint.
-- Only allowed values (for example: 'active', 'completed', 'cancelled') can be inserted.
-- The value "not active" is not included in the allowed status list.


INSERT INTO enrollments(student_id,program_id,instructor_id,enrollment_date,enrollment_status)
VALUES (1,1,1,"2026-02-19","not active");