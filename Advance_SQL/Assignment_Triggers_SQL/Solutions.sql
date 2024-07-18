--1. Write a PL/SQL trigger named "update_salary_trigger" that automatically updates the "new_salary" column in the "employee" 
--table with a 10% increase whenever a new record is inserted into the "salary_change" table.
create or replace trigger update_salary_trigger 
after  insert on employees
for each row 
declare 
v_old_salary number
begin  

select salary 
into v_old_salary
from employees 
where employee_id= :MEW.employee_id;

update employees 
set :new.salary=:old.salary*1.1;
where employee_id= :new.employee_id;
end;

--
CREATE OR REPLACE TRIGGER update_salary_trigger
AFTER INSERT ON salary_change
FOR EACH ROW
DECLARE
BEGIN
    UPDATE employees
    SET :new.salary = :old.salary * 1.1
    WHERE employee_id = :NEW.employee_id;  
END;
/

--2. Create a trigger named "check_inventory_trigger" that prevents the insertion of a new order into the "orders" table 
--if the ordered quantity exceeds the available quantity in the "products" table.
--
create or replace trigger check_inventory_trigger 
before insert on orders
for each row
declare 
v_available_quantity number 
begin 
--Fetching the avavilable quantity of the products from the products table 
select available_quantity 
into v_available_quantity
from products 
where product_id =:new.product_id;

if :new.ordered_quantitiy >v_available_quantity
then raise_pplication_error(-20202,'New order cannot be made ')
end if ;
end;
--3. Develop a trigger called "audit_inserts_trigger" that logs the details of every INSERT statement executed on the "customer" table
-- into an "audit_log" table.


CREATE OR REPLACE TRIGGER audit_inserts_trigger
AFTER INSERT ON customer
FOR EACH ROW
DECLARE
    v_operation VARCHAR2(100) := 'INSERT';
BEGIN
    INSERT INTO audit_log (table_name, operation, username)
    VALUES ('customer', v_operation, USER);
END;
/

--
--4. Write a trigger named "discount_trigger" that automatically updates the "discount" column in the "orders" table. 
--   If the total order amount is greater than $1000, set the discount to 15%; otherwise, set it to 5%.

CREATE OR REPLACE TRIGGER discount_trigger
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF :NEW.order_amount > 1000 THEN
        :NEW.discount := :NEW.order_amount * 0.15; 
    ELSE
        :NEW.discount := :NEW.order_amount * 0.05; 
    END IF;
END;
/
--5. Create a trigger named "update_total_trigger" that automatically updates the "total_amount" column in the "orders" table 
--   whenever a new order item is inserted or updated. Handle the "mutating table" error appropriately.
create or replace update_total_trigger
after insert or update of order on orders
for each row 
begin

CREATE OR REPLACE TRIGGER update_total_trigger
AFTER INSERT OR UPDATE OF order_amount ON orders
FOR EACH ROW
DECLARE
    v_total_amount NUMBER;
BEGIN
    SELECT SUM(order_amount) INTO v_total_amount
    FROM orders
    WHERE order_id = :NEW.order_id;

    UPDATE orders
    SET total_amount = v_total_amount
    WHERE order_id = :NEW.order_id;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; 
    WHEN OTHERS THEN
        NULL; 
END;
/

--6. Design a trigger named "update_manager_salary" that automatically updates the "salary" of the manager 
--   whenever an employee's salary in the "employee" table is updated.
CREATE OR REPLACE update_manager_salary 
after update of salary on employees
for each row 
declare 
v_manager_id employees.manager_id%type;
begin

select manager_id 
into v_manager_id
from employees 
where employee_id =:new.employee_id;

update employees
set salary =
where employee_id =v_manager_id;
end;


--7. Write a trigger named "check_credit_limit_trigger" that prevents inserting a new order into the "orders" table 
--   if the customer's total order amount would exceed their predefined credit limit.


create or replace trigger check_credit_limit_trigger 
before insert on orders
for each row 
declare 
v_credit_limit NUMBER ;
begin

select credit_limit 
into v_credit_limit
from orders
where order_id=:new.order_id;

if :new.order_amount >v_credit_limit
then raise_application_error(-20202,'The total amount exceeded the credit limit')
end if ;
end;


--8. Create a trigger named "employee_history_trigger" that captures the previous values of the "salary" and "job_title" 
--   columns in the "employee_history" table whenever an update occurs in the "employee" table.

create or replace trigger employee_history_trigger
after update on employees
for each row
begin

insert into employee_history(salary,job_title)
values (:old.salary ,:old.job_title)
end;

--9. Develop a trigger named "update_product_stock_trigger" that automatically updates the "stock_quantity" in the "products" table
--   when a new order is inserted into the "order_details" table.

CREATE TRIGGER update_product_stock_trigger
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    DECLARE product_id INT;
    DECLARE quantity_ordered INT;
    
    -- Get the product id and quantity ordered from the inserted row
    SELECT product_id, quantity INTO product_id, quantity_ordered
    FROM order_details
    WHERE order_id = NEW.order_id;  -- Assuming there's an order_id column in order_details
    
    -- Update the stock_quantity in the products table
    UPDATE products
    SET stock_quantity = stock_quantity - quantity_ordered
    WHERE id = product_id;
END //



--10. Write a script that deactivates the "discount_trigger" from exercise 4 and then reactivates it after a specified period.
-- Disable the discount_trigger
ALTER TRIGGER discount_trigger DISABLE;

-- Wait for a specified period (e.g., 1 minute)
BEGIN
    DBMS_LOCK.SLEEP(60); -- Sleep for 60 seconds (adjust as needed)
END;
/

-- Enable the discount_trigger again
ALTER TRIGGER discount_trigger ENABLE;
