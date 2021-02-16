-- Create Tables

CREATE TABLE Employees (
    emp_no INT   NOT NULL,
	emp_title_id VARCHAR NOT NULL,
    birth_date date   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date date   NOT NULL,
	PRIMARY KEY (emp_no, emp_title_id)
);
SELECT * from Employees;

CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
	PRIMARY KEY (dept_no)
);
select * from Departments;

CREATE TABLE Department_Employees (
    emp_no INT   NOT NULL,
	dept_no VARCHAR   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
select * from Department_Employees;

CREATE TABLE Department_Manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
SELECT * from Department_Manager;


CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
	salary INT   NOT NULL,   
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);
SELECT * from Salaries;


CREATE TABLE Titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL
);
SELECT * from Titles;

-- Data Analysis

-- Query the details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex,
s.salary
FROM Employees as e
INNER JOIN Salaries  as s 
ON e.emp_no = s.emp_no;

-- Query the first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM Employees 
WHERE hire_date >= '1985-12-31'
AND hire_date < '1987-01-01';

-- Query the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, 
	   d.dept_name,
	   dm.emp_no,
	   e.last_name,
	   e.first_name
FROM Department_Manager as dm
INNER JOIN Departments  as d 
ON dm.dept_no = d.dept_no
INNER JOIN Employees  as e 
ON dm.emp_no = e.emp_no;

-- Query the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, 
	   e.last_name, 
	   e.first_name,
	   d.dept_name
FROM Employees as e
INNER JOIN Department_Manager as dm 
ON e.emp_no = dm.emp_no
INNER JOIN Departments as d
ON dm.dept_no = d.dept_no;

-- Query first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex 
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- Query all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees as e
JOIN Department_Employees as de
ON e.emp_no = de.emp_no
INNER JOIN Departments as d 
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';

-- Query all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees as e
JOIN Department_Employees as de
ON e.emp_no = de.emp_no
INNER JOIN Departments as d 
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR 
	  dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) 
FROM Employees
GROUP BY last_name
ORDER BY count(last_name) desc;

