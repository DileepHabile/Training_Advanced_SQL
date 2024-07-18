1. Write a PL/SQL trigger named "update_salary_trigger" that automatically updates the "new_salary" column in the "employee" 
table with a 10% increase whenever a new record is inserted into the "salary_change" table.

2. Create a trigger named "check_inventory_trigger" that prevents the insertion of a new order into the "orders" table 
if the ordered quantity exceeds the available quantity in the "products" table.

3. Develop a trigger called "audit_inserts_trigger" that logs the details of every INSERT statement executed on the "customer" table
 into an "audit_log" table.

4. Write a trigger named "discount_trigger" that automatically updates the "discount" column in the "orders" table. 
   If the total order amount is greater than $1000, set the discount to 15%; otherwise, set it to 5%.

5. Create a trigger named "update_total_trigger" that automatically updates the "total_amount" column in the "orders" table 
   whenever a new order item is inserted or updated. Handle the "mutating table" error appropriately.

6. Design a trigger named "update_manager_salary" that automatically updates the "salary" of the manager 
   whenever an employee's salary in the "employee" table is updated.

7. Write a trigger named "check_credit_limit_trigger" that prevents inserting a new order into the "orders" table 
   if the customer's total order amount would exceed their predefined credit limit.

8. Create a trigger named "employee_history_trigger" that captures the previous values of the "salary" and "job_title" 
   columns in the "employee_history" table whenever an update occurs in the "employee" table.

9. Develop a trigger named "update_product_stock_trigger" that automatically updates the "stock_quantity" in the "products" table
   when a new order is inserted into the "order_details" table.

10. Write a script that deactivates the "discount_trigger" from exercise 4 and then reactivates it after a specified period.