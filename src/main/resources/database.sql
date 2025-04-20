-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS emsproject;
USE emsproject;

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS project_members;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS leave_requests;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS roles;

-- Create roles table
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

-- Create departments table
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    picture_path VARCHAR(255) DEFAULT 'assets/img/default-profile.jpg',
    role INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE,
    department_id INT,
    hire_date DATE DEFAULT (CURRENT_DATE),
    salary DECIMAL(10,2) DEFAULT 0.00,
    address VARCHAR(255),
    date_of_birth DATE,
    emergency_contact VARCHAR(100),
    emergency_phone VARCHAR(20),
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role) REFERENCES roles(id),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Add manager_id foreign key to departments after users table is created
ALTER TABLE departments
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES users(id);

-- Create attendance table
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out DATETIME,
    status ENUM('Present', 'Absent', 'Half-day', 'Late') DEFAULT 'Present',
    work_hours DECIMAL(5,2),
    ip_address VARCHAR(50),
    location VARCHAR(255),
    note VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create leave_requests table
CREATE TABLE leave_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    leave_type ENUM('Annual', 'Sick', 'Personal', 'Maternity', 'Paternity', 'Other') NOT NULL,
    reason VARCHAR(255),
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    approved_by INT,
    rejection_reason VARCHAR(255),
    attachment_path VARCHAR(255),
    total_days INT,
    half_day BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (approved_by) REFERENCES users(id)
);

-- Create projects table
CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    status ENUM('Not Started', 'In Progress', 'On Hold', 'Completed', 'Cancelled') DEFAULT 'Not Started',
    priority ENUM('Low', 'Medium', 'High', 'Critical') DEFAULT 'Medium',
    budget DECIMAL(15,2),
    completion_percentage INT DEFAULT 0,
    client_name VARCHAR(100),
    client_email VARCHAR(100),
    client_phone VARCHAR(20),
    manager_id INT,
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (manager_id) REFERENCES users(id),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Create project_members table to track project team members
CREATE TABLE project_members (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    role VARCHAR(50) DEFAULT 'Member',
    joined_date DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE KEY unique_project_member (project_id, user_id)
);

-- Create notifications table
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    type VARCHAR(50) DEFAULT 'general',
    reference_id INT,
    reference_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create tasks table
CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    project_id INT,
    assigned_to INT,
    assigned_by INT,
    due_date DATE,
    priority ENUM('Low', 'Medium', 'High', 'Urgent') DEFAULT 'Medium',
    status ENUM('To Do', 'In Progress', 'Review', 'Completed') DEFAULT 'To Do',
    completion_percentage INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (assigned_to) REFERENCES users(id),
    FOREIGN KEY (assigned_by) REFERENCES users(id)
);

-- Insert default roles
INSERT INTO roles (name, description) VALUES
('Admin', 'System administrator with full access'),
('Manager', 'Department manager with elevated privileges'),
('Employee', 'Regular employee with standard access'),
('HR', 'Human Resources staff'),
('Intern', 'Temporary intern');

-- Insert default departments
INSERT INTO departments (name, description) VALUES
('Computer Science', 'IT and software development department'),
('Electrical', 'Electrical engineering department'),
('Mechanical', 'Mechanical engineering department'),
('Civil', 'Civil engineering department'),
('Human Resources', 'HR department'),
('Finance', 'Finance and accounting department'),
('Marketing', 'Marketing and sales department');

-- Insert default admin user (password: admin123)
INSERT INTO users (name, email, password, phone, role, department_id, hire_date, salary, address) VALUES
('Admin User', 'admin@example.com', 'admin123', '1234567890', 1, 1, '2023-01-01', 100000.00, '123 Admin Street, Admin City');

-- Insert managers
INSERT INTO users (name, email, password, phone, role, department_id, hire_date, salary, address) VALUES
('John Manager', 'john@example.com', 'manager123', '2345678901', 2, 1, '2023-01-15', 85000.00, '456 Manager Ave, Manager Town'),
('Sarah Manager', 'sarah@example.com', 'manager123', '3456789012', 2, 2, '2023-02-01', 82000.00, '789 Leader Lane, Manager City'),
('Michael Manager', 'michael@example.com', 'manager123', '4567890123', 2, 3, '2023-02-15', 80000.00, '101 Boss Blvd, Manager Heights'),
('Emily Manager', 'emily@example.com', 'manager123', '5678901234', 2, 4, '2023-03-01', 81000.00, '202 Director Dr, Manager Valley'),
('David Manager', 'david@example.com', 'manager123', '6789012345', 2, 5, '2023-03-15', 79000.00, '303 Chief Circle, Manager Springs');

