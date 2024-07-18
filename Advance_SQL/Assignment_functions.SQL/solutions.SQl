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

----a
--create or replace procedure insert_employee
--(p_id IN employees.employee_id%type,
--p_first_name IN employees.first_name%type,
--p_last_ame IN employees.last_name%type,
--p_email IN employees.email%type,
--p_dept_id employees.department_id%type,
--p_salary employees.salary%type,
--p_manager_id employees.manager_id%type,
--p_hire_date employees.hire_date%type)
--IS 
--BEGIN
--INSERT INTO employees(employee_id,first_name,last_name,email,department_id,salary,manager_id,hire_date)
--VALUES()
--DBMS_OUTPUT.PUT_LINE('Employee_data is beign inserted ');
--END insert_employee;
--
----b
--create or replace function salarycalulate
--(p_input_hours_worked IN INTEGER,
--p_hourly_rate IN INTEGER)
--return NUMBER
--IS
--p_salary  employees.salary%type;
--BEGIN
--p_salary :=p_input_hours*p_hourly_rate;
--DBMS_OUTPUT.PUT_LINE('The salary obtained by the employee is: ' || p_salary );
--return p_salary 
--END salarycalculate;
--
--
----c 
--create or replace procedure  edit_job_title
--(p_employee_id employees.employe_id%type)
--IS
--BEGIN
--
--update 
--END edit_job_title;
--
---d 
--create or replace function return_employee
--(p_department_id  IN employees.department_id%type)
--return number
--IS
--v_count number;
--BEGIN
--select count(*)
--into v_count
--from employees 
--where department_id =p_department_id;
--return v_count;
--END return_employee;



CREATE OR REPLACE PACKAGE employee_pkg IS

  -- Procedure to insert a new employee into the database
  PROCEDURE insert_employee(
    p_id          IN employees.employee_id%TYPE,
    p_first_name  IN employees.first_name%TYPE,
    p_last_name   IN employees.last_name%TYPE,
    p_email       IN employees.email%TYPE,
    p_dept_id     IN employees.department_id%TYPE,
    p_salary      IN employees.salary%TYPE,
    p_manager_id  IN employees.manager_id%TYPE,
    p_hire_date   IN employees.hire_date%TYPE
  );
  
  -- Function to calculate the salary of an employee
  FUNCTION calculate_salary(
    p_hours_worked  IN INTEGER,
    p_hourly_rate   IN INTEGER
  ) RETURN NUMBER;
  
  -- Procedure to update the job title of an employee
  PROCEDURE update_job_title(
    p_employee_id  IN employees.employee_id%TYPE,
    p_new_job_title IN employees.job_title%TYPE
  );
  
  -- Function to retrieve the number of employees in a specific department
  FUNCTION count_employees_in_department(
    p_department_id  IN employees.department_id%TYPE
  ) RETURN NUMBER;

END employee_pkg;
/




CREATE OR REPLACE PACKAGE BODY employee_pkg IS


 -- Procedure to insert a new employee into the database
  PROCEDURE insert_employee(
    p_id          IN employees.employee_id%TYPE,
    p_first_name  IN employees.first_name%TYPE,
    p_last_name   IN employees.last_name%TYPE,
    p_email       IN employees.email%TYPE,
    p_dept_id     IN employees.department_id%TYPE,
    p_salary      IN employees.salary%TYPE,
    p_manager_id  IN employees.manager_id%TYPE,
    p_hire_date   IN employees.hire_date%TYPE
  ) IS
  BEGIN
    INSERT INTO employees(employee_id, first_name, last_name, email, department_id, salary, manager_id, hire_date)
    VALUES (p_id, p_first_name, p_last_name, p_email, p_dept_id, p_salary, p_manager_id, p_hire_date);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employee inserted successfully.');
  END insert_employee;
  
  -- Function to calculate the salary of an employee
  FUNCTION calculate_salary(
    p_hours_worked  IN INTEGER,
    p_hourly_rate   IN INTEGER
  ) RETURN NUMBER IS
    v_salary NUMBER;
  BEGIN
    v_salary := p_hours_worked * p_hourly_rate;
    DBMS_OUTPUT.PUT_LINE('Calculated salary for ' || p_hours_worked || ' hours worked at ' || p_hourly_rate || ' per hour is ' || v_salary);
    RETURN v_salary;
  END calculate_salary;
  
  -- Procedure to update the job title of an employee
  PROCEDURE update_job_title(
    p_employee_id  IN employees.employee_id%TYPE,
    p_new_job_title IN employees.job_title%TYPE
  ) IS
  BEGIN
    UPDATE employees
    SET job_title = p_new_job_title
    WHERE employee_id = p_employee_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Job title updated for employee ID ' || p_employee_id);
  END update_job_title;
  
  -- Function to retrieve the number of employees in a specific department
  FUNCTION count_employees_in_department(
    p_department_id  IN employees.department_id%TYPE
  ) RETURN NUMBER IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM employees
    WHERE department_id = p_department_id;
    
    DBMS_OUTPUT.PUT_LINE('Number of employees in department ' || p_department_id || ': ' || v_count);
    RETURN v_count;
  END count_employees_in_department;

