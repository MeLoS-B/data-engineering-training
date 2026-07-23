

INSERT INTO students(full_name,email,phone,city,status,registration_date)
VALUES
('Ardit Krasniqi','ardit@gmail.com','044111111','Prishtina','active','2026-01-10'),
('Elira Hoxha','elira@gmail.com','044222222','Prizren','active','2026-01-12'),
('Besim Berisha','besim@gmail.com','044333333','Peja','active','2026-01-15'),
('Sara Gashi','sara@gmail.com','044444444','Mitrovica','inactive','2026-01-18'),
('Luan Shala','luan@gmail.com','044555555','Gjilan','active','2026-02-01'),
('Era Rexha','era@gmail.com','044666666','Ferizaj','active','2026-02-03'),
('Dren Mustafa','dren@gmail.com','044777777','Vushtrri','active','2026-02-05'),
('Anisa Krasniqi','anisa@gmail.com','044888888','Gjakova','active','2026-02-10'),
('Leon Morina','leon@gmail.com','044999999','Podujeva','active','2026-02-12'),
('Sara Kelmendi','sara2@gmail.com','045000000','Lipjan','active','2026-02-15');



INSERT INTO programs(program_name,category,fee,level,start_date,end_date)
VALUES
('Full Stack Development','Programming',500,'Intermediate','2026-01-01','2026-06-30'),
('Data Engineering','Data',600,'Advanced','2026-01-15','2026-07-15'),
('English Language','Language',300,'Beginner','2026-02-01','2026-05-30'),
('After School','Education',200,'Beginner','2026-03-01','2026-06-01');




INSERT INTO instructors(full_name,email,phone,specialization,hire_date,status)
VALUES
('Arben Krasniqi','arben@gmail.com','049111111','Full Stack Development','2025-01-10','active'),
('Linda Hoxha','linda@gmail.com','049222222','Data Engineering','2025-02-15','active'),
('Besnik Berisha','besnik@gmail.com','049333333','English Language','2025-03-20','active');




INSERT INTO enrollments(student_id,program_id,instructor_id,enrollment_date,enrollment_status)
VALUES
(1,1,1,'2026-01-15','active'),
(2,1,1,'2026-01-20','completed'),
(3,2,2,'2026-01-25','active'),
(4,2,2,'2026-02-01','dropped'),
(5,1,1,'2026-02-05','active'),
(6,3,3,'2026-02-10','completed'),
(7,3,3,'2026-02-12','active'),
(8,2,2,'2026-02-15','completed'),
(9,1,1,'2026-02-20','dropped'),
(10,2,2,'2026-02-22','active'),
(1,2,2,'2026-02-25','active'),
(2,3,3,'2026-03-01','completed'),
(5,2,2,'2026-03-05','active'),
(6,1,1,'2026-03-10','completed'),
(7,2,2,'2026-03-15','active');




INSERT INTO attendance(enrollment_id,session_date,attended,minutes_attended)
VALUES

(1,'2026-03-01',1,120),
(1,'2026-03-05',1,120),

(2,'2026-03-01',1,110),
(2,'2026-03-05',1,120),

(3,'2026-03-01',1,120),
(3,'2026-03-05',0,0),

(4,'2026-03-01',0,0),
(4,'2026-03-05',0,0),

(5,'2026-03-01',1,120),
(5,'2026-03-05',1,115),

(6,'2026-03-01',1,90),
(6,'2026-03-05',1,100),

(7,'2026-03-01',0,0),
(7,'2026-03-05',1,60),

(8,'2026-03-01',1,120),
(8,'2026-03-05',1,120),

(9,'2026-03-01',0,0),
(9,'2026-03-05',0,0),

(10,'2026-03-01',1,115),
(10,'2026-03-05',1,120),

(11,'2026-03-01',1,120),
(11,'2026-03-05',1,120),

(12,'2026-03-01',1,100),
(12,'2026-03-05',1,95),

(13,'2026-03-01',1,120),
(13,'2026-03-05',0,0),

(14,'2026-03-01',1,110),
(14,'2026-03-05',1,105),

(15,'2026-03-01',0,0),
(15,'2026-03-05',1,60);




INSERT INTO payments(enrollment_id,payment_month,amount,payment_status,payment_date)
VALUES

(1,'2026-03-01',500,'paid','2026-03-02'),

(2,'2026-03-01',500,'paid','2026-03-02'),

(3,'2026-03-01',600,'paid','2026-03-03'),

(4,'2026-03-01',0,'overdue','2026-03-10'),

(5,'2026-03-01',500,'paid','2026-03-04'),

(6,'2026-03-01',150,'pending','2026-03-15'),

(7,'2026-03-01',300,'paid','2026-03-05'),

(8,'2026-03-01',600,'paid','2026-03-06'),

(9,'2026-03-01',0,'overdue','2026-03-20'),

(10,'2026-03-01',300,'pending','2026-03-18'),

(11,'2026-03-01',600,'paid','2026-03-07'),

(12,'2026-03-01',300,'paid','2026-03-08'),

(13,'2026-03-01',600,'paid','2026-03-09'),

(14,'2026-03-01',500,'paid','2026-03-10');




INSERT INTO risk(
enrollment_id,
academic_risk,
financial_risk,
attendance_percentage,
unpaid_months,
risk_level,
notes
)
VALUES

(1,0,0,95,0,'low','Good performance'),

(3,1,0,50,0,'medium','Low attendance'),

(4,1,1,0,3,'high','Dropped student with unpaid fees'),

(7,1,0,40,0,'medium','Needs attendance improvement'),

(9,1,1,0,2,'high','Dropped and unpaid'),

(10,0,1,80,1,'medium','Payment issue'),

(15,1,0,60,0,'medium','Needs monitoring');