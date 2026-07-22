

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at DATE DEFAULT (CURRENT_DATE())
);

CREATE TABLE instructors (
      instructor_id INT PRIMARY KEY AUTO_INCREMENT,
      full_name VARCHAR(100) NOT NULL,
      specialization VARCHAR(50) NOT NULL
	
);


CREATE TABLE courses (
     course_id INT PRIMARY KEY AUTO_INCREMENT,
     course_name VARCHAR(100),
	 level VARCHAR(30),
     instructor_id INT,
     FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id),
     CONSTRAINT chk_level CHECK (level IN ('Beginner','Intermediate','Advanced'))
);


CREATE TABLE enrollments (
     enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
     student_id INT,
     course_id INT ,
     enrollment_date DATE DEFAULT (CURRENT_DATE()),
     status VARCHAR(20),
     FOREIGN KEY (student_id) REFERENCES students(student_id),
     FOREIGN KEY (course_id) REFERENCES courses(course_id),
     CONSTRAINT chk_status CHECK(status IN ('active','completed','dropped')),
     CONSTRAINT uq_student_course UNIQUE(student_id, course_id)	
);



CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    session_date DATE DEFAULT (CURRENT_DATE),
    attended TINYINT NOT NULL CHECK (attended IN (0, 1)),
    minutes_attended INT DEFAULT 0 CHECK (minutes_attended >= 0),

    FOREIGN KEY (enrollment_id)
        REFERENCES enrollments(enrollment_id)
);


CREATE TABLE assignments (
     assignment_id INT PRIMARY KEY AUTO_INCREMENT,
     course_id INT ,
     title VARCHAR(100) NOT NULL,
     max_score INT,
     due_date DATE DEFAULT (CURRENT_DATE()),
     CONSTRAINT chk_max_score CHECK(max_score > 0),
     FOREIGN KEY (course_id) REFERENCES courses(course_id)
     
     
);


CREATE TABLE submissions (
     submission_id INT PRIMARY KEY AUTO_INCREMENT,
     assignment_id INT,
     student_id INT,
     submitted_at DATE DEFAULT (CURRENT_DATE()),
     score INT,
     status VARCHAR(50),
     CONSTRAINT chk_status CHECK(status IN ('submitted','missing','late')),
     CONSTRAINT chk_score CHECK(score >= 0),
     FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
	 FOREIGN KEY (student_id) REFERENCES  students(student_id)
);