-- Insert employees
INSERT INTO users (name, email, password, phone, role, department_id, hire_date, salary, address) VALUES
('Alice Employee', 'alice@example.com', 'employee123', '7890123456', 3, 1, '2023-04-01', 65000.00, '404 Worker Way, Employee City'),
('Bob Employee', 'bob@example.com', 'employee123', '8901234567', 3, 1, '2023-04-15', 63000.00, '505 Staff St, Employee Town'),
('Charlie Employee', 'charlie@example.com', 'employee123', '9012345678', 3, 2, '2023-05-01', 62000.00, '606 Labor Lane, Employee Village'),
('Diana Employee', 'diana@example.com', 'employee123', '0123456789', 3, 2, '2023-05-15', 64000.00, '707 Team Terrace, Employee Heights'),
('Edward Employee', 'edward@example.com', 'employee123', '1234567890', 3, 3, '2023-06-01', 61000.00, '808 Associate Ave, Employee Valley'),
('Fiona Employee', 'fiona@example.com', 'employee123', '2345678901', 3, 3, '2023-06-15', 62500.00, '909 Personnel Place, Employee Springs'),
('George Employee', 'george@example.com', 'employee123', '3456789012', 3, 4, '2023-07-01', 63500.00, '111 Colleague Court, Employee Gardens'),
('Hannah Employee', 'hannah@example.com', 'employee123', '4567890123', 3, 4, '2023-07-15', 64500.00, '222 Workforce Way, Employee Meadows'),
('Ian Employee', 'ian@example.com', 'employee123', '5678901234', 3, 5, '2023-08-01', 60000.00, '333 Hire Highway, Employee Park'),
('Julia Employee', 'julia@example.com', 'employee123', '6789012345', 3, 5, '2023-08-15', 61500.00, '444 Recruit Road, Employee Forest');

-- Update departments to set managers
UPDATE departments SET manager_id = 1 WHERE id = 1;
UPDATE departments SET manager_id = 2 WHERE id = 1;
UPDATE departments SET manager_id = 3 WHERE id = 2;
UPDATE departments SET manager_id = 4 WHERE id = 3;
UPDATE departments SET manager_id = 5 WHERE id = 4;
UPDATE departments SET manager_id = 6 WHERE id = 5;

-- Insert projects
INSERT INTO projects (name, description, start_date, end_date, status, priority, budget, manager_id, department_id) VALUES
('Website Redesign', 'Redesign company website with modern UI/UX', '2023-09-01', '2023-12-31', 'In Progress', 'High', 50000.00, 2, 1),
('Mobile App Development', 'Develop a mobile app for customers', '2023-10-01', '2024-03-31', 'In Progress', 'Medium', 75000.00, 2, 1),
('Network Infrastructure Upgrade', 'Upgrade company network infrastructure', '2023-09-15', '2023-11-30', 'Completed', 'Critical', 100000.00, 3, 2),
('Automated Testing Framework', 'Implement automated testing framework', '2023-11-01', '2024-01-31', 'Not Started', 'Medium', 30000.00, 2, 1),
('New Product Launch', 'Launch new product line', '2023-10-15', '2024-04-30', 'In Progress', 'High', 200000.00, 4, 3);

-- Insert project members
INSERT INTO project_members (project_id, user_id, role) VALUES
(1, 2, 'Project Manager'),
(1, 7, 'Developer'),
(1, 8, 'Designer'),
(2, 2, 'Project Manager'),
(2, 7, 'Lead Developer'),
(2, 8, 'UI/UX Designer'),
(2, 9, 'QA Tester'),
(3, 3, 'Project Manager'),
(3, 9, 'Network Engineer'),
(3, 10, 'System Administrator'),
(4, 2, 'Project Manager'),
(4, 7, 'Test Engineer'),
(4, 8, 'Developer'),
(5, 4, 'Project Manager'),
(5, 11, 'Product Designer'),
(5, 12, 'Marketing Specialist');

