--1. Create a stored procedure named "GET_EMPLOYEES" that returns all employee details from the "employees" table.
     
CREATE OR REPLACE PROCEDURE GET_EMPLOYEES
(p_employee_id OUT employees.employee_id%type,
 p_first_name OUT employees.first_name%type,
 p_last_name OUT employees.last_name%type,
 p_email OUT employees.email%type,
 p_phone_number OUT employees.phone_number%type)
IS
BEGIN
  SELECT employee_id,first_name,last_name,email,phone_number
  INTO p_employee_id,p_first_name,p_last_name,p_email,p_phone_number
  FROM employees;
 END GET_EMPLOYEES;
 
 
 
 
 
--2. Modify the "GET_EMPLOYEES" stored procedure to accept an input parameter "department_id" 
--   and return only the employees who belong to that department.


CREATE OR REPLACE PROCEDURE GET_EMPLOYEES
(
 p_employee_id IN employees.employee_id%type,
 p_first_name OUT employees.first_name%type,
 p_last_name OUT employees.last_name%type,
 p_email OUT employees.email%type,
 p_phone_number OUT employees.phone_number%type)
IS
BEGIN
  SELECT first_name,last_name,email,phone_number
  INTO p_first_name,p_last_name,p_email,p_phone_number
  FROM employees
  WHERE employee_id=p_employee_id;
 END GET_EMPLOYEES;
 
 
 
--3. Create a stored procedure named "GET_EMPLOYEES_IN_DEPT" that accepts a department ID as an input parameter. 
--   Use a cursor to fetch all employee names and salaries for the given department and display the results.
    
CREATE OR REPLACE PROCEDURE GET_EMPLOYEES_IN_DEPT
(p_department_id IN employees.department_id%type)
IS
CURSOR salary_fetch(p_department_id)IS
SELECT first_name,salary
FROM 
employees;
BEGIN
v_first_name employees.first_name%type;
v_salary employees.salary%type;
from emp_rec IN salary_fetch 
LOOP
v_first_name :=emp_rec.first_name;
v_salary :=emp_rec.salary;

DBMS_OUTPUT.PUT_LINE('first_name:' || v_first_name);
DBMS_OUTPUT.PUT_LINE('salary:' || v_salary);

END LOOP;


END;

     
     
     
     
     
     
--4. Create a new object type "employee_type" with attributes for "employee_id," "first_name," "last_name," and "salary."
--   Create a nested table type "employee_table" using the "employee_type" object type.
--   Write a stored procedure named "INSERT_EMPLOYEES" that accepts an array of employee records (employee_table) as input 
--   and inserts them into the "employees" table.
--   The procedure should handle the situation when the provided department ID does not exist in the "DEPARTMENTS" table. 
--   In such cases, it should raise a custom exception and display an appropriate error message.









--5. Create a stored procedure named "UPDATE_SALARY_BATCH" that takes an array of employee IDs and a percentage increase as inputs. 
--   The procedure should update the salaries of the employees whose IDs are in the input array with the given percentage increase.

CREATE OR REPLACE PROCEDURE UPDATE_SALRY_BATCH 
IS



















