# Advanced Select and Joins

# 1731. The Number of Employees Which Report to Each Employee
SELECT Manager.employee_id, Manager.name, COUNT(Employee.employee_id) AS reports_count, ROUND(AVG(Employee.age)) AS average_age
FROM Employees AS Manager
INNER JOIN Employees AS Employee ON (Employee.reports_to = Manager.employee_id)
GROUP BY 1
ORDER BY 1;

# 1789. Primary Department for Each Employee
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag='Y' OR 
    employee_id in
    (SELECT employee_id
    FROM Employee
    Group by employee_id
    having count(employee_id)=1);

# 610. Triangle Judgement
Select * , if(x+y>z and y+z>x and x+z>y, "Yes", "No") AS triangle
FROM Triangle;

# 180. Consecutive Numbers
SELECT distinct Num as ConsecutiveNums
FROM Logs
WHERE (Id + 1, Num) in (select * from Logs) and (Id + 2, Num) in (select * from Logs);

# 1164. Product Price at a Given Date
select distinct product_id, 10 as price from Products where product_id not in(select distinct product_id 
from Products where change_date <='2019-08-16' )
union 
select product_id, new_price as price from Products where (product_id,change_date) in (select product_id , max(change_date) as date
from Products where change_date <='2019-08-16' group by product_id);

# 1204. Last Person to Fit in the Bus
SELECT person_name
FROM (
    SELECT person_name, 
    SUM(weight) OVER (ORDER BY turn) AS total_weight,
    ROW_NUMBER() OVER (ORDER BY turn) AS rn
    FROM Queue
) AS subquery
WHERE total_weight <= 1000
ORDER BY rn DESC
LIMIT 1;

# 1907. Count Salary Categories
SELECT
  'Low Salary' AS Category,
  SUM(income < 20000) AS accounts_count
FROM Accounts
UNION ALL
SELECT
  'Average Salary' Category,
  SUM(income >= 20000 AND income <= 50000) AS accounts_count
FROM Accounts
UNION ALL
SELECT
  'High Salary' category,
  SUM(income > 50000) AS accounts_count
FROM Accounts;
