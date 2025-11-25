-- task8.sql
-- Task 8: Stored Procedures and Functions
-- Objective: Learn reusable SQL blocks

-- ---------------------------------------------------------
-- 1. CREATE SAMPLE TABLE
-- ---------------------------------------------------------

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department VARCHAR(50)
);

-- ---------------------------------------------------------
-- 2. INSERT SAMPLE DATA
-- ---------------------------------------------------------

INSERT INTO employees VALUES
(1, 'Manasi', 45000, 'IT'),
(2, 'Priya', 52000, 'HR'),
(3, 'Amit', 60000, 'IT'),
(4, 'Rahul', 40000, 'Finance');

-- ---------------------------------------------------------
-- 3. STORED FUNCTION
-- FUNCTION: getAnnualSalary(emp_id)
-- Returns: Annual salary of employee
-- ---------------------------------------------------------

DROP FUNCTION IF EXISTS getAnnualSalary;

DELIMITER $$

CREATE FUNCTION getAnnualSalary(e_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE annual DECIMAL(12,2);

    SELECT salary * 12 INTO annual
    FROM employees
    WHERE emp_id = e_id;

    RETURN annual;
END $$

DELIMITER ;

-- ---------------------------------------------------------
-- 4. STORED PROCEDURE
-- PROCEDURE: updateSalary(emp_id, increment_amount)
-- Updates salary of employee
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS updateSalary;

DELIMITER $$

CREATE PROCEDURE updateSalary(
    IN e_id INT,
    IN inc DECIMAL(10,2)
)
BEGIN
    UPDATE employees
    SET salary = salary + inc
    WHERE emp_id = e_id;
END $$

DELIMITER ;

-- ---------------------------------------------------------
-- 5. CALLING THE FUNCTION
-- ---------------------------------------------------------

SELECT name, getAnnualSalary(emp_id) AS annual_salary
FROM employees;

-- ---------------------------------------------------------
-- 6. CALLING THE PROCEDURE
-- ---------------------------------------------------------

CALL updateSalary(1, 5000);

-- Verify update
SELECT * FROM employees WHERE emp_id = 1;

