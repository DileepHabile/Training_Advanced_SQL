--1 IMPLICIT CURSORS 
--  What is an implicit cursor in PL/SQL? Explain its purpose and characteristics.

-- Write a PL/SQL block that uses an implicit cursor to fetch and display the names of all employees from the "employees" table.

--2 Write a PL/SQL block to retrieve and display the details of an employee with a specific ID.
--Prompt the user to enter the employee ID as input.

SET SERVEROUTPUT ON
DECLARE
v_emp_id  employees.employee_id%type;
v_dept_id employees.department_id%type;
v_name  employees.first_name%type;
v_salary employees.salary%type;
BEGIN
v_emp_id :=&emp_id;

SELECT department_id,first_name,salary
INTO v_dept_id,v_name,v_salary
FROM Employees
WHERE Employee_id=v_emp_id;
DBMS_OUTPUT.PUT_LINE('Department ID: ' || v_dept_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with Employee ID ' || v_emp_id);

END;



--3  Write a PL/SQL block that inserts a new department record into the "departments" table. 
--Prompt the user to enter the department name and location as input.


SET SERVEROUTPUT ON

DECLARE
v_dept_id  departments.department_id%type;
v_dept_name departments.department_name%type;
v_location  departments.location_id%type;
BEGIN
v_dept_id := &department_id;
v_dept_name := &department_name;
v_location := &department_location;

INSERT INTO Departments
(department_id,department_name,location_id)
values
(v_dept_id,v_dept_name,v_location) ;
END;


--select *
--from departments
--
--
--SET SERVEROUTPUT ON;
--
--DECLARE
--    v_dept_id   departments.department_id%type;
--    v_dept_name departments.department_name%type;
--    v_location  departments.location_id%type;
--BEGIN
--    v_dept_id := &department_id; 
--    v_dept_name := '&department_name'; 
--    v_location := &department_location;
--
--    INSERT INTO Departments (department_id, department_name, location_id)
--    VALUES (v_dept_id, v_dept_name, v_location);
--
--    COMMIT;
--
--    DBMS_OUTPUT.PUT_LINE('Department inserted successfully.');
--
--  
--    FOR dept_rec IN (SELECT * FROM departments WHERE department_id = v_dept_id) LOOP
--        DBMS_OUTPUT.PUT_LINE('Department ID: ' || dept_rec.department_id || ', Name: ' || dept_rec.department_name || ', Location ID: ' || dept_rec.location_id);
--    END LOOP;
--END;


--4 Write a PL/SQL block to handle the NO_DATA_FOUND exception while fetching an employee's details based on a given employee ID.
--Display a custom message when the exception occurs

SET SERVEROUTPUT ON

DECLARE 
v_emp_id employees.employee_id%type;
v_fname   employees.first_name%type;
v_lname   employees.last_name%type;
v_salary  employees.salary%type;


BEGIN
v_emp_id := &employee_id;

SELECT employee_id,first_name,last_name,salary
INTO  v_emp_id,v_fname,v_lname,v_salary
FROM Employees
WHERE Employee_id = v_emp_id;

DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_fname || ' ' || v_lname);
        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
EXCEPTION
      WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No employee found with Employee ID ' || v_emp_id);
END;





--6  Write a PL/SQL block to retrieve the employee details (employee_id, first_name, last_name, and salary) from the "employees" table for a given department ID (prompt user).
--If no employees are found, display "No employees found for the given department."


SET SERVEROUTPUT ON

DECLARE 
v_emp_id  employees.employee_id%type;
v_fname   employees.first_name%type;
v_lname   employees.last_name%type;
v_salary  employees.salary%type;

BEGIN
v_emp_id := &emp_id;

SELECT employee_id,first_name,last_name,salary
INTO v_emp_id,v_fname,v_lname,v_salary
FROM employees
WHERE employee_id=v_emp_id;

DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_fname || ' ' || v_lname);
        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No employees found for the given department' || v_emp_id);

END;



--9  Write a PL/SQL block to insert a new record into the "employees" table.


SET  SERVEROUTPUT ON

DECLARE 

BEGIN

INSERT INTO employess(
employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES 
(&emp_id,&f_name,&lname,&email,&phnumber,&h_date,&job_id,&salary,&manager,&dept_id);

END;


--8Write a PL/SQL block that deletes all employees who have a salary less than 3000 and hire date older than 5 years.
--Display the count of deleted employees.


SET SERVEROUTPUT ON

DECLARE 
v_salary_rule employees.salary := 3000;
v_date employee.hire_date:= GETDATE;

BEGIN

DELETE FROM employees
WHERE salary <v_salary_rule  
AND v_


END;

--
--SET SERVEROUTPUT ON;
--
--DECLARE
--    v_salary_rule NUMBER := 3000;
--    v_hire_date_threshold DATE;
--    v_deleted_count NUMBER := 0;
--BEGIN
--    -- Calculate the hire date threshold (5 years ago from today)
--    v_hire_date_threshold := ADD_MONTHS(TRUNC(SYSDATE, 'YEAR'), -60); -- 60 months = 5 years
--    
--    -- Delete employees who meet the criteria and count them
--    DELETE FROM employees
--    WHERE salary < v_salary_rule
--    AND hire_date < v_hire_date_threshold
--    RETURNING COUNT(*) INTO v_deleted_count;
--
--    -- Display the count of deleted employees
--    DBMS_OUTPUT.PUT_LINE('Number of employees deleted: ' || v_deleted_count);
--END;
--/


--7  Create a PL/SQL block that increases the salary of all employees in the "sales" department by 10%. 
-- Display the affected employee IDs and their updated salaries.


SET SERVEROUTPUT ON

DECLARE 


BEGIN


UPDATE employees
SET SALARY=

END;






