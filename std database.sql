-- =========================================
-- STUDENT MANAGEMENT SYSTEM
-- COMPLETE DATABASE CODE
-- =========================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS student_management_system;

-- 2. SELECT DATABASE
USE student_management_system;


-- =========================================
-- 3. DEPARTMENTS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);


-- =========================================
-- 4. STUDENTS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    department_id INT,
    admission_date DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


-- =========================================
-- 5. COURSES TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    credits INT,
    department_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


-- =========================================
-- 6. ENROLLMENTS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE,

    UNIQUE(student_id, course_id)
);


-- =========================================
-- 7. MARKS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks INT,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE,

    CHECK (marks >= 0 AND marks <= 100)
);


-- =========================================
-- 8. ATTENDANCE TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent') NOT NULL,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE
);


-- =========================================
-- 9. INSERT DEPARTMENTS
-- =========================================

INSERT IGNORE INTO departments
(department_name)
VALUES
('Computer Science and Engineering'),
('Electronics and Communication Engineering'),
('Electrical and Electronics Engineering'),
('Mechanical Engineering'),
('Civil Engineering');


-- =========================================
-- 10. INSERT STUDENTS
-- =========================================

INSERT IGNORE INTO students
(roll_no, first_name, last_name, gender, date_of_birth,
 email, phone, address, department_id)
VALUES
('23ECE001', 'Anuhya', 'G', 'Female', '2004-05-10',
 'anuhya@gmail.com', '9876543210', 'Nellore', 2),

('23CSE002', 'Rahul', 'Kumar', 'Male', '2004-07-15',
 'rahul@gmail.com', '9876543211', 'Ongole', 1),

('23ECE003', 'Priya', 'Reddy', 'Female', '2005-01-20',
 'priya@gmail.com', '9876543212', 'Nellore', 2);


-- =========================================
-- 11. INSERT COURSES
-- =========================================

INSERT IGNORE INTO courses
(course_name, course_code, credits, department_id)
VALUES
('Java Programming', 'JAVA101', 4, 1),
('Database Management System', 'DBMS101', 4, 1),
('Python Programming', 'PY101', 4, 1),
('Digital Electronics', 'DE101', 3, 2),
('Communication Systems', 'CS101', 3, 2);


-- =========================================
-- 12. INSERT ENROLLMENTS
-- =========================================

INSERT IGNORE INTO enrollments
(student_id, course_id)
VALUES
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 3),
(3, 4);


-- =========================================
-- 13. INSERT MARKS
-- =========================================

INSERT INTO marks
(student_id, course_id, marks)
VALUES
(1, 4, 85),
(1, 5, 78),
(2, 1, 90),
(2, 2, 82),
(2, 3, 88),
(3, 4, 91);


-- =========================================
-- 14. INSERT ATTENDANCE
-- =========================================

INSERT INTO attendance
(student_id, course_id, attendance_date, status)
VALUES
(1, 4, '2026-10-01', 'Present'),
(1, 5, '2026-10-01', 'Present'),
(2, 1, '2026-10-01', 'Absent'),
(2, 2, '2026-10-01', 'Present'),
(3, 4, '2026-10-01', 'Present');


-- =========================================
-- 15. VIEW ALL STUDENTS
-- =========================================

SELECT * FROM students;


-- =========================================
-- 16. VIEW DEPARTMENTS
-- =========================================

SELECT * FROM departments;


-- =========================================
-- 17. VIEW COURSES
-- =========================================

SELECT * FROM courses;


-- =========================================
-- 18. STUDENT + DEPARTMENT
-- =========================================

SELECT
    s.student_id,
    s.roll_no,
    s.first_name,
    s.last_name,
    d.department_name,
    s.email,
    s.phone
FROM students s
JOIN departments d
ON s.department_id = d.department_id;


-- =========================================
-- 19. STUDENT + COURSE + MARKS
-- =========================================

SELECT
    s.roll_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    m.marks
FROM marks m
JOIN students s
ON m.student_id = s.student_id
JOIN courses c
ON m.course_id = c.course_id;


-- =========================================
-- 20. STUDENT ATTENDANCE
-- =========================================

SELECT
    s.roll_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    a.attendance_date,
    a.status
FROM attendance a
JOIN students s
ON a.student_id = s.student_id
JOIN courses c
ON a.course_id = c.course_id;


-- =========================================
-- 21. SEARCH STUDENT BY ROLL NUMBER
-- =========================================

SELECT *
FROM students
WHERE roll_no = '23ECE001';


-- =========================================
-- 22. UPDATE STUDENT
-- =========================================

UPDATE students
SET phone = '9999999999'
WHERE roll_no = '23ECE001';


-- =========================================
-- 23. DELETE STUDENT
-- =========================================

-- Use this only when you actually want to delete a student.

-- DELETE FROM students
-- WHERE roll_no = '23ECE003';


-- =========================================
-- 24. SHOW ALL TABLES
-- =========================================

SHOW TABLES;
USE student_management_system;

USE student_management_system;

SELECT
    s.roll_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    s.email,
    s.phone,
    c.course_name,
    m.marks,
    a.attendance_date,
    a.status AS attendance
FROM students s
JOIN departments d
    ON s.department_id = d.department_id
LEFT JOIN marks m
    ON s.student_id = m.student_id
LEFT JOIN courses c
    ON m.course_id = c.course_id
LEFT JOIN attendance a
    ON s.student_id = a.student_id
    AND m.course_id = a.course_id
ORDER BY s.student_id, c.course_name;
