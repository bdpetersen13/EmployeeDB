-- Database: EmployeeDB

-- DROP DATABASE IF EXISTS "EmployeeDB";

CREATE DATABASE "EmployeeDB"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
);

-- Create employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    contact_number VARCHAR(15),
    address TEXT,
    emergency_contact_name VARCHAR(100),
    emergency_contact_number VARCHAR(15),
    date_of_hire DATE,
    department_id INT,
    role_id INT
);

-- Create department table
CREATE TABLE departments (
	department_id SERIAL PRIMARY KEY,
	dempartment_name VARCHAR(50),
	manager_id INT,
	location VARCHAR(100)
);

-- Create roles/positions table
CREATE TABLE roles (
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(50),
	responsibilities TEXT
);

-- Create performance reviews table
CREATE TABLE performance_reviews (
	review_id SERIAL PRIMARY KEY,
	employee_id INT,
	review_date DATE,
	performance_metrics TEXT,
	feedback TEXT
);

-- Create coaching table
CREATE TABLE coachings (
	coaching_id SERIAL PRIMARY KEY,
	employee_id INT,
	coaching_date DATE,
	coaching_level VARCHAR(10),
	feedback TEXT
);

-- Create salaries table
CREATE TABLE SALARIES (
	salary_id SERIAL PRIMARY KEY,
	employee_id INT,
	base_salary DECIMAL(10,2),
	regional_pay_zone DECIMAL(10,2),
	bounses DECIMAL(10,2),
	deductions DECIMAL(10,2),
	effective_date DATE
);

-- Create training and development table
CREATE TABLE training (
	training_id SERIAL PRIMARY KEY,
	employee_id INT,
	training_program VARCHAR(100),
	certification VARCHAR(100),
	date_completeion DATE
);

-- Add foreign key constraints
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE employees
ADD CONSTRAINT fk_role
FOREIGN KEY (role_id) REFERENCES roles(role_id);

ALTER TABLE performance_reviews
ADD CONSTRAINT fk_employee_review
FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE salaries
ADD CONSTRAINT fk_employee_salary
FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE training
ADD CONSTRAINT fk_employee_training
FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

-- Enable auto-increment for the Employee ID column
ALTER TABLE employees
ALTER COLUMN employee_id SET DEFAULT nextval('employees_employee_id_seq'::regclass);

-- Add NOT NULL constraints to employees table
ALTER TABLE employees
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL,
ALTER COLUMN date_of_birth SET NOT NULL,
ALTER COLUMN date_of_hire SET NOT NULL;

-- Define data types for contact information
ALTER TABLE employees
ALTER COLUMN contact_number SET DATA TYPE VARCHAR,
ADD COLUMN email_address VARCHAR(100); 