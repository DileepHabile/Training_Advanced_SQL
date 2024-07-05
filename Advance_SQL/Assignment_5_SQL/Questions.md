1. Implicit Cursors:
a) What is an implicit cursor in PL/SQL? Explain its purpose and characteristics.
b) Write a PL/SQL block that uses an implicit cursor to fetch and display the names of all employees from the "employees" table.

2. Write a PL/SQL block to retrieve and display the details of an employee with a specific ID. Prompt the user to enter the employee ID as input.

3. Write a PL/SQL block that inserts a new department record into the "departments" table. Prompt the user to enter the department name and location as input.

4. Write a PL/SQL block to handle the NO_DATA_FOUND exception while fetching an employee's details based on a given employee ID. Display a custom message when the exception occurs.

5. Transaction Management:
a) Write a PL/SQL block that transfers an employee from one department to another. Update the "departments" table and the "employees" table to reflect the change. Ensure that both updates are treated as a single transaction and are committed only if both succeed.
b) Create a stored procedure that allows updating an employee's job title and salary simultaneously. If the job title is updated successfully, but the salary update fails, the procedure should roll back the job title change.

6. Write a PL/SQL block to retrieve the employee details (employee_id, first_name, last_name, and salary) from the "employees" table for a given department ID (prompt user). If no employees are found, display "No employees found for the given department."

7. Create a PL/SQL block that increases the salary of all employees in the "sales" department by 10%. Display the affected employee IDs and their updated salaries.

8. Write a PL/SQL block that deletes all employees who have a salary less than 3000 and hire date older than 5 years. Display the count of deleted employees.

9. Write a PL/SQL block to insert a new record into the "employees" table.