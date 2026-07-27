DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS submissions;


CREATE TABLE students (
     student_id INT PRIMARY KEY AUTO_INCREMENT,
     first_name VARCHAR(50)  NOT NULL,
     last_name VARCHAR(50) NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL,
     city VARCHAR(100),
     created_at DATE DEFAULT (CURRENT_DATE())
);


CREATE TABLE programs (
     program_id INT PRIMARY KEY AUTO_INCREMENT,
     program_name VARCHAR(100) NOT NULL,
     program_type VARCHAR(50),
     start_date DATE ,
     end_date DATE,
     status VARCHAR(30),
	 CONSTRAINT chk_status CHECK (status IN ('active','completed','cancelled'))
     
);


CREATE TABLE enrollments (
      enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
      student_id INT,
      program_id INT,
      enrollment_date DATE,
      status VARCHAR(30),
      FOREIGN KEY (student_id) REFERENCES students(student_id),
      FOREIGN KEY (program_id) REFERENCES programs(program_id),
	  CONSTRAINT chk_enrollmets_status CHECK (status IN ('active','dropped','completed'))

      
);


CREATE TABLE sessions(
     session_id INT PRIMARY KEY AUTO_INCREMENT,
     program_id INT,
     session_title VARCHAR(100),
     session_date DATE,
     session_number INT,
     topic VARCHAR(50),
     FOREIGN KEY (program_id) REFERENCES programs(program_id)
);


CREATE TABLE attendance (

   attendance_id INT PRIMARY KEY AUTO_INCREMENT,
   session_id INT ,
   student_id INT,
   status VARCHAR(50),
   notes VARCHAR(100),
   FOREIGN KEY (session_id) REFERENCES sessions(session_id),
   FOREIGN KEY (student_id) REFERENCES students(student_id),
   CONSTRAINT chk_attendance_status CHECK (status IN ('present','absent','late'))
);


CREATE TABLE assignments (
     assignment_id INT PRIMARY KEY AUTO_INCREMENT,
     program_id INT ,
     title VARCHAR(50),
     day_number INT,
     due_date DATE ,
     max_points INT,
     FOREIGN KEY (program_id) REFERENCES programs(program_id)
    
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
    CONSTRAINT chk_score CHECK(score >= 0 AND score <= 100)
);



INSERT INTO students (first_name, last_name, email, city)
VALUES
('John','Smith','john.smith@email.com','london'),
('Emma','Brown','emma.brown@email.com','Manchester'),
('Michael','Johnson','michael.johnson@email.com','Liverpool'),
('Sophia','Wilson','sophia.wilson@email.com','Birmingham'),
('Daniel','Taylor','daniel.taylor@email.com','Leeds'),
('Olivia','Thomas','olivia.thomas@email.com','Bristol'),
('melos','beqiri','melos@gmail.com','prishtina'),




INSERT INTO programs
(program_name, program_type, start_date, end_date, status)
VALUES
('Data Engineering Bootcamp','Full-Time','2026-07-01','2026-09-30','Active');



INSERT INTO enrollments
(student_id, program_id, enrollment_date, status)
VALUES
(1,1,'2026-07-01','active'),
(2,1,'2026-07-01','active'),
(3,1,'2026-07-01','active'),
(4,1,'2026-07-01','dropped'),
(5,1,'2026-07-01','active'),
(6,1,'2026-07-01','active');


INSERT INTO sessions
(program_id, session_title, session_date, session_number, topic)
VALUES
(1,'Introduction to SQL','2026-07-02',1,'SQL'),
(1,'Database Design','2026-07-03',2,'Normalization'),
(1,'Python ETL Pipeline','2026-07-04',3,'Python');


INSERT INTO attendance
(session_id, student_id, status, notes)
VALUES
(1,1,'Present',''),
(1,2,'Present',''),
(1,3,'Absent','Sick'),
(1,4,'Present',''),
(1,5,'Late','Traffic'),
(1,6,'Present',''),

(2,1,'Present',''),
(2,2,'Present',''),
(2,3,'Present',''),
(2,4,'Absent','Family emergency'),
(2,5,'Present',''),
(2,6,'Late',''),

(3,1,'Present',''),
(3,2,'Present',''),
(3,3,'Present',''),
(3,4,'Present',''),
(3,5,'Absent',''),
(3,6,'Present','');



INSERT INTO assignments
(program_id, title, day_number, due_date, max_points)
VALUES
(1,'SQL Practice',2,'2026-07-05',100),
(1,'Normalization Exercise',3,'2026-07-06',100),
(1,'Python ETL Project',5,'2026-07-08',100);



INSERT INTO submissions
(assignment_id, student_id, github_link, score, feedback)
VALUES
(1,1,'https://github.com/user/sql1',95,'Excellent'),
(1,2,'https://github.com/user/sql2',88,NULL),
(1,3,'https://github.com/user/sql3',79,'Good effort'),
(1,4,'https://github.com/user/sql4',90,NULL),
(1,5,'https://github.com/user/sql5',70,'Needs improvement'),
(1,6,'https://github.com/user/sql6',85,NULL),

(2,1,'https://github.com/user/norm1',96,'Excellent'),
(2,2,'https://github.com/user/norm2',81,NULL),
(2,3,'https://github.com/user/norm3',75,'Good'),
(2,4,'https://github.com/user/norm4',89,NULL),
(2,5,'https://github.com/user/norm5',67,'Improve joins'),
(2,6,'https://github.com/user/norm6',93,'Very good'),

(3,1,'https://github.com/user/etl1',98,'Outstanding'),
(3,2,'https://github.com/user/etl2',87,NULL),
(3,3,'https://github.com/user/etl3',91,'Great work'),
(3,4,'https://github.com/user/etl4',83,NULL),
(3,5,'https://github.com/user/etl5',76,'Needs optimization');