END employee_pkg;
/


--8. Develop a PL/SQL package called `bank_operations_pkg` to handle basic banking operations. The package should include:
--   a. A procedure to deposit an amount into an account.
--   b. A procedure to withdraw an amount from an account, ensuring the balance does not go negative.
--   c. A function to calculate the interest on the account balance based on the interest rate and time period.
--   d. A procedure to transfer funds from one account to another.




-- Package Specification --
CREATE OR REPLACE PACKAGE bank_operations_pkh IS

--   a. A procedure to deposit an amount into an account.
  PROCEDURE deposit(
    p_account_id   IN NUMBER,
    p_amount       IN NUMBER
  ) IS
    v_balance NUMBER;
    
--   b. A procedure to withdraw an amount from an account, ensuring the balance does not go negative.
      PROCEDURE withdraw(
    p_account_id   IN NUMBER,
    p_amount       IN NUMBER
  ) IS
    v_balance NUMBER;
    
--   c. A function to calculate the interest on the account balance based on the interest rate and time period.
      FUNCTION calculate_interest(
    p_account_id   IN NUMBER,
    p_interest_rate IN NUMBER,
    p_time_period  IN NUMBER
  ) RETURN NUMBER IS
    v_balance NUMBER;
    v_interest NUMBER;
    
-- Procedure to transfer funds from one account to another
  PROCEDURE transfer_funds(
    p_from_account_id  IN NUMBER,
    p_to_account_id    IN NUMBER,
    p_amount           IN NUMBER
  ) IS
    v_from_balance NUMBER;
    v_to_balance NUMBER;
    
END bank_opeartions_pkg;





--Package BODY --
CREATE OR REPLACE PACKAGE BODY bank_operations_pkg IS



  -- Procedure to deposit an amount into an account
  PROCEDURE deposit(
    p_account_id   IN NUMBER,
    p_amount       IN NUMBER
  ) IS
    v_balance NUMBER;
  BEGIN
    -- Retrieving the  current balance
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id
    FOR UPDATE;
    
    -- Adding deposit amount to balance
    v_balance := v_balance + p_amount;
    
    -- Update the balance in the accounts table
    UPDATE accounts
    SET balance = v_balance
    WHERE account_id = p_account_id;
    
    COMMIT;
  END deposit;
  
  
  
  -- Procedure to withdraw an amount from an account, ensuring non-negative balance
  PROCEDURE withdraw(
    p_account_id   IN NUMBER,
    p_amount       IN NUMBER
  ) IS
    v_balance NUMBER;
  BEGIN
    -- Retrieving the  current balance
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id
    FOR UPDATE;
    
    -- Check if sufficient balance is available
    IF v_balance >= p_amount THEN
      -- Subtract withdrawal amount from balance
      v_balance := v_balance - p_amount;
      
      -- Updating the balance in the accounts table
      UPDATE accounts
      SET balance = v_balance
      WHERE account_id = p_account_id;
      
      COMMIT;
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds');
    END IF;
  END withdraw;



  -- Function to calculate interest on the account balance
  FUNCTION calculate_interest(
    p_account_id   IN NUMBER,
    p_interest_rate IN NUMBER,
    p_time_period  IN NUMBER
  ) RETURN NUMBER IS
    v_balance NUMBER;
    v_interest NUMBER;
  BEGIN
    -- Retrieve current balance
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id;
    
    -- Calculate interest
    v_interest := (v_balance * p_interest_rate * p_time_period) / 100;
    
    RETURN v_interest;
  END calculate_interest;
  
  -- Procedure to transfer funds from one account to another
  PROCEDURE transfer_funds(
    p_from_account_id  IN NUMBER,
    p_to_account_id    IN NUMBER,
    p_amount           IN NUMBER
  ) IS
    v_from_balance NUMBER;
    v_to_balance NUMBER;
  BEGIN
    -- Ensure different accounts are involved
    IF p_from_account_id = p_to_account_id THEN
      RAISE_APPLICATION_ERROR(-20002, 'Source and destination accounts cannot be the same');
    END IF;
    
    -- Retrieve balances
    SELECT balance INTO v_from_balance
    FROM accounts
    WHERE account_id = p_from_account_id
    FOR UPDATE;
    
    SELECT balance INTO v_to_balance
    FROM accounts
    WHERE account_id = p_to_account_id
    FOR UPDATE;
    
    -- Check if sufficient balance is available for withdrawal
    IF v_from_balance >= p_amount THEN
      -- Perform transfer
      v_from_balance := v_from_balance - p_amount;
      v_to_balance := v_to_balance + p_amount;
      
      -- Update balances in the accounts table
      UPDATE accounts
      SET balance = v_from_balance
      WHERE account_id = p_from_account_id;
      
      UPDATE accounts
      SET balance = v_to_balance
      WHERE account_id = p_to_account_id;
      
      COMMIT;
    ELSE
      RAISE_APPLICATION_ERROR(-20003, 'Insufficient funds for transfer');
    END IF;
  END transfer_funds;



END bank_operations_pkg;
/



