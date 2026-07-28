

-- indexes.sql

-- Index on submissions.student_id
-- Helps find all submissions made by a specific student faster.
-- Useful when joining submissions with students table.
CREATE INDEX idx_submissions_student_id
ON submissions(student_id);



-- Index on submissions.assignment_id
-- Helps quickly find all submissions belonging to a specific assignment.
-- Useful for reports like "show all students who submitted Assignment X".
CREATE INDEX idx_submissions_assignment_id
ON submissions(assignment_id);



-- Index on attendance.session_id
-- Helps retrieve attendance records for a specific session faster.
-- Useful when checking who attended a particular class/session.
CREATE INDEX idx_attendance_session_id
ON attendance(session_id);



-- Index on attendance.student_id
-- Helps find all attendance records for one student faster.
-- Useful for attendance reports and student performance tracking.
CREATE INDEX idx_attendance_student_id
ON attendance(student_id);



-- Index on enrollments.program_id
-- Helps find all students enrolled in a specific program faster.
-- Useful when generating program-level reports.
CREATE INDEX idx_enrollments_program_id
ON enrollments(program_id);