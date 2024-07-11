1.Create a PL/SQL anonymous block that performs the following actions:
a) Open a cursor to fetch employee information.
b) For each employee, attempt to divide their salary by 0. Handle the "ZERO_DIVIDE" exception at this level by displaying a custom error message for each employee.
c) Handle any other exceptions that may occur during the loop by displaying a generic error message.

2.Create a PL/SQL anonymous block that declares a nested table type to store integers. Initialize a nested table variable and insert some random integers into it. Then, loop through the nested table and display the elements.

3.Create a PL/SQL anonymous block that uses a cursor to fetch employee names from the "employees" table and stores them in a collection (nested table or associative array). Then, display the employee names from the collection.

4.Write a PL/SQL anonymous block that uses a cursor to fetch employee salaries from the "employees" table. If a salary is greater than 10000, display it. Handle any exceptions that may occur.

5. Create a PL/SQL anonymous block that handles the "NO_DATA_FOUND" exception for a SELECT statement on the "employees" table. Instead of displaying the default Oracle error message, raise a custom exception with the error code -20101 and an error message "No employees found for the given criteria."

6.Write a PL/SQL anonymous block that performs the following actions:
a) Attempts to update an employee's salary in the "employees" table.
b) Handle the "TOO_MANY_ROWS" exception and raise a custom exception with error code -20102 and an error message "More than one employee found for the given criteria."
c) Handle the "NO_DATA_FOUND" exception and raise a custom exception with error code -20103 and an error message "No employee found for the given criteria."
d) Handle all other exceptions by displaying a generic error message.

7.Create a PL/SQL anonymous block that prompts the user to enter an employee ID. Attempt to fetch the employee's name and salary from the "employees" table. If the employee is not found, raise a user-defined error with the error code -20201 and an error message "Employee ID not found." If the entered employee ID is negative, raise a user-defined error with the error code -20202 and an error message "Invalid employee ID entered."

8.Write a PL/SQL anonymous block that handles the "DUP_VAL_ON_INDEX" exception when inserting a new department record into the "departments" table. Instead of displaying the default Oracle error message, raise a custom error using RAISE_APPLICATION_ERROR with the error code -20301 and an error message "Department ID already exists."