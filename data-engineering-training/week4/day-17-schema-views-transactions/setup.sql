-- Drop child tables first
DROP TABLE IF EXISTS submissions;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS programs;



CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    created_at DATE DEFAULT (CURRENT_DATE())
);



CREATE TABLE programs (
    program_id INT PRIMARY KEY AUTO_INCREMENT,
    program_name VARCHAR(100),
    program_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    status VARCHAR(50)
);



CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    program_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE()),
    status VARCHAR(50),

    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (program_id) REFERENCES programs(program_id)
);



CREATE TABLE sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    program_id INT,
    session_title VARCHAR(100),
    session_date DATE DEFAULT (CURRENT_DATE()),
    session_number INT,
    topic VARCHAR(50),

    FOREIGN KEY (program_id) REFERENCES programs(program_id)
);



CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    student_id INT,

    attendance_status VARCHAR(20)
        CHECK (attendance_status IN ('Present','Absent','Late')),

    notes VARCHAR(100),

    FOREIGN KEY (session_id) REFERENCES sessions(session_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);



CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    program_id INT,
    title VARCHAR(100),
    day_number INT,
    due_date DATE,
    max_points INT,

    FOREIGN KEY (program_id) REFERENCES programs(program_id),

    CONSTRAINT chk_max_points
        CHECK(max_points BETWEEN 0 AND 100),

    CONSTRAINT chk_day_number
        CHECK(day_number BETWEEN 1 AND 7)
);



CREATE TABLE submissions (
    submission_id INT PRIMARY KEY AUTO_INCREMENT,
    assignment_id INT,
    student_id INT,
    github_link VARCHAR(250),
    submitted_at DATE DEFAULT (CURRENT_DATE()),
    score INT,
    feedback VARCHAR(100),

    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),

    CONSTRAINT chk_score
        CHECK(score BETWEEN 0 AND 100)
);



INSERT INTO students (first_name,last_name,email,city)
VALUES
('Arta','Berisha','arta@gmail.com','Prishtina'),
('Blend','Krasniqi','blend@gmail.com','Mitrovica'),
('Dren','Gashi','dren@gmail.com','Peja'),
('Era','Hoxha','era@gmail.com','Prizren'),
('Luan','Shala','luan@gmail.com','Gjilan'),
('Sara','Mustafa','sara@gmail.com','Vushtrri');



INSERT INTO programs
(program_name,program_type,start_date,end_date,status)
VALUES
('Data Engineering Bootcamp','Full-Time','2026-07-01','2026-09-30','Active');



INSERT INTO enrollments
(student_id,program_id,status)
VALUES
(1,1,'Active'),
(2,1,'Active'),
(3,1,'Active'),
(4,1,'Active'),
(5,1,'Active'),
(6,1,'Active');



INSERT INTO sessions
(program_id,session_title,session_number,topic)
VALUES
(1,'Python Basics',1,'Python'),
(1,'SQL Fundamentals',2,'SQL'),
(1,'Data Cleaning',3,'Python'),
(1,'Joins and Aggregation',4,'SQL');



INSERT INTO assignments
(program_id,title,day_number,due_date,max_points)
VALUES
(1,'Python Variables',1,'2026-07-03',100),
(1,'SQL SELECT Practice',2,'2026-07-05',100),
(1,'Data Cleaning Task',3,'2026-07-08',100),
(1,'JOIN Challenge',4,'2026-07-10',100);



INSERT INTO attendance
(session_id,student_id,attendance_status,notes)
VALUES
(1,1,'Present','Excellent participation'),
(1,2,'Present',NULL),
(1,3,'Late','Arrived 15 minutes late'),
(1,4,'Absent','Sick'),
(1,5,'Present',NULL),
(1,6,'Present',''),

(2,1,'Present',NULL),
(2,2,'Absent','Family emergency'),
(2,3,'Present',''),
(2,4,'Present',NULL),
(2,5,'Late','Traffic'),
(2,6,'Present',NULL),

(3,1,'Present',''),
(3,2,'Present',NULL),
(3,3,'Present','Good work'),
(3,4,'Absent',NULL),
(3,5,'Present',''),
(3,6,'Late','Late arrival'),

(4,1,'Present',NULL),
(4,2,'Present',''),
(4,3,'Present',NULL),
(4,4,'Present','Improved'),
(4,5,'Absent','Travel'),
(4,6,'Present',NULL);



INSERT INTO submissions
(assignment_id,student_id,github_link,score,feedback)
VALUES
(1,1,'https://github.com/arta/python-task',95,'Excellent work'),
(1,2,'https://github.com/blend/python-task',82,NULL),
(1,3,'https://github.com/dren/python-task',74,'Needs cleaner code'),
(1,4,'https://github.com/era/python-task',91,'Very good'),
(1,5,'https://github.com/luan/python-task',66,NULL),
(1,6,'https://github.com/sara/python-task',88,'Well done'),

(2,1,'https://github.com/arta/sql-task',98,'Outstanding'),
(2,2,'https://github.com/blend/sql-task',80,NULL),
(2,3,'https://github.com/dren/sql-task',76,'Good joins'),
(2,4,'https://github.com/era/sql-task',90,'Great work'),
(2,5,'https://github.com/luan/sql-task',69,NULL),
(2,6,'https://github.com/sara/sql-task',84,'Nice'),

(3,1,'https://github.com/arta/cleaning',100,'Perfect'),
(3,2,'https://github.com/blend/cleaning',87,'Well structured'),
(3,3,'https://github.com/dren/cleaning',79,NULL),
(3,4,'https://github.com/era/cleaning',92,'Excellent'),
(3,5,'https://github.com/luan/cleaning',70,NULL),
(3,6,'https://github.com/sara/cleaning',85,'Good'),

(4,1,'https://github.com/arta/joins',97,'Excellent'),
(4,2,'https://github.com/blend/joins',83,NULL),
(4,3,'https://github.com/dren/joins',78,'Nice effort'),
(4,4,'https://github.com/era/joins',94,'Great'),
(4,5,'https://github.com/luan/joins',72,NULL),
(4,6,'https://github.com/sara/joins',89,'Very good');