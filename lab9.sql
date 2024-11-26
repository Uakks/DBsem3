create database lab9;
create table employees(
    first_name text,
    last_name text,
    company text,
    salary numeric
);
insert into employees values('Asdf','asddf','adsfdg',12345),
                            ('Qwer','asff','asdfdg',12345),
                            ('Zxcv','asdfgd','asfdgh',1235);
create table products (
    product_id serial,
    product_name text,
    category text,
    price numeric
);
insert into products (product_name, category, price) values
    ('Laptop', 'Electronics', 1000.00),
    ('Smartphone', 'Electronics', 800.00),
    ('Refrigerator', 'Appliances', 500.00),
    ('Blender', 'Appliances', 50.00),
    ('Table', 'Furniture', 150.00),
    ('Chair', 'Furniture', 75.00);
--1
CREATE OR REPLACE FUNCTION increase_value(val INTEGER)
    RETURNS INTEGER AS
$$
BEGIN
    RETURN val + 10;
END;
$$
    LANGUAGE plpgsql;

call increase_value(20);

--2
CREATE OR REPLACE FUNCTION compare_numbers(a INTEGER, b INTEGER)
    returns TEXT
AS $$
BEGIN
    IF a > b THEN
        return 'Greater';
    ELSIF a < b THEN
        return 'Lesser';
    ELSE
        return 'Equal';
    END IF;
END; $$
LANGUAGE plpgsql;

select compare_numbers(5, 10);

--3
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series INTEGER) AS $$
BEGIN
    FOR series IN 1..n LOOP
        RETURN QUERY SELECT series; -- `series` is implicitly used as the OUT parameter
    END LOOP;
END; $$
LANGUAGE plpgsql;

select number_series(10);

--4
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(first_name TEXT, last_name TEXT, company TEXT, salary NUMERIC) AS $$
BEGIN
    RETURN QUERY SELECT * FROM employees WHERE employees.first_name = emp_name;
END; $$
LANGUAGE plpgsql;

select * from find_employee('Asdf');

--5
CREATE OR REPLACE FUNCTION list_products(given_category TEXT)
RETURNS TABLE(product_id INT, product_name TEXT, category TEXT, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM products WHERE products.category = given_category;
END; $$
LANGUAGE plpgsql;

select * from list_products('Electronics');
--6
CREATE OR REPLACE FUNCTION calculate_bonus(emp_name TEXT)
RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    SELECT salary * 0.10 INTO bonus FROM employees
    WHERE employees.first_name = emp_name;
    RETURN bonus;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_name TEXT)
RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := calculate_bonus(emp_name);
    UPDATE employees
    SET salary = salary + bonus
    WHERE employees.first_name = emp_name;
END; $$
LANGUAGE plpgsql;

SELECT * FROM employees;
SELECT update_salary('Asdf');
SELECT * FROM employees;

--7
CREATE OR REPLACE FUNCTION complex_calculation(input_number INTEGER, input_string VARCHAR)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    numeric_result BIGINT := 1;
    string_result VARCHAR;
    final_result VARCHAR;
BEGIN
    <<main_block>>
    BEGIN
        <<numeric_block>>
        BEGIN
            for i in 1..input_number loop
                numeric_result := numeric_result * i;
            end loop;
        END numeric_block;

        <<string_block>>
        BEGIN
            string_result := reverse(input_string);
        END string_block;

        final_result := 'Numeric Result: ' || numeric_result || ', String Result: ' || string_result;
    END main_block;

    RETURN final_result;
END
$$;

SELECT complex_calculation(5, 'example');
