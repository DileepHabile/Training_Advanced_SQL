
--1--
--Method-1--  with the common table expresssion method
with averageDepartmentSalary  AS
(select 
D.department_name as dept_name,
avg(E.salary) as Avg_Salary
from employees E
join departments D
on e.department_id= d.department_id
group by D.department_name)

Select dept_name,
Avg_salary,
Rank()over(ORDER BY Avg_salary) AS Department_rank
from  averageDepartmentSalary ;


--Method-2  normal method
SELECT 
    D.department_name AS dept_name,
    AVG(E.salary) AS Avg_Salary,
    RANK() OVER (ORDER BY AVG(E.salary) DESC) AS Department_rank
FROM employees E
JOIN departments D 
    ON E.department_id = D.department_id
GROUP BY 
    D.department_name;



--2--
--Method-1  normal method
 select 
    e.first_name,
    d.department_name,
    round(months_between(sysdate,e.hire_date)/12) as tenure,
    RANK()
    over(
    partition by department_name 
    order by   round(months_between(sysdate,e.hire_date)/12)desc
    ) AS tenure_rank   
    from employees e
    join departments d
    on e.department_id=d.department_id

--Method-2  with common table expression as 
WITH EmployeeTenure AS (
    SELECT
        employee_id,
        first_name,
        department_id,
        hire_date,
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS tenure_in_years,
        RANK() OVER (PARTITION BY department_id ORDER BY TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) DESC) AS rank_tenure
    FROM
        employees
)
SELECT
    employee_id,
    first_name,
    department_id,
    hire_date,
    tenure_in_years,
    rank_tenure
FROM
    EmployeeTenure
ORDER BY
    department_id, rank_tenure;



--3
--- just a expression not the actual query--
select 
employee_id,
first_name,
last_name,
hire_date,
salary
lead(salary,1)
over(
order by hire_date
) as next_hired_salary,
slalry-next_hired_salary 
from employees

--query
SELECT 
    employee_id,
    first_name,
    last_name,
    hire_date,
    salary,
    LEAD(salary, 1) OVER (ORDER BY hire_date) AS next_hired_salary,
    salary - LEAD(salary, 1) OVER (ORDER BY hire_date) AS salary_difference
FROM 
    employees;


--4  just an extension of the 3rd problem

WITH cte AS (
    SELECT 
        employee_id,
        first_name,
        last_name,
        hire_date,
        salary,
        LEAD(salary, 1) OVER (ORDER BY hire_date) AS next_hired_salary,
        salary - LEAD(salary, 1) OVER (ORDER BY hire_date) AS salary_difference
    FROM 
        employees
)
SELECT 
    employee_id,
    first_name,
    last_name,
    hire_date,
    salary,
    next_hired_salary,
    salary_difference,
    FIRST_VALUE(next_hired_salary) OVER (ORDER BY salary_difference) AS res
FROM 
    cte;



--5
