1. Create a stored procedure named "GET_EMPLOYEES" that returns all employee details from the "employees" table.
2. Modify the "GET_EMPLOYEES" stored procedure to accept an input parameter "department_id" 
   and return only the employees who belong to that department.
3. Create a stored procedure named "GET_EMPLOYEES_IN_DEPT" that accepts a department ID as an input parameter. 
   Use a cursor to fetch all employee names and salaries for the given department and display the results.
4. Create a new object type "employee_type" with attributes for "employee_id," "first_name," "last_name," and "salary."
   Create a nested table type "employee_table" using the "employee_type" object type.
   Write a stored procedure named "INSERT_EMPLOYEES" that accepts an array of employee records (employee_table) as input 
   and inserts them into the "employees" table.
   The procedure should handle the situation when the provided department ID does not exist in the "DEPARTMENTS" table. 
   In such cases, it should raise a custom exception and display an appropriate error message.
5. Create a stored procedure named "UPDATE_SALARY_BATCH" that takes an array of employee IDs and a percentage increase as inputs. 
   The procedure should update the salaries of the employees whose IDs are in the input array with the given percentage increase.