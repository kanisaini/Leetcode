# Advanced String Functions / Regex / Clause

# 1667. Fix Names in a Table
SELECT user_id, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;

# 1527. Patients With a Condition
select patient_id,patient_name,conditions from Patients
where conditions like 'DIAB1%'  or  conditions like '% DIAB1%' ;

# 196. Delete Duplicate Emails
DELETE p1 FROM Person p1, Person p2
WHERE p1.Email = p2.Email AND p1.Id > p2.Id;

# 176. Second Highest Salary
Select max(salary) as SecondHighestSalary 
from Employee  
Where salary < (select max(salary) from Employee);

# 1484. Group Sold Products By The Date
SELECT sell_date, COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

# 1327. List the Products Ordered in a Period
select product_name, sum(unit) as unit from products
join orders using(product_id)
where year(order_date)=2020 and month(order_date)=2
group by 1
having sum(unit)>99;

# 1517. Find Users With Valid E-Mails
SELECT * FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode[.]com$';