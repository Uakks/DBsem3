create database lab7;

create table locations (
    location_id serial primary key ,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);
create table departments (
    department_id serial primary key ,
    department_name varchar(50) unique ,
    budget integer,
    location_id integer references locations
);
create table employees (
    employee_id serial primary key ,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20) ,
    salary integer,
    department_id integer references departments
);
INSERT INTO locations (street_address, postal_code, city, state_province)
VALUES
-- Existing locations (for context, won't duplicate if already added):
('123 Elm St', '10001', 'New York', 'NY'),
('456 Maple Ave', '94101', 'San Francisco', 'CA'),
('789 Oak Blvd', '60601', 'Chicago', 'IL'),
('101 Pine St', '75201', 'Dallas', 'TX'),
('202 Cedar Rd', '30301', 'Atlanta', 'GA'),
-- Additional locations:
('303 Birch Ln', '33101', 'Miami', 'FL'),
('404 Willow Dr', '85001', 'Phoenix', 'AZ'),
('505 Aspen Pl', '80201', 'Denver', 'CO');
INSERT INTO departments (department_name, budget, location_id)
VALUES
-- Existing departments (for context):
('Human Resources', 500000, 1),
('Finance', 750000, 2),
('Engineering', 1200000, 3),
('Sales', 600000, 4),
('Marketing', 450000, 5),
-- Additional departments:
('IT', 1000000, 1),          -- Same location as Human Resources
('Customer Support', 550000, 6),
('Logistics', 400000, NULL),  -- No specific location assigned
('Legal', 300000, 2),         -- Same location as Finance
('Product', 900000, 3);       -- Same location as Engineering
INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES
-- Existing employees (for context):
('John', 'Doe', 'johndoe@example.com', '555-1234', 70000, 1),
('Jane', 'Smith', 'janesmith@example.com', '555-5678', 85000, 2),
('Alice', 'Johnson', 'alicejohnson@example.com', '555-8765', 95000, 3),
('Bob', 'Brown', 'bobbrown@example.com', '555-4321', 62000, 4),
('Carol', 'Taylor', 'caroltaylor@example.com', '555-7890', 73000, 5),
-- Additional employees:
('David', 'Miller', 'davidmiller@example.com', '555-2345', 82000, 1),  -- Same department as John Doe
('Eva', 'Davis', 'evadavis@example.com', '555-3456', 92000, 3),       -- Same department as Alice Johnson
('Frank', 'Wilson', 'frankwilson@example.com', '555-4567', 70000, 4),  -- Same department as Bob Brown
('Grace', 'Lee', 'gracelee@example.com', '555-5678', 65000, NULL),     -- No department assigned
('Henry', 'Clark', 'henryclark@example.com', '555-6789', 78000, 6),    -- New department Customer Support
('Isabel', 'Lewis', 'isabellewis@example.com', '555-7891', 72000, 7),  -- New department Logistics (NULL location)
('Jack', 'Martinez', 'jackmartinez@example.com', '555-8912', 66000, NULL); -- No department assigned

create table countries (
    name varchar(50)
);


CREATE INDEX country_name_index ON countries (name);
SELECT * FROM countries WHERE name = 'string';

CREATE INDEX idx_employees_name_surname ON employees (first_name, last_name);
SELECT * FROM employees WHERE first_name = 'John' AND last_name = 'Doe';

CREATE INDEX idx_employees_salary ON employees (salary);
SELECT * FROM employees WHERE salary < 100000 AND salary > 70000;

CREATE INDEX idx_employees_name_substr ON employees (substring(first_name from 1 for 4));
SELECT * FROM employees WHERE first_name = 'abcd';

CREATE INDEX idx_departments_budget_department ON departments (budget, department_id);
CREATE INDEX idx_employees_department_salary ON employees (department_id, salary);
SELECT *
FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE d.budget > 800000 AND e.salary < 1500000;


