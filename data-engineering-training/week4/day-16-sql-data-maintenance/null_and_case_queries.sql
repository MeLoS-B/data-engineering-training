


-- • Find submissions where feedback is missing.
SELECT * FROM submissions
WHERE feedback IS NULL or feedback = ''


-- Find attendance rows where notes are missing.
SELECT * FROM attendance
WHERE notes = ''


-- Create a report that shows "No feedback yet" when feedback is NULL.
SELECT COALESCE(feedback,"No feedback yet") AS feedback_status,submission_id,assignment_id,student_id,github_link,submitted_at,score,feedback FROM submissions;


-- Create a report that shows "No notes" when attendance notes are NULL.

SELECT 
    COALESCE(NULLIF(notes, ''), 'No notes yet') AS notes_status,
    attendance_id,
    session_id,
    student_id,
    status
FROM attendance;




-- Create a performance_level column based on score.

SELECT
    student_id,
    assignment_id,
    score,
    CASE
        WHEN score >= 90 THEN 'Excellent'
        -- If the score is 90 or higher, the student is classified as Excellent because they achieved a very high performance level.

        WHEN score >= 75 THEN 'Good'
        -- If the score is between 75 and 89, the student is classified as Good because they have a strong performance but did not reach the highest level.

        WHEN score >= 60 THEN 'Needs Improvement'
        -- If the score is between 60 and 74, the student is classified as Needs Improvement because they passed but need more practice.

        ELSE 'At Risk'
        -- If the score is below 60, the student is classified as At Risk because their performance is below the expected level.

    END AS performance_level
FROM submissions;



-- Create an attendance_category based on attendance status.

SELECT 
    attendance_id,
    student_id,
    session_id,
    status,
    CASE
        WHEN status = 'present' THEN 'Attended'
        -- If the attendance status is present, the student is classified as Attended because they joined the session.

        WHEN status = 'late' THEN 'Late Arrival'
        -- If the attendance status is late, the student is classified as Late Arrival because they attended but arrived after the scheduled time.

        WHEN status = 'absent' THEN 'Missing'
        -- If the attendance status is absent, the student is classified as Missing because they did not attend the session.

        ELSE 'Unknown'
        -- If the status does not match any expected value, it is classified as Unknown to handle unexpected data.

    END AS attendance_category
FROM attendance;



-- Create an enrollment_risk column based on enrollment status.

SELECT 
    status,
    CASE
        WHEN status = 'active' THEN 'No risk'
        -- If the enrollment status is active, the student is classified as No risk because they are still participating in the program.

        WHEN status = 'dropped' THEN 'Big risk'
        -- If the enrollment status is dropped, the student is classified as Big risk because they left the program.

        ELSE 'Unknown Risk'
        -- If the enrollment status is another value, it is classified as Unknown Risk because the risk level cannot be determined.

    END AS enrollment_risk
FROM enrollments;

