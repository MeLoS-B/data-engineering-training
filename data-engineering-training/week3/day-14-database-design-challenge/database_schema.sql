

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
	phone VARCHAR(20) UNIQUE,
    city VARCHAR(50) NOT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    registration_date DATE DEFAULT (CURRENT_DATE())
  
    
);


CREATE TABLE programs (
    program_id INT PRIMARY KEY AUTO_INCREMENT,
    program_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    fee DECIMAL(10,2),
    level VARCHAR(20),
    start_date DATE DEFAULT(CURRENT_DATE()),
    end_date DATE 
    
);


CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    specialization VARCHAR(100),
    hire_date DATE DEFAULT (CURRENT_DATE()),
    status ENUM('active','inactive') DEFAULT 'active'
    
);


CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    program_id INT,
    instructor_id INT,
    enrollment_date DATE DEFAULT(CURRENT_DATE()),
    enrollment_status ENUM('active','completed','dropped') DEFAULT 'active',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (program_id) REFERENCES programs(program_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);


CREATE TABLE attendance(
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT,
    session_date DATE NOT NULL,
    attended BOOLEAN DEFAULT FALSE,
    minutes_attended INT,
	CONSTRAINT chk_minutes_attended CHECK(minutes_attended >= 0),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
    
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT,
    payment_month DATE NOT NULL,
    amount DECIMAL(10,2),
    payment_status ENUM('paid','pending','overdue') DEFAULT 'pending',
    payment_date DATE NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);


CREATE TABLE risk(
    risk_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT ,
    academic_risk BOOLEAN DEFAULT FALSE,
    financial_risk BOOLEAN DEFAULT FALSE,
    attendance_percentage DECIMAL(5,2) ,
    unpaid_months INT DEFAULT 0,
    risk_level ENUM('low','medium','high') DEFAULT 'low',
    notes TEXT,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
    
);


