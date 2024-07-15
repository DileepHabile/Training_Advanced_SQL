--1. Write a query to display the last name, department number, and department name for all employees. 

SELECT E.last_name,D.department_id,D.Department_name 
FROM employees E
JOIN departments D
ON E.department_id=D.department_id;


--2 Create a unique listing of all jobs that are in department 8. Include the location of the department in the output.
SELECT DISTINCT(j.job_title),D.location_id
FROM employees E
JOIN departments D
ON E.department_id=D.department_id
JOIN jobs J
ON E.job_id=J.job_id
WHERE D.department_id=8

--3  Write a query to display the employee last name, department name, location ID, and city of all employees.   

SELECT E.last_name,D.department_name,L.location_id,L.city
FROM employees E
JOIN departments D
ON E.department_id=D.department_id
JOIN locations L
ON D.location_id=L.location_id;


--4 Display the employee last name and department name for all employees who have an a (lowercase) in their last names.   
SELECT E.last_name,D.department_name
FROM employees E
JOIN departments D
ON E.department_id=D.department_id
WHERE E.last_name LIKE '%a%';


--5 Write a query to display the last name, job, department number, and department name for all
--% employees who work in Toronto.

SELECT E.last_name,J.Job_title,D.department_id,D.department_name,L.city
FROM employees E
JOIN departments D
ON E.department_id=D.department_id
JOIN jobs j
ON E.job_id=J.job_id
JOIN locations L
ON D.location_id=L.location_id;
--WHERE L.city = 'Toronto';

select *
from locations

--6 Display the employee last name and employee number along with their manager’s last name and manager number.
--Label the columns Employee, Emp#, Manager, and Mgr#, respectively.     

SELECT E1.last_name as Employee ,E1.employee_id  as Emp#,E2.last_name as Manager ,E2.employee_id as Mgr#
FROM employees E1
JOIN employees E2
ON E1.Manager_id=E2.Employee_id;


--7 Modify the query of #6 to display all employees including King, who has no manager.    

SELECT E1.last_name as Employee ,E1.employee_id  as Emp#,E2.last_name as Manager ,E2.employee_id as Mgr#
FROM employees E1
LEFT JOIN employees E2
ON E1.Manager_id=E2.Employee_id;


--8 Create a query that displays employee last names, department numbers, and all the
--employees who work in the same department as a given employee. Give each column an appropriate label.









-- 10. Create a query to display the name and hire date of any employee hired after employee Daniel. 
-- Solving using a Subquery

SELECT E1.first_name,E1.hire_date
FROM employees E1
WHERE E1.hire_date > (SELECT hire_date  
                      FROM employees E2
                      WHERE E2.first_name='Daniel');



-- 11. Display the names and hire dates for all employees who were hired before their managers, along with their manager’s names and hire dates.
-- Label the columns Employee, Emp Hired, Manager, and Mgr Hired, respectively.

SELECT  
  E1.first_name as Employee,
  E1.hire_date As Emp_hired ,
  E2.first_name as Manager,
  E2.hire_date as Mgr_hired  
FROM employees E1
JOIN employees E2
ON E1.manager_id=E2.employee_id
WHERE E1.hire_date<E2.hire_date;



--% 12. Determine the validity of the following three statements. Circle either True or False. 
--% 	a. Group functions work across many rows to produce one result.-True
--% 	b. Group functions include nulls in calculations.-False
--% The WHERE clause restricts rows prior to inclusion in a group calculation.-True




--% 13. Display the highest, lowest, sum, and average salary of all employees. Label the columns
--% Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.

SELECT MAX(salary) AS  Maximum_value  ,MIN(salary) AS Minimum_value ,SUM(salary) AS SUM_value,ROUND(AVG(salary)) AS Average_value
FROM employees 



--% 14. Modify the query in #13 to display the minimum, maximum, sum, and average salary for each job type.

SELECT job_id,MAX(salary) AS  Maximum_value  ,MIN(salary) AS Minimum_value ,SUM(salary) AS SUM_value,ROUND(AVG(salary)) AS Average_value
FROM employees 
GROUP BY Job_id 
ORDER BY job_id


--15. Write a query to display the number of people with the same job.

SELECT job_id, count(*) AS People_with_same_Job
FROM employees E1
GROUP BY job_id 

--% 16. Determine the number of managers without listing them. Label the column Number of
--% Managers. Hint: Use the MANAGER_ID column to determine the number of managers.

SELECT COUNT(DISTINCT (Manager_id)) AS NO_OF_Managers
FROM employees 


--% 17. Write a query that displays the difference between the highest and lowest salaries. Label the column DIFFERENCE. 

SELECT MAX(salary)-MIN(salary) AS DIFFERENCE
FROM employees 


--% 18. Display the manager number and the salary of the lowest paid employee for that manager.
--% Exclude anyone whose manager is not known. Exclude any groups where the minimum
--% salary is $6,000 or less. Sort the output in descending order of salary. 


SELECT Manager_id ,MIN(salary)
FROM employees 
GROUP BY Manager_id
HAVING MIN(salary) >6000
AND Manager_id IS NOT NULL;



select *
from employees


--% 19. Write a query to display each department’s name, location, number of employees, and the average salary for all employees in that department.
--%  Label the columns Name, Location,  Number of People, and Salary, respectively. Round the average salary to two decimal places.


SELECT D.department_name as Name,D.location_id as Location, Count(*) as Number_of_people, ROUND(AVG(salary)) AS salary
FROM employees E
JOIN departments D
ON E.department_id=D.department_id
GROUP BY department_name,location_id



--% 20. Create a query to display the job, the salary for that job based on department number, and the total salary for that job, for departments 2, 5, 8, and 9, 
--% giving each column an appropriate heading.

SELECT 
    J.job_title AS Job_Title,
    D.department_id AS Department_Number,
    AVG(E.salary) AS Average_Salary,
    SUM(E.salary) AS Total_Salary
FROM 
    employees E
JOIN 
    departments D ON E.department_id = D.department_id
JOIN 
    jobs J ON E.job_id = J.job_id
WHERE 
    D.department_id IN (2, 5, 8, 9)
GROUP BY 
    J.job_title, D.department_id
ORDER BY 
    D.department_id, J.job_title;



