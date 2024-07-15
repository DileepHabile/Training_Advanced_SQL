--1. Write a PL/SQL function called `calculate_area` that takes two parameters: `length` and `width`.
--The function should calculate and return the area of a rectangle. Test the function with different input values.
--
CREATE
  FUNCTION calculate_area(
      p_length IN INTEGER,
      p_width  IN INTEGER)
    RETURN INTEGER
  IS
    p_area INTEGER;
  BEGIN
    p_area :=p_length*p_width;
    DBMS_OUTPUT.PUT_LINE('The area of the rectangle is :' || p_area);
    RETURN p_area;
  END calculate_area;
  -- Invoking the written function
  DECLARE
    LENGTH INTEGER := 10;
    width  INTEGER := 5;
    area   INTEGER;
  BEGIN
    area := calculate_area(LENGTH, width);
    DBMS_OUTPUT.PUT_LINE('Length: ' || LENGTH || ', Width: ' || width || ', Area: ' || area);
  END;
  /
  --/
  --CREATE OR REPLACE FUNCTION calculate_area(
  --    p_length  IN INTEGER,
  --    p_width   IN INTEGER
  --)
  --RETURN INTEGER
  --IS
  --    p_area INTEGER;
  --BEGIN
  --
  --    p_area := p_length * p_width;
  --
  --    -- Output the area (optional for demonstration)
  --    DBMS_OUTPUT.PUT_LINE('The area of the rectangle is: ' || p_area);
  --
  --
  --    RETURN p_area;
  --END calculate_area;
  --/
  calculate_area(7,7);
  --2. Create a PL/SQL function called `reverse_string` that takes a string as input
  --and returns the reverse of the input string.
  --Test the function with various strings, including empty strings.
  --
CREATE
FUNCTION reverse_string(
    p_input_string IN VARCHAR2(
      30))
IS
  p_output_string VARCHAR2(30);
  v_temp          VARCHAR2(30);
BEGIN
  FOR i IN REVERSE 1..LENGTH(p_input_string)
  LOOP
    v_output_string := v_output_string || SUBSTR(p_input_string, i, 1);
  END LOOP;
  RETURN output_string;
END reverse_string;
--3. Write a PL/SQL function called `safe_division` that takes two parameters: `numerator` and `denominator`.
--The function should perform division and handle the scenario where the `denominator` is zero by returning NULL.
--Test the function with different input values, including a zero denominator.
--
CREATE
FUNCTION safe_division(
    p_numerator   IN INTEGER,
    p_denominator IN INTEGER)
  RETURN NUMBER
IS
  p_quotient NUMBER;
BEGIN
  IF p_denominator =0 THEN
    RETURN NULL;
  ELSE
    p_quotient:=p_numerator/p_denominator;
    RETURN p_quotient;
  EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
  END safe_divison;
  -- Test cases
  DECLARE
    num1   INTEGER := 10;
    num2   INTEGER := 2;
    num3   INTEGER := 8;
    num4   INTEGER := 0;
    result NUMBER;
  BEGIN
    result := safe_division(num1, num2);
    DBMS_OUTPUT.PUT_LINE(num1 || ' / ' || num2 || ' = ' || result);
    result := safe_division(num3, num4);
    DBMS_OUTPUT.PUT_LINE(num3 || ' / ' || num4 || ' = ' || result);
    result := safe_division(num1, num3);
    DBMS_OUTPUT.PUT_LINE(num1 || ' / ' || num3 || ' = ' || result);
  END;
  /
  ----
  --CREATE OR REPLACE FUNCTION safe_division
  --(p_numerator IN INTEGER,
  -- p_denominator IN INTEGER)
  --RETURN NUMBER
  --IS
  --    p_quotient NUMBER;  s
  --BEGIN
  --    -- Perform division
  --    IF p_denominator = 0 THEN
  --        RETURN NULL;
  --    ELSE
  --        p_quotient := p_numerator / p_denominator;
  --        RETURN p_quotient;
  --    END IF;
  --EXCEPTION
  --    WHEN OTHERS THEN
  --        RETURN NULL;
  --END safe_division;
  --/
  --4.Create a function get_employee_count that takes a department ID as input
  --and returns the count of employees in that department from an employees table.
  --
CREATE
FUNCTION get_employee_count(
    p_department_id IN employees.department_id%type)
  RETURN INTEGER
IS
  p_count INTEGER ;
BEGIN
  SELECT COUNT(*)
  INTO p_count
  FROM employees
  WHERE department_id =p_department_id;
  RETURN p_count;
END get_employee_count;
-- Invoking the function
DECLARE
  v_dept_id employees.department_id%type:=101;
  v_count INTEGER;
BEGIN
  v_count :=get_employee_count(v_dept_id);
  DBMS_OUTPUT.PUT_LINE('Number of Employees in Department ' || v_dept_id || ': ' || v_count);
END;
--
--CREATE OR REPLACE FUNCTION get_employee_count
--(p_department_id IN employees.department_id%type)
--RETURN INTEGER
--IS
--    p_count INTEGER;
--BEGIN
--
--    SELECT COUNT(*)
--    INTO p_count
--    FROM employees
--    WHERE department_id = p_department_id;
--
--    RETURN p_count;
--END get_employee_count;
--/
--5. Create a function get_employee_salary that takes an employee ID as input and returns the salary of the employee.
--Handle the case where the employee ID is not found by raising a custom exception.
--
CREATE get_employee_salary (p_employee_id IN employees.employee_id%type)
  RETURN employees.salary%type
