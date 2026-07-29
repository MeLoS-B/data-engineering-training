
use projectdb;
CREATE TABLE students (
     student_id INT PRIMARY KEY AUTO_INCREMENT,
     first_name VARCHAR(30) NOT NULL,
     last_name VARCHAR(30) NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL,
     phone_number VARCHAR(20),
     date_of_birth DATE ,
     city VARCHAR(30) NOT NULL,
     registration_date DATE DEFAULT (CURRENT_DATE()),
     student_status VARCHAR(20) NOT NULL,
     CONSTRAINT chk_student_status CHECK(student_status IN ('active','inactive','dropped','completed'))
);


CREATE TABLE programs (
      program_id INT PRIMARY KEY AUTO_INCREMENT,
      program_name VARCHAR(60) NOT NULL,
      program_type VARCHAR(60),
      start_date DATE,
      end_date DATE,
      program_status VARCHAR(30) NOT NULL,
      CONSTRAINT chk_program_status CHECK (program_status IN ('planned','active','completed','cancelled'))
);

CREATE TABLE enrollments (
      enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
      student_id INT NOT NULL,
      program_id INT NOT NULL,
      enrollment_date DATE,
      enrollment_status VARCHAR(30) NOT NULL,
      FOREIGN KEY (student_id) REFERENCES students(student_id),
      FOREIGN KEY (program_id) REFERENCES programs(program_id),
      CONSTRAINT chk_enrollment_status CHECK(enrollment_status IN ('active','completed','dropped','withdrawn')),
      CONSTRAINT uq_student_program UNIQUE(student_id,program_id)							
);

CREATE TABLE staff (
      staff_id INT PRIMARY KEY AUTO_INCREMENT,
      first_name VARCHAR(40) NOT NULL,
      last_name VARCHAR(40) NOT NULL,
      email VARCHAR(80) UNIQUE,
      role VARCHAR(30)  NOT NULL,
      hire_date DATE DEFAULT (CURRENT_DATE()),
      staff_status VARCHAR(30) NOT NULL,
      CONSTRAINT chk_role CHECK (role IN ('instructor','mentor','support')),
      CONSTRAINT chk_staff_status CHECK (staff_status IN ('active','inactive','on_leave','terminated'))
      
);


CREATE TABLE program_staff(
      program_staff_id INT PRIMARY KEY AUTO_INCREMENT,
      program_id INT,
      staff_id INT,
      assigned_role VARCHAR(30),
      assigned_date DATE DEFAULT (CURRENT_DATE()),
      FOREIGN KEY (program_id) REFERENCES programs(program_id),
      FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
      CONSTRAINT chk_assigned_role CHECK(assigned_role IN ('instructor','mentor','support')),
      CONSTRAINT uq_instructor_program UNIQUE(program_id,staff_id)
);


CREATE TABLE sessions (
     session_id INT PRIMARY KEY AUTO_INCREMENT,
     program_id INT,
     session_title VARCHAR(50) NOT NULL,
     session_date DATE,
     session_topic VARCHAR(50),
     session_duration INT,
     FOREIGN KEY (program_id) REFERENCES programs(program_id),
     CONSTRAINT chk_session_duration CHECK(session_duration > 0)
);


CREATE TABLE attendance (
     attendance_id INT PRIMARY KEY AUTO_INCREMENT,
     student_id INT,
     session_id INT,
     attendance_status VARCHAR(30),
     check_in_time BOOLEAN DEFAULT TRUE,
     notes VARCHAR(200),
     FOREIGN KEY (student_id) REFERENCES students(student_id),
     FOREIGN KEY (session_id) REFERENCES sessions(session_id),
     CONSTRAINT chk_attendance_status CHECK(attendance_status IN ('present','absent','late','excused'))
);


CREATE TABLE assignments (
      assignment_id INT PRIMARY KEY AUTO_INCREMENT,
      program_id INT,
      assignment_title VARCHAR(60),
      assignment_type VARCHAR(60),
      due_date DATE,
      max_score INT,
      assignment_status VARCHAR(30),
      FOREIGN KEY (program_id) REFERENCES programs(program_id),
      CONSTRAINT chk_max_score CHECK(max_score BETWEEN 0 AND 100),
      CONSTRAINT assignment_status CHECK(assignment_status IN ('open','closed','archived'))
);


CREATE TABLE submissions (
      submission_id INT PRIMARY KEY AUTO_INCREMENT,
      assignment_id INT,
      student_id INT,
      github_link VARCHAR(250),
      submission_date DATE,
      score INT,
      feedback VARCHAR(80),
      submission_status VARCHAR(30),
      FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
	  FOREIGN KEY (student_id) REFERENCES students(student_id),
      CONSTRAINT chk_score CHECK(score BETWEEN 0 AND 100),
      CONSTRAINT chk_submission_status CHECK(submission_status IN ('submitted','late','missing','reviewed'))
      
);




