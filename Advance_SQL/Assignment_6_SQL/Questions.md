
1. Explicit Cursor:
a) Create an explicit cursor named "employee_cursor" to retrieve the details of employees from the "employees" table.
b) Open the cursor and fetch the first three records from the cursor.
c) Display the employee ID, first name, last name, and hire date for each of the fetched records.
d) Close the cursor.

2. Cursor FOR LOOP:
a) Write a PL/SQL block using a cursor FOR LOOP to display the names and salaries of all employees in the "employees" table.
b) Ensure that the employees' names are displayed in uppercase and their salaries are increased by 10% before displaying them.

3. Explicit Cursor:
a) Create an explicit cursor named "department_cursor" to retrieve department details from the "departments" table.
b) Open the cursor and fetch the department name and manager ID for each department.
c) Display the department name and manager ID for each record.
d) Close the cursor.

4. Cursor FOR LOOP with Nested Cursor:
a) Create an explicit cursor named "department_cursor" to retrieve department IDs and names from the "departments" table.
b) Use a cursor FOR LOOP to loop through each department record.
c) For each department, create a nested cursor named "employee_cursor" to retrieve the names of employees who work in that department from the "employees" table.
d) Use another cursor FOR LOOP to display the names of employees in each department.