IS
  v_salary employees.salary%type;
BEGIN
  SELECT salary INTO p_salary FROM employees WHERE employee_id=p_employee_id;
  DBMS_OUTPUT.PUT_LINE(p_salary);
WHEN SQL%NOTFOUND THEN
  RAISE_APPLICATION_ERROR(-20001 ,'Employee_id' || p_employee_id || 'NOT FOUND')
  RETURN p_salary;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RAISE_APPLICATION_ERROR(-20001 ,'Employee_id' || p_employee_id || 'NOT FOUND')
END get_employee_salary;
-- Invkoing the functions with example employee_id;
DECLARE
  emp_id employees.employee_id%type := 100;
  emp_salary employees.salary%type;
BEGIN
  emp_salary := get_employee_salary(emp_id);
  DBMS_OUTPUT.PUT_LINE('Salary for Employee ID ' || emp_id || ': ' || emp_salary);
END;
/
--CREATE OR REPLACE FUNCTION get_employee_salary
--(p_employee_id IN employees.employee_id%type)
--RETURN employees.salary%type
--IS
--    v_salary employees.salary%type;
--BEGIN
--    SELECT salary
--    INTO v_salary
--    FROM employees
--    WHERE employee_id = p_employee_id;
--
--    IF SQL%NOTFOUND THEN
--        RAISE_APPLICATION_ERROR(-20001, 'Employee ID ' || p_employee_id || ' not found.');
--    END IF;
--
--    DBMS_OUTPUT.PUT_LINE('Employee ID ' || p_employee_id || ' Salary: ' || v_salary);
--
--    RETURN v_salary;
--EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--        RAISE_APPLICATION_ERROR(-20002, 'Employee ID ' || p_employee_id || ' not found.');
--END get_employee_salary;
--/
--6. Create a PL/SQL function named calculate_discount that takes the total amount as input
--and returns a discount amount based on the following conditions:
--
--If the total amount is less than 1000, apply a 5% discount.
--If the total amount is between 1000 and 5000, apply a 10% discount.
--If the total amount is greater than 5000, apply a 15% discount.
--
CREATE
FUNCTION calcualte_discount(
    p_input_amount IN INTEGER)
  RETURN INTEGER
IS
  p_discounted_amount INTEGER;
BEGIN
  IF p_input_amount     <1000 THEN
    p_discounted_amount:=p_input_amount-(p_input_amount*0.05);
  elsif p_input_amount >=1000 AND p_input_amount<=5000 THEN
    p_discounted_amount:=p_input_amount-(p_input_amount*0.1);
  ELSE
    p_discounted_amount:=p_input_amount-(p_input_amount*0.15);
  END IF ;
  DBMS_OUTPUT.PUT_LINE('Discounted_amount:' || p_discounted_output);
  RETURN p_discounted_amount;
END calculate_discount;
-- Invoking the function with example money
DECLARE
  input_amount      INTEGER := 800;
  discounted_amount INTEGER;
BEGIN
  discounted_amount := calculate_discount(input_amount);
  DBMS_OUTPUT.PUT_LINE('Original Amount: ' || input_amount);
  DBMS_OUTPUT.PUT_LINE('Discounted Amount: ' || discounted_amount);
END;
--
--CREATE OR REPLACE FUNCTION calculate_discount
--(p_input_amount IN INTEGER)
--RETURN INTEGER
--IS
--    p_discounted_amount INTEGER;
--BEGIN
--    IF p_input_amount < 1000 THEN
--        p_discounted_amount := p_input_amount - (p_input_amount * 0.05);  -- 5% discount
--    ELSIF p_input_amount >= 1000 AND p_input_amount <= 5000 THEN
--        p_discounted_amount := p_input_amount - (p_input_amount * 0.1);   -- 10% discount
--    ELSE
--        p_discounted_amount := p_input_amount - (p_input_amount * 0.15);  -- 15% discount
--    END IF;
--
--    DBMS_OUTPUT.PUT_LINE('Discounted Amount: ' || p_discounted_amount);  -- Output discounted amount (optional)
--
--    RETURN p_discounted_amount;
--END calculate_discount;
--/
/
--7. Create a PL/SQL package called `employee_pkg` to manage employee data. The package should contain:
--   a. A procedure to insert a new employee into the database.
--   b. A function to calculate the salary of an employee based on the input of hours worked and hourly rate.
--   c. A procedure to update the job title of an employee based on their ID.
--   d. A function to retrieve the number of employees in a specific department.
--
--Test each of the package procedures and functions with sample data.
--
--8. Develop a PL/SQL package called `bank_operations_pkg` to handle basic banking operations. The package should include:
--   a. A procedure to deposit an amount into an account.
--   b. A procedure to withdraw an amount from an account, ensuring the balance does not go negative.
--   c. A function to calculate the interest on the account balance based on the interest rate and time period.
--   d. A procedure to transfer funds from one account to another.
--
--9. Create a package named order_management that allows adding and listing orders. It should include:
--
--A procedure to add an order (order ID, customer name, order total).
--A function to calculate the total revenue (sum of all order totals).
--A cursor to list all orders.
--
--10. Extend the order_management package with exception handling:
--
--Modify the add order procedure to handle cases where the order total is negative or zero by raising appropriate exceptions.
--Handle these exceptions in a way that the caller receives a meaningful error message.