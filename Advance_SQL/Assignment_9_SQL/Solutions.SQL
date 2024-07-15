--1.Create a PL/SQL anonymous block that performs the following actions:
--a) Open a cursor to fetch employee information.
--b) For each employee, attempt to divide their salary by 0. Handle the "ZERO_DIVIDE" exception at this level by displaying a custom error message for each employee.
--c) Handle any other exceptions that may occur during the loop by displaying a generic error message.
DECLARE
  CURSOR employees_cursor
  IS
    SELECT salary FROM employees ;
  v_temp employees.salary %TYPE ;
BEGIN
  OPEN employee_cursor;
  LOOP
    FETCH employees_cursor INTO v_temp;
    EXIT
  WHEN employees_cursor %NOTFOUND;
    v_temp:v_temp/0;
  END LOOP;
  CLOSE employee_cursor;
EXCEPTION
WHEN ZERO_DIVIDE THEN
  DBMS_OUTPUT.PUT_LINE(SQLCODE ||':' SQLERRM);
WHEN OTHER THEN
  DBMS_OUTPUT.PUT_LINE('Error occured for salary' ||v_temp||':'||SQLERRM);
END;
/


--2.Create a PL/SQL anonymous block that declares a nested table type to store integers. Initialize a nested table variable and insert some random integers into it.
--Then, loop through the nested table and display the elements.

--3.Create a PL/SQL anonymous block that uses a cursor to fetch employee names from the "employees" table and stores them in a collection (nested table or associative array). 
--Then, display the employee names from the collection.
DECLARE
CURSOR emp_cursor is 
SELECT first_name + last_name as employee_name
FROM 
employees;

TYPE emp_name_table IS TABLE OF emp_cursor%type INDEX BY BINARY_INTEGER ;
emp_name emp_name_table;
i NUMBER :=1;
BEGIN
FOR  emp_rec IN emp_cursor 
LOOP
emp_name(i) :=emp_rec.employee_name;
i=i+1;
DBMS_OUTPUT.PUT_LINE('Employee_name : ' || emp_name(i))
END LOOP;


END;
--4.Write a PL/SQL anonymous block that uses a cursor to fetch employee salaries from the "employees" table. If a salary is greater than 10000, display it. Handle any exceptions that may occur.
SET SERVEROUTPUT ON
DECLARE
  CURSOR emp_cursor
  IS
    SELECT salary FROM employees;
  salary_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(salary_exception, -20001);
BEGIN
  -- cursor for loop
  FOR emp_rec IN emp_cursor
  LOOP
    IF emp_rec.salary>10000 THEN
      DBMS_OUTPUT.PUT_LINE('EMPLOYEE_Salary is :' || emp_rec.salary);
    ELSE
      RAISE salary_exception;
    END IF ;
  END LOOP;
EXCEPTION
WHEN salary_exception THEN
  DBMS_OUTPUT.PUT_LINE(SQLCODE || ':' || SQLERRM);
END;
--5. Create a PL/SQL anonymous block that handles the "NO_DATA_FOUND" exception for a SELECT statement on the "employees" table. Instead of displaying the default Oracle error message,
--raise a custom exception with the error code -20101 and an error message "No employees found for the given criteria."

DECLARE 
CURSOR emp_cursor IS
select *
from employees;
PRAGMA EXCEPTION_INIT( NO_DATA_FOUND ,-20101)
BEGIN
open emp_cursor;
loop
when 
end loop;
close emp_cursor;

END LOOP;


EXCEPTION

END;

--6.Write a PL/SQL anonymous block that performs the following actions:
--a) Attempts to update an employee's salary in the "employees" table.
--b) Handle the "TOO_MANY_ROWS" exception and raise a custom exception with error code -20102 and an error message "More than one employee found for the given criteria."
--c) Handle the "NO_DATA_FOUND" exception and raise a custom exception with error code -20103 and an error message "No employee found for the given criteria."
--d) Handle all other exceptions by displaying a generic error message.
SET SERVEROUTPUT ON
DECLARE
EX_TOO_MANY_ROWS EXCEPTION;
EX_NO_DATA_FOUND EXCEPTION;
pragma EXCEPTION_INIT(EX_TOO_MANY_ROWS,-20102);
PRAGMA EXCEPTION_INIT(EX_NO_DATA_FOUND,-20103);
V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
FOR EMP_REC IN 
(SELECT SALARY 
INTO V_SALARY
FROM EMPLOYEES 
WHERE DEPARTMENT_ID=7)

LOOP 
V_SALARY:=V_SALARY*1.1;
IF V_SALARY%NOTFOUND
THEN RAISE EX_NO_DATA_FOUND;
ELSIF V_SALARY%ROWCOUNT>1
THEN RAISE EX_TOO_MANY_ROWS;
END IF ;
END LOOP;
EXCEPTION
WHEN EX_TOO_MANY_ROWS THEN 
DBMS_OUTPUT.PUT_LINE(SQLCODE || SQLERRM || 'TOO MANY ROWS TO PRINT');
WHEN EX_NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE(SQLCODE || SQLERRM || 'NO DATA IS FOUND TO PRINT');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('ERROR IS BEIING GENERATED PLEASE CHECK IT ');
END;

SELECT *
FROM EMPLOYEES

--7.Create a PL/SQL anonymous block that prompts the user to enter an employee ID. Attempt to fetch the employee's name and salary from the "employees" table.
--If the employee is not found, raise a user-defined error with the error code -20201 and an error message "Employee ID not found."
--If the entered employee ID is negative, raise a user-defined error with the error code -20202 and an error message "Invalid employee ID entered."
--
--8.Write a PL/SQL anonymous block that handles the "DUP_VAL_ON_INDEX" exception when inserting a new department record into the "departments" table. 
--Instead of displaying the default Oracle error message, raise a custom error using RAISE_APPLICATION_ERROR with the error code -20301 and an error message "Department ID already exists."