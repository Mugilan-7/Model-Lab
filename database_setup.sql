-- 1. Drop the database if it already exists to start fresh
DROP DATABASE IF EXISTS studentdb;

-- 2. Create the new database
CREATE DATABASE studentdb;

-- 3. Select the database for use
USE studentdb;

-- 4. Create the students table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

-- 5. Insert some sample data so your table isn't empty when you test it
INSERT INTO students (name, email) VALUES 
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');