-- Insert tasks
INSERT INTO tasks (title, description, project_id, assigned_to, assigned_by, due_date, priority, status, completion_percentage) VALUES
('Design Homepage Mockup', 'Create mockup for the new homepage design', 1, 8, 2, '2023-09-15', 'High', 'Completed', 100),
('Implement Homepage', 'Implement the homepage based on the approved mockup', 1, 7, 2, '2023-10-01', 'High', 'In Progress', 75),
('Design Mobile App UI', 'Create UI design for the mobile app', 2, 8, 2, '2023-10-15', 'Medium', 'Completed', 100),
('Develop App Backend', 'Implement backend services for the mobile app', 2, 7, 2, '2023-11-30', 'High', 'In Progress', 50),
('Test App Features', 'Test all features of the mobile app', 2, 9, 2, '2024-01-15', 'Medium', 'To Do', 0),
('Install New Routers', 'Install and configure new network routers', 3, 9, 3, '2023-10-15', 'High', 'Completed', 100),
('Update Network Security', 'Implement new security protocols', 3, 10, 3, '2023-11-15', 'Critical', 'Completed', 100),
('Design Test Framework', 'Design architecture for automated testing framework', 4, 7, 2, '2023-11-15', 'High', 'To Do', 0),
('Create Product Prototype', 'Develop prototype for the new product', 5, 11, 4, '2023-11-30', 'High', 'In Progress', 60),
('Prepare Marketing Materials', 'Create marketing materials for product launch', 5, 12, 4, '2023-12-15', 'Medium', 'To Do', 0);

-- Insert attendance records
INSERT INTO attendance (user_id, check_in, check_out, status, work_hours, note) VALUES
(7, '2023-09-01 09:00:00', '2023-09-01 17:30:00', 'Present', 8.5, 'Regular day'),
(8, '2023-09-01 08:45:00', '2023-09-01 17:15:00', 'Present', 8.5, 'Regular day'),
(9, '2023-09-01 09:15:00', '2023-09-01 17:45:00', 'Late', 8.5, 'Traffic delay'),
(7, '2023-09-02 08:55:00', '2023-09-02 17:30:00', 'Present', 8.5, 'Regular day'),
(8, '2023-09-02 08:50:00', '2023-09-02 17:20:00', 'Present', 8.5, 'Regular day'),
(9, '2023-09-02 09:00:00', '2023-09-02 17:30:00', 'Present', 8.5, 'Regular day'),
(7, '2023-09-03 09:00:00', '2023-09-03 17:30:00', 'Present', 8.5, 'Regular day'),
(8, '2023-09-03 08:45:00', '2023-09-03 17:15:00', 'Present', 8.5, 'Regular day'),
(9, '2023-09-03 09:00:00', '2023-09-03 17:30:00', 'Present', 8.5, 'Regular day');

-- Insert leave requests
INSERT INTO leave_requests (user_id, start_date, end_date, leave_type, reason, status, approved_by, total_days) VALUES
(7, '2023-09-15', '2023-09-16', 'Personal', 'Family event', 'Approved', 2, 2),
(8, '2023-09-20', '2023-09-22', 'Sick', 'Not feeling well', 'Approved', 2, 3),
(9, '2023-10-01', '2023-10-05', 'Annual', 'Vacation', 'Pending', NULL, 5),
(10, '2023-09-25', '2023-09-25', 'Personal', 'Doctor appointment', 'Approved', 3, 1),
(11, '2023-10-10', '2023-10-12', 'Sick', 'Flu', 'Rejected', 4, 3),
(12, '2023-10-15', '2023-10-19', 'Annual', 'Family vacation', 'Pending', NULL, 5);

-- Insert notifications
INSERT INTO notifications (user_id, title, message, type, reference_id, reference_type) VALUES
(7, 'Task Assigned', 'You have been assigned a new task: Implement Homepage', 'task', 2, 'task'),
(8, 'Task Completed', 'Your task "Design Homepage Mockup" has been marked as completed', 'task', 1, 'task'),
(9, 'Leave Request Approved', 'Your leave request for Sep 20-22 has been approved', 'leave', 2, 'leave_request'),
(2, 'New Leave Request', 'Charlie has requested leave from Oct 1-5', 'leave', 3, 'leave_request'),
(7, 'Project Update', 'Website Redesign project status has been updated to In Progress', 'project', 1, 'project'),
(8, 'New Project Member', 'You have been added to the Mobile App Development project', 'project', 2, 'project');