--9. Create a package named order_management that allows adding and listing orders. It should include:
--
--A procedure to add an order (order ID, customer name, order total).
--A function to calculate the total revenue (sum of all order totals).
--A cursor to list all orders.
--




-- package SPECIFIACTION --
CREATE OR REPLACE PACKAGE order_management IS

  -- Procedure to add an order
  PROCEDURE add_order(
    p_order_id      IN NUMBER,
    p_customer_name IN VARCHAR2,
    p_order_total   IN NUMBER
  );
  
  -- Function to calculate total revenue (sum of all order totals)
  FUNCTION calculate_total_revenue RETURN NUMBER;
  
  -- Cursor to list all orders
  PROCEDURE list_orders;

END order_management;
/








--Package BODY---
CREATE OR REPLACE PACKAGE BODY order_management IS


  -- Procedure to add an order
  PROCEDURE add_order(
    p_order_id      IN NUMBER,
    p_customer_name IN VARCHAR2,
    p_order_total   IN NUMBER
  ) IS
  BEGIN
    INSERT INTO orders(order_id, customer_name, order_total)
    VALUES (p_order_id, p_customer_name, p_order_total);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Order added successfully.');
  END add_order;
  
  -- Function to calculate total revenue
  FUNCTION calculate_total_revenue RETURN NUMBER IS
    v_total_revenue NUMBER;
  BEGIN
    SELECT SUM(order_total)
    INTO v_total_revenue
    FROM orders;
    
    RETURN v_total_revenue;
  END calculate_total_revenue;
  
  
  
  
  -- Cursor to list all orders
  PROCEDURE list_orders IS
    CURSOR orders_cursor IS
      SELECT order_id, customer_name, order_total
      FROM orders;
    v_order_id orders.order_id%TYPE;
    v_customer_name orders.customer_name%TYPE;
    v_order_total orders.order_total%TYPE;
  BEGIN
    OPEN orders_cursor;
    LOOP
      FETCH orders_cursor INTO v_order_id, v_customer_name, v_order_total;
      EXIT WHEN orders_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id || ', Customer Name: ' || v_customer_name || ', Order Total: ' || v_order_total);
    END LOOP;
    CLOSE orders_cursor;
  END list_orders;



END order_management;
/







--10. Extend the order_management package with exception handling:
--
--Modify the add order procedure to handle cases where the order total is negative or zero by raising appropriate exceptions.
--Handle these exceptions in a way that the caller receives a meaningful error message.







-- package SPECIFIACTION --
CREATE OR REPLACE PACKAGE order_management IS

  -- Procedure to add an order
  PROCEDURE add_order(
    p_order_id      IN NUMBER,
    p_customer_name IN VARCHAR2,
    p_order_total   IN NUMBER
  );
  
  -- Function to calculate total revenue (sum of all order totals)
  FUNCTION calculate_total_revenue RETURN NUMBER;
  
  -- Cursor to list all orders
  PROCEDURE list_orders;

END order_management;
/







-- PACKAGE BODY ---
--Package BODY---
CREATE OR REPLACE PACKAGE BODY order_management IS



  -- Procedure to add an order
  PROCEDURE add_order(
    p_order_id      IN NUMBER,
    p_customer_name IN VARCHAR2,
    p_order_total   IN NUMBER
  ) IS
  BEGIN
    -- Check for negative or zero order total
    IF p_order_total <= 0 THEN
      RAISE invalid_order_total;
    ELSE
      -- Insert the order into the orders table
      INSERT INTO orders(order_id, customer_name, order_total)
      VALUES (p_order_id, p_customer_name, p_order_total);
      
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Order added successfully.');
    END IF;
  EXCEPTION
    WHEN invalid_order_total THEN
      RAISE_APPLICATION_ERROR(-20001, 'Invalid order total: Order total must be greater than zero.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'An error occurred while adding the order.');
  END add_order;
  
  
  
    -- Cursor to list all orders
  PROCEDURE list_orders IS
    CURSOR orders_cursor IS
      SELECT order_id, customer_name, order_total
      FROM orders;
    v_order_id orders.order_id%TYPE;
    v_customer_name orders.customer_name%TYPE;
    v_order_total orders.order_total%TYPE;
  BEGIN
    OPEN orders_cursor;
    LOOP
      FETCH orders_cursor INTO v_order_id, v_customer_name, v_order_total;
      EXIT WHEN orders_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id || ', Customer Name: ' || v_customer_name || ', Order Total: ' || v_order_total);
    END LOOP;
    CLOSE orders_cursor;
  EXCEPTION:
    WHEN OTHERS THEN 
      RAISE_APPLICATION_ERROR(-20004, 'An error occurred while listing orders.');
  END list_orders;



  -- Function to calculate total revenue
  FUNCTION calculate_total_revenue RETURN NUMBER IS
    v_total_revenue NUMBER;
  BEGIN
    SELECT SUM(order_total)
    INTO v_total_revenue
    FROM orders;
    
    RETURN v_total_revenue;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20003, 'An error occurred while calculating total revenue.');
  END calculate_total_revenue;
  
  
END order_management;
/