INSERT INTO students 
(first_name, last_name, email, phone_number, date_of_birth, city, student_status)
VALUES
('Ardit','Krasniqi','ardit.krasniqi@gmail.com','044111111','2005-03-15','Prishtina','active'),
('Luan','Berisha','luan.berisha@gmail.com','044222222','2004-07-21','Prizren','active'),
('Era','Hoxha','era.hoxha@gmail.com','044333333','2005-01-10','Peja','completed'),
('Dren','Gashi','dren.gashi@gmail.com','044444444','2006-05-18','Vushtrri','active'),
('Sara','Rama','sara.rama@gmail.com','044555555','2005-11-30','Ferizaj','dropped'),
('Blerim','Kelmendi','blerim.kelmendi@gmail.com','044666666','2004-09-12','Gjilan','active'),
('Elira','Shala','elira.shala@gmail.com','044777777','2005-02-25','Prishtina','completed'),
('Gent','Morina','gent.morina@gmail.com','044888888','2006-08-05','Mitrovica','inactive'),
('Rina','Bytyqi','rina.bytyqi@gmail.com','044999999','2005-06-17','Prizren','active'),
('Valon','Zeka','valon.zeka@gmail.com','045000000','2004-12-09','Peja','active');


INSERT INTO programs
(program_name, program_type, start_date, end_date, program_status)
VALUES
('Data Engineering Bootcamp','Technical Training','2026-01-10','2026-04-10','completed'),
('Full Stack Development','Technical Training','2026-05-01','2026-08-01','active');


INSERT INTO staff
(first_name,last_name,email,role,staff_status)
VALUES
('Arben','Krasniqi','arben@unitytechhub.com','instructor','active'),
('Mira','Berisha','mira@unitytechhub.com','instructor','active'),
('Leon','Hoxha','leon@unitytechhub.com','mentor','active'),
('Sara','Gashi','sara.staff@unitytechhub.com','support','active');


INSERT INTO enrollments
(student_id,program_id,enrollment_date,enrollment_status)
VALUES
(1,1,'2026-01-10','completed'),
(2,1,'2026-01-10','completed'),
(3,1,'2026-01-10','completed'),
(4,1,'2026-01-10','active'),
(5,1,'2026-01-10','dropped'),
(6,1,'2026-01-10','active'),
(7,2,'2026-05-01','active'),
(8,2,'2026-05-01','withdrawn'),
(9,2,'2026-05-01','active'),
(10,2,'2026-05-01','active'),
(1,2,'2026-05-01','active');


INSERT INTO program_staff
(program_id,staff_id,assigned_role)
VALUES
(1,1,'instructor'),
(1,3,'mentor'),
(1,4,'support'),
(2,2,'instructor'),
(2,3,'mentor');


INSERT INTO sessions
(program_id,session_title,session_date,session_topic,session_duration)
VALUES
(1,'SQL Fundamentals','2026-01-15','SQL Basics',120),
(1,'Database Design','2026-01-25','ER Modeling',150),
(1,'Python ETL','2026-02-05','Data Pipelines',180),
(1,'PySpark Introduction','2026-02-20','Big Data Processing',180),
(2,'React Fundamentals','2026-05-10','Frontend Development',150),
(2,'API Development','2026-05-20','Backend APIs',180);


INSERT INTO attendance
(student_id,session_id,attendance_status,notes)
VALUES
(1,1,'present','Good participation'),
(1,2,'present','Excellent work'),
(1,3,'present','Completed exercises'),
(2,1,'present','Active student'),
(2,2,'late','Arrived late'),
(2,3,'present','Good progress'),
(3,1,'present','Completed program'),
(3,2,'present','Strong performance'),
(4,1,'absent','Missed session'),
(4,2,'late','Late arrival'),
(5,1,'absent','Dropped later'),
(6,3,'excused','Medical reason'),
(7,5,'present','Good start'),
(8,5,'absent','Inactive student'),
(9,5,'present','Good performance'),
(10,6,'late','Needs improvement');


INSERT INTO assignments
(program_id,assignment_title,assignment_type,due_date,max_score,assignment_status)
VALUES
(1,'SQL Queries Challenge','Practice Task','2026-01-20',100,'closed'),
(1,'Database Design Project','Project','2026-02-01',100,'closed'),
(1,'Python ETL Pipeline','Project','2026-02-15',100,'closed'),
(1,'PySpark Data Processing','Practice Task','2026-03-01',100,'open'),
(2,'React Dashboard Project','Project','2026-06-01',100,'open'),
(2,'REST API Task','Live Coding Check','2026-06-15',100,'open');


INSERT INTO submissions
(assignment_id,student_id,github_link,submission_date,score,feedback,submission_status)
VALUES
(1,1,'https://github.com/ardit/sql-task','2026-01-18',95,'Excellent SQL skills','reviewed'),
(1,2,'https://github.com/luan/sql-task','2026-01-19',75,'Good work','reviewed'),
(1,4,'https://github.com/dren/sql-task','2026-01-22',45,'Needs more practice','late'),
(1,5,'https://github.com/sara/sql-task','2026-01-20',60,NULL,'submitted'),

(2,1,'https://github.com/ardit/database-project','2026-02-01',90,'Great design','reviewed'),
(2,2,'https://github.com/luan/database-project','2026-02-02',70,NULL,'reviewed'),
(2,6,'https://github.com/blerim/database-project','2026-02-04',50,'Needs improvement','late'),

(3,1,'https://github.com/ardit/python-etl','2026-02-15',98,'Outstanding pipeline','reviewed'),
(3,3,'https://github.com/era/python-etl','2026-02-15',88,'Very good','reviewed'),
(3,4,'https://github.com/dren/python-etl','2026-02-20',40,'Requires support','late'),

(5,7,'https://github.com/elira/react-dashboard','2026-06-01',85,NULL,'submitted'),
(5,9,'https://github.com/rina/react-dashboard','2026-06-02',92,'Excellent project','reviewed'),

(6,10,'https://github.com/valon/api-task','2026-06-16',65,'Average performance','reviewed');