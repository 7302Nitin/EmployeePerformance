CREATE DATABASE EmployeePerformanceDB;
USE EmployeePerformanceDB;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20)
);
CREATE TABLE Employee_Projects (
    employee_project_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    hours_worked INT,
    role VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    feedback_date DATE,
    feedback_score INT,
    comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_date DATE,
    sale_amount DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Employees
INSERT INTO Employees VALUES 
(1, 'John', 'Doe', 'Sales', '2020-01-15', NULL),
(2, 'Jane', 'Smith', 'IT', '2019-03-23', NULL),
(3, 'Alice', 'Johnson', 'Marketing', '2018-07-10', 1),
(4, 'Bob', 'Brown', 'Sales', '2021-02-20', 1);

-- Projects
INSERT INTO Projects VALUES 
(1, 'Project Alpha', '2023-01-01', '2023-06-30', 'Completed'),
(2, 'Project Beta', '2023-02-15', '2023-08-15', 'In Progress');

-- Employee_Projects
INSERT INTO Employee_Projects VALUES 
(1, 1, 1, 200, 'Manager'),
(2, 3, 1, 150, 'Team Lead'),
(3, 2, 2, 100, 'Developer'),
(4, 4, 2, 80, 'Sales Associate');

-- Feedback
INSERT INTO Feedback VALUES 
(1, 1, 1, '2023-07-01', 8, 'Good performance'),
(2, 3, 1, '2023-07-01', 9, 'Excellent leadership'),
(3, 2, 2, '2023-08-16', 7, 'Solid work');

-- Sales
INSERT INTO Sales VALUES 
(1, 1, '2023-05-10', 50000),
(2, 4, '2023-06-15', 30000),
(3, 1, '2023-06-20', 70000),
(4, 4, '2023-07-01', 20000);


-- TOTAL SALES BY EMPLOYEE

SELECT e.employee_id, e.first_name, e.last_name, sum(s.sale_amount) as total_amount
from employees as e 
join sales as  s  on e.employee_id = s.employee_id
group by e.employee_id
order by total_amount desc;

-- Average Feedback Score by Employee
SELECT e.employee_id, e.first_name, e.last_name, avg(f.feedback_score) as total_feedback
from employees as e 
join feedback as  f  on e.employee_id = f.employee_id
group by e.employee_id
order by total_feedback desc;

-- Employee Hours Worked on Projects
SELECT e.employee_id, e.first_name, e.last_name, sum(h.hours_worked) as total_hours
from employees as e 
join employee_projects as  h  on e.employee_id = h.employee_id
group by e.employee_id
order by total_hours desc;

--Employees with Highest Feedback Scores
SELECT 
    e.employee_id, 
    e.first_name, 
    e.last_name, 
    f.feedback_score, 
    f.comments
FROM 
    Employees e
JOIN 
    Feedback f ON e.employee_id = f.employee_id
ORDER BY 
    f.feedback_score DESC
LIMIT 5;

--Projects and Their Status
SELECT 
    p.project_id, 
    p.project_name, 
    p.start_date, 
    p.end_date, 
    p.status
FROM 
    Projects p;

