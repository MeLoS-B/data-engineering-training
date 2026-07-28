
-- ==========================================
-- 7. ALTER TABLE - Add missing fields
-- ==========================================

ALTER TABLE students
ADD COLUMN phone_number VARCHAR(20),
ADD COLUMN github_username VARCHAR(100);


ALTER TABLE submissions
ADD COLUMN review_status VARCHAR(50);



-- ==========================================
-- 8. UPDATE - Fill new fields
-- ==========================================

UPDATE students
SET 
    phone_number = '044123456',
    github_username = 'arta-dev'
WHERE student_id = 1;


UPDATE students
SET 
    phone_number = '049555222',
    github_username = 'blend-dev'
WHERE student_id = 2;


UPDATE students
SET 
    phone_number = '045777888',
    github_username = 'dren-dev'
WHERE student_id = 3;



UPDATE submissions
SET review_status = 'Reviewed'
WHERE feedback IS NOT NULL;


UPDATE submissions
SET review_status = 'Pending Review'
WHERE feedback IS NULL;



-- ==========================================
-- 12. CREATE FINAL REPORT VIEW
-- ==========================================

CREATE VIEW final_student_progress_view AS

SELECT

    s.student_id,

    CONCAT(s.first_name,' ',s.last_name) AS student_name,

    s.city,

    s.email,

    s.phone_number,

    s.github_username,

    a.title AS assignment_name,

    sub.score,

    COALESCE(sub.feedback, 'No feedback yet') AS feedback,


    CASE
        WHEN sub.score >= 90 THEN 'Excellent'
        WHEN sub.score >= 70 THEN 'Good'
        WHEN sub.score >= 50 THEN 'Average'
        WHEN sub.score IS NULL THEN 'No Submission'
        ELSE 'Poor'
    END AS performance_level,


    COALESCE(sub.review_status, 'Not Reviewed') AS review_status


FROM students s

LEFT JOIN submissions sub
ON s.student_id = sub.student_id

LEFT JOIN assignments a
ON sub.assignment_id = a.assignment_id;



-- ==========================================
-- Test the view
-- ==========================================

SELECT *
FROM final_student_progress_view;



-- ==========================================
-- 13. CREATE INDEXES
-- ==========================================

CREATE INDEX idx_submissions_student_id
ON submissions(student_id);


CREATE INDEX idx_submissions_assignment_id
ON submissions(assignment_id);