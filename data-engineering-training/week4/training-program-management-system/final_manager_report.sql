-- FINAL MANAGER REPORT




SELECT
    CONCAT(students.first_name, ' ', students.last_name) AS student_name,
    programs.program_name,

    attendance_summary.attendance_rate,

    score_summary.average_score,

    submission_summary.missing_submissions,

    submission_summary.missing_feedback,


    CASE
        WHEN attendance_summary.attendance_rate IS NULL 
             AND score_summary.average_score IS NULL
        THEN 'Not enough data'

        WHEN attendance_summary.attendance_rate >= 80 
             AND score_summary.average_score >= 80
        THEN 'Invite to next phase'

        WHEN attendance_summary.attendance_rate < 60
        THEN 'Follow up individually'

        WHEN score_summary.average_score < 60
        THEN 'Needs extra practice'

        ELSE 'Schedule live coding check'
    END AS recommended_next_action,


    CASE
        WHEN attendance_summary.attendance_rate >= 80
             AND score_summary.average_score >= 80
        THEN 'Ready'

        WHEN attendance_summary.attendance_rate < 60
        THEN 'At Risk'

        WHEN score_summary.average_score < 60
        THEN 'Needs Improvement'

        ELSE 'Review'
    END AS final_status


FROM students


LEFT JOIN enrollments
ON students.student_id = enrollments.student_id


LEFT JOIN programs
ON enrollments.program_id = programs.program_id


LEFT JOIN
(
    SELECT
        student_id,
        ROUND(
            SUM(CASE 
                WHEN attendance_status = 'present' 
                THEN 1 
                ELSE 0 
            END)
            /
            COUNT(attendance_id) * 100,
        2) AS attendance_rate

    FROM attendance

    GROUP BY student_id

) AS attendance_summary

ON students.student_id = attendance_summary.student_id



LEFT JOIN
(
    SELECT
        student_id,
        ROUND(AVG(score),2) AS average_score

    FROM submissions

    GROUP BY student_id

) AS score_summary

ON students.student_id = score_summary.student_id



LEFT JOIN
(
    SELECT
        students.student_id,

        COUNT(
            CASE 
                WHEN submissions.submission_id IS NULL 
                THEN 1 
            END
        ) AS missing_submissions,


        COUNT(
            CASE
                WHEN submissions.feedback IS NULL
                THEN 1
            END
        ) AS missing_feedback


    FROM students

    LEFT JOIN submissions
    ON students.student_id = submissions.student_id


    GROUP BY students.student_id

) AS submission_summary

ON students.student_id = submission_summary.student_id;






