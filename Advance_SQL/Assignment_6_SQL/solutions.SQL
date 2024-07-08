--1. Explicit Cursor:
--a) Create an explicit cursor named "employee_cursor" to retrieve the details of employees from the "employees" table.
--b) Open the cursor and fetch the first three records from the cursor.
--c) Display the employee ID, first name, last name, and hire date for each of the fetched records.
--d) Close the cursor.


SET SERVEROUTPUT ON

DECLARE
   v_empno     employees.employee_id%type;
   v_firstName employees.first_name%type;
   v_lastName  employees.last_name%type;
   v_hiredate  employees.hire_date%type;
   CURSOR employee_cursor IS
      SELECT employee_id, first_name, last_name, hire_date
      FROM employees;
BEGIN
   OPEN employee_cursor;
   
   LOOP
      FETCH employee_cursor INTO v_empno, v_firstName, v_lastName, v_hiredate;
      EXIT WHEN employee_cursor%NOTFOUND OR employee_cursor%ROWCOUNT > 3;
      
      DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_firstName || ' ' || v_lastName || ' ' || v_hiredate);
   END LOOP;
   
   CLOSE employee_cursor;
END;



--
--2 cursor_for_loop
--a) Write a PL/SQL block using a cursor FOR LOOP to display the names and salaries of all employees in the "employees" table.
--b) Ensure that the employees' names are displayed in uppercase and their salaries are increased by 10% before displaying them.

SET SERVEROUTPUT ON

DECLARE
   v_salary employees.salary%TYPE;
BEGIN
   FOR employee_rec IN (SELECT UPPER(first_name) AS first_name_upper, 
                          UPPER(last_name) AS last_name_upper,
                          salary
                   FROM employees)
   LOOP
      v_salary := employee_rec.salary * 1.1; -- Increase salary by 10%
      
      DBMS_OUTPUT.PUT_LINE('Name: ' || employee_rec.first_name_upper || ' ' || employee_rec.last_name_upper);
      DBMS_OUTPUT.PUT_LINE('Original Salary: ' || TO_CHAR(employee_rec.salary, '$999,999.99'));
      DBMS_OUTPUT.PUT_LINE('Increased Salary: ' || TO_CHAR(v_salary, '$999,999.99'));
   END LOOP;
END;



--
--3. Explicit Cursor:
--a) Create an explicit cursor named "department_cursor" to retrieve department details from the "departments" table.
--b) Open the cursor and fetch the department name and manager ID for each department.
--c) Display the department name and manager ID for each record.
--d) Close the cursor.

SET SERVEROUTPUT ON;

DECLARE 
   v_departmentName departments.department_name%type;
   v_managerId employees.manager_id%type;

   CURSOR department_cursor IS 
      SELECT d.department_name, e.manager_id
      FROM employees e
      JOIN departments d 
      ON e.department_id = d.department_id;
BEGIN
   OPEN department_cursor;
   
   LOOP 
      FETCH department_cursor INTO v_departmentName, v_managerId;
      
      EXIT WHEN department_cursor%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_departmentName || ', Manager ID: ' || v_managerId);
   END LOOP;
   
   CLOSE department_cursor;
END;


--4. Cursor FOR LOOP with Nested Cursor:
--a) Create an explicit cursor named "department_cursor" to retrieve department IDs and names from the "departments" table.
--b) Use a cursor FOR LOOP to loop through each department record.
--c) For each department, create a nested cursor named "employee_cursor" to retrieve the names of employees who work in that department from the "employees" table.
--d) Use another cursor FOR LOOP to display the names of employees in each department.

SET SERVEROUTPUT ON;

DECLARE
   v_departmentName departments.department_name%TYPE;
   v_departmentId departments.department_id%TYPE;

   CURSOR department_cursor IS 
      SELECT department_name, department_id
      FROM departments;
      
   CURSOR employee_cursor IS
      SELECT first_name || ' ' || last_name AS employee_name
      FROM employees
      WHERE department_id = p_department_id;
BEGIN 
   FOR department_rec IN department_cursor
   LOOP
      v_departmentName := department_rec.department_name;
      v_departmentId := department_rec.department_id;
      
      DBMS_OUTPUT.PUT_LINE('Employees in Department ' || v_departmentName || ':');
      
 
   END LOOP;
END;



