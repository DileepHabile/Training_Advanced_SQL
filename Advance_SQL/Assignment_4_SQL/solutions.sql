


--1 Write a PL/SQL block to declare a variable named "salary" of type NUMBER and assign a value of 5000 to it.
--Display the value of the salary variable.

SET SERVEROUTPUT ON
DECLARE 
v_salary NUMBER;

BEGIN
v_salary :=5000;
DBMS_OUTPUT.PUT_LINE('The salary of the employee:'  || v_salary);

END;


--2 Write a PL/SQL block to declare two variables, "length" and "width", both of type NUMBER.
--Assign values of 10 and 5 to the variables, respectively.
--Calculate and display the area of a rectangle using these variables.

SET SERVEROUTPUT ON
DECLARE
v_length NUMBER;
v_width NUMBER;
v_area NUMBER;
BEGIN
v_length :=10;
v_width :=5;

v_area := v_length * v_width;

DBMS_OUTPUT.PUT_LINE('The area of the Rectangle: ' || v_area);
END;


--3  Write a PL/SQL block to declare a variable named "message" of type VARCHAR2(100). 
--Prompt the user to enter a message and assign it to the variable.
--Display the message in uppercase letters.

SET SERVEROUTPUT ON
ACCEPT x VARCHAR2(100) PROMPT 'Please Enter your message'
DECLARE 
    v_message VARCHAR2(100);
BEGIN
    v_message := '&x';
    v_message := UPPER(v_message);
    DBMS_OUTPUT.PUT_LINE('The message you typed: ' || v_message);
END;


--4 Write a PL/SQL block to declare two variables, "num1" and "num2", both of type NUMBER. 
--Prompt the user to enter values for num1 and num2. 
--Swap the values of the variables and display the new values.

SET SERVEROUTPUT ON
ACCEPT x NUMBER PROMPT 'Enter Number1:'
ACCEPT y NUMBER PROMPT 'Enter Number2:'
DECLARE
v_num1 NUMBER;
v_num2 NUMBER;
v_temp NUMBER;
BEGIN

v_num1 := &x;
v_num2 := &y;

v_temp := v_num1;
v_num1 := v_num2;
v_num2 := v_temp;

DBMS_OUTPUT.PUT_LINE('After swapping we have:');
DBMS_OUTPUT.PUT_LINE('Number1: ' || v_num1 || ', Number2: ' || v_num2);
END;


--5 Write a PL/SQL block to declare a variable named "emp_count" of type NUMBER and initialize it to 0. 
--Retrieve the count of employees from the HR schema's "employees" table and assign it to the "emp_count" variable.
--Display the value of "emp_count".

SET SERVEROUTPUT ON
DECLARE
v_emp_count NUMBER:=0;
BEGIN

SELECT COUNT(employee_ID)
INTO v_emp_count
FROM Employees;

DBMS_output.put_line(v_emp_count);

END;


--6 Create a PL/SQL block to declare a variable named "dept_name" of type VARCHAR2(50). 
--Prompt the user to enter a department name and assign it to the "dept_name" variable.
--Use the HR schema's "departments" table and display the details of the department entered.

SET SERVEROUTPUT ON
ACCEPT x VARCHAR2(50) PROMPT 'Enter the Department Name'
DECLARE 

v_dept_name  VARCHAR2(50);
v_dept_id NUMBER ;
v_location_id NUMBER;

BEGIN
v_dept_name:= '&x';

SELECT department_ID,location_ID
INTO v_dept_id,v_location_id
FROM Departments
WHERE Department_name=v_dept_name;

DBMS_OUTPUT.PUT_LINE(v_dept_name || ' ' || v_dept_id || ' ' ||v_location_id);
END;


-- exploring the table
SELECT *
FROM Departments


--7
--Write a PL/SQL block to declare a variable named "avg_salary" of type NUMBER(10,2). 
--Calculate the average salary of all employees in the HR schema's "employees" table and assign it to the "avg_salary" variable.
--Display the value of "avg_salary".

SET SERVEROUTPUT ON
DECLARE 
v_avg_salary NUMBER(10,2);

BEGIN

SELECT AVG(salary)
INTO v_avg_salary
FROM Employees;


DBMS_OUTPUT.PUT_LINE(v_avg_salary);
END;


--8 Create a PL/SQL block to declare a variable named "employee_name" of type VARCHAR2(100). Prompt the user to enter an employee ID and assign it to a bind variable ":emp_id".
--Retrieve the name of the employee with the entered ID from the HR schema's "employees" table and assign it to the "employee_name" variable. 
--Display the value of "employee_name".

SET SERVEROUTPUT ON
DECLARE 
v_employee_name VARCHAR2(100) ;
v_emp_id NUMBER;
BEGIN
v_emp_id := &Enter_Employee_id;
SELECT first_name
INTO v_employee_name
FROM employees
WHERE employee_id= v_emp_id;
DBMS_OUTPUT.PUT_LINE(v_employee_name ||' ' || v_emp_id);
END;


----9.Write a PL/SQL block to declare a variable named "new_salary" of type NUMBER(8,2).
--Prompt the user to enter an employee ID and a new salary value. Assign the new salary value to the employee with the entered ID in the HR schema's "employees" table. 
--Use bind variables ":emp_id" and ":salary". Display a message indicating the successful update.

SET SERVEROUTPUT ON
DECLARE
v_new_salary NUMBER(8,2);
v_emp_id  employees.employee_id%type;
BEGIN
v_emp_id :=TO_NUMBER(&Emp_id);
v_new_salary := TO_NUMBER(&Emp_Salary);

UPDATE employees
SET salary = v_new_salary
WHERE employee_id = v_emp_id;

DBMS_OUTPUT.PUT_LINE('Salary update successful');

END;

















