

INSERT INTO students (full_name, city, email) VALUES
('John Smith', 'Prishtina', 'john.smith@gmail.com'),
('Emma Johnson', 'Peja', 'emma.johnson@gmail.com'),
('Michael Brown', 'Prizren', 'michael.brown@gmail.com'),
('Sophia Davis', 'Mitrovica', 'sophia.davis@gmail.com'),
('Daniel Wilson', 'Gjilan', 'daniel.wilson@gmail.com'),
('Olivia Taylor', 'Ferizaj', 'olivia.taylor@gmail.com'),
('James Anderson', 'Vushtrri', 'james.anderson@gmail.com'),
('Isabella Moore', 'Gjakova', 'isabella.moore@gmail.com');

SELECT * FROM students;


INSERT INTO instructors (full_name, specialization) VALUES
('Arben Krasniqi', 'SQL'),
('Sarah Miller', 'Python'),
('David Clark', 'Data Engineering');

SELECT * FROM instructors;


INSERT INTO courses (course_name, level, instructor_id) VALUES
('SQL Fundamentals', 'Beginner', 1),
('Python for Data', 'Intermediate', 2),
('Databricks Essentials', 'Intermediate', 3),
('PySpark Processing', 'Advanced', 3),
('Data Modeling', 'Beginner', 1);

SELECT * FROM courses;


INSERT INTO enrollments (student_id, course_id, status) VALUES
(1,1,'active'),
(1,2,'active'),

(2,1,'completed'),
(2,5,'active'),

(3,2,'active'),
(3,3,'active'),

(4,1,'completed'),

(5,3,'active'),
(5,4,'active'),

(6,2,'completed'),

(7,5,'active'),
(7,1,'active');

SELECT * FROM enrollments;



INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended) VALUES
(1,'2026-07-01',1,120),
(1,'2026-07-03',1,115),

(2,'2026-07-02',1,110),

(3,'2026-07-01',0,0),
(3,'2026-07-04',1,90),

(4,'2026-07-03',1,120),

(5,'2026-07-02',1,100),
(5,'2026-07-05',0,0),

(6,'2026-07-03',1,105),

(7,'2026-07-01',1,120),

(8,'2026-07-04',0,0),
(8,'2026-07-06',1,100),

(9,'2026-07-02',1,118),

(10,'2026-07-03',1,95),

(11,'2026-07-05',1,120),

(12,'2026-07-06',1,110),
(12,'2026-07-08',0,0),
(2,'2026-07-09',1,120);

SELECT * FROM attendance;


INSERT INTO assignments (course_id, title, max_score, due_date) VALUES
(1,'SQL Queries',100,'2026-07-15'),
(1,'Joins Practice',100,'2026-07-20'),
(2,'Python Functions',100,'2026-07-18'),
(3,'Databricks Notebook',100,'2026-07-22'),
(4,'PySpark ETL',100,'2026-07-25'),
(5,'ER Diagram Project',100,'2026-07-30');

SELECT * FROM assignments;


INSERT INTO submissions (assignment_id, student_id, score, status) VALUES
(1,1,95,'submitted'),
(1,2,88,'submitted'),

(2,1,90,'late'),
(2,4,82,'submitted'),

(3,1,97,'submitted'),
(3,3,91,'submitted'),
(3,6,78,'late'),

(4,3,85,'submitted'),
(4,5,80,'late'),

(5,5,92,'submitted'),

(6,2,0,'missing'),
(6,7,89,'submitted');

SELECT * FROM submissions;