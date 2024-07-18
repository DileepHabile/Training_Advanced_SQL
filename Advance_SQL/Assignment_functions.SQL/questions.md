1. Write a PL/SQL function called `calculate_area` that takes two parameters: `length` and `width`. 
The function should calculate and return the area of a rectangle. Test the function with different input values.

2. Create a PL/SQL function called `reverse_string` that takes a string as input 
and returns the reverse of the input string. 
Test the function with various strings, including empty strings.

3. Write a PL/SQL function called `safe_division` that takes two parameters: `numerator` and `denominator`. 
The function should perform division and handle the scenario where the `denominator` is zero by returning NULL. 
Test the function with different input values, including a zero denominator.

4.Create a function get_employee_count that takes a department ID as input 
and returns the count of employees in that department from an employees table.

5. Create a function get_employee_salary that takes an employee ID as input and returns the salary of the employee. 
Handle the case where the employee ID is not found by raising a custom exception.

6. Create a PL/SQL function named calculate_discount that takes the total amount as input 
and returns a discount amount based on the following conditions:

If the total amount is less than 1000, apply a 5% discount.
If the total amount is between 1000 and 5000, apply a 10% discount.
If the total amount is greater than 5000, apply a 15% discount.

7. Create a PL/SQL package called `employee_pkg` to manage employee data. The package should contain:
   a. A procedure to insert a new employee into the database.
   b. A function to calculate the salary of an employee based on the input of hours worked and hourly rate.
   c. A procedure to update the job title of an employee based on their ID.
   d. A function to retrieve the number of employees in a specific department.

Test each of the package procedures and functions with sample data.

8. Develop a PL/SQL package called `bank_operations_pkg` to handle basic banking operations. The package should include:
   a. A procedure to deposit an amount into an account.
   b. A procedure to withdraw an amount from an account, ensuring the balance does not go negative.
   c. A function to calculate the interest on the account balance based on the interest rate and time period.
   d. A procedure to transfer funds from one account to another.

9. Create a package named order_management that allows adding and listing orders. It should include:

A procedure to add an order (order ID, customer name, order total).
A function to calculate the total revenue (sum of all order totals).
A cursor to list all orders.

10. Extend the order_management package with exception handling:

Modify the add order procedure to handle cases where the order total is negative or zero by raising appropriate exceptions.
Handle these exceptions in a way that the caller receives a meaningful error message.