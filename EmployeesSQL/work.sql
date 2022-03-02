--1 
DROP TABLE IF EXISTS dept_emp;

--create new table to import data
CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR(10)
);

-- import table from dept_emp.csv
	
--2
DROP TABLE IF EXISTS salaries;

--create new table to import data
CREATE TABLE salaries (
	emp_no INT, 
	salary INT
);

-- import table from salaries.csv

--3
DROP TABLE IF EXISTS employees;

--create new table to import data
CREATE TABLE employees (
	emp_no INT,
	emp_title_id VARCHAR(10),
	birth_date DATE,
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	sex VARCHAR(3),
	hire_date DATE
);

-- import table from employees.csv

--4
DROP TABLE IF EXISTS departments;

--create new table to import data
CREATE TABLE departments (
	dept_no VARCHAR(10),
	dept_name VARCHAR(25)
);

-- import table from departments.csv

--5
DROP TABLE IF EXISTS dept_manager;

--create new table to import data
CREATE TABLE dept_manager (
	dept_no VARCHAR(10),
	emp_no INT
);

-- import table from dept_manager.csv

--6
DROP TABLE IF EXISTS titles;

--create new table to import data
CREATE TABLE titles (
	title_id VARCHAR(10),
	title VARCHAR(25)
);

-- import table from titles.csv

-- all data is imported, now view all the tables to ensure data has been imported correctly
SELECT * FROM dept_emp;
SELECT * FROM salaries;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM titles;

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
ORDER BY salary;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date;

-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name
FROM dept_manager
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments
ON dept_manager.dept_no = departments.dept_no
ORDER BY dept_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
DROP VIEW IF EXISTS dept_and_emp;

CREATE VIEW dept_and_emp AS
SELECT dept_emp.dept_no, departments.dept_name, employees.emp_no, employees.first_name, employees.last_name 
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
ORDER BY dept_no, last_name;

SELECT * FROM dept_and_emp;
 
-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT * FROM dept_and_emp 
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM dept_and_emp 
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name)AS Frequency
FROM employees
GROUP BY last_name
ORDER BY
COUNT (last_name) DESC;

-- Epilogue: Search your ID number: 499942
SELECT * FROM dept_and_emp WHERE emp_no = '499942';

