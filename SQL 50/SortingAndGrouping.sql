# Sorting and grouping 

# 2356. Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

# 1141. User Activity for the Past 30 Days I
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity WHERE activity_date BETWEEN DATE('2019-07-27') - INTERVAL 29 DAY AND '2019-07-27'
GROUP BY activity_date 
ORDER BY activity_date;

# 1070. Product Sales Analysis III
WITH FirstYearSales AS (
    SELECT product_id, MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
)
SELECT 
    s.product_id, 
    f.first_year, 
    s.quantity, 
    s.price
FROM FirstYearSales f
JOIN Sales s
ON f.product_id = s.product_id AND f.first_year = s.year;

# 596. Classes More Than 5 Students
Select class from Courses 
GROUP BY class 
HAVING COUNT(student) >= 5;

# 1729. Find Followers Count
Select user_id, count(distinct follower_id) as followers_count
from followers group by user_id;

# 619. Biggest Single Number
SELECT MAX(num) AS num
FROM (SELECT num FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS SingleNumbers;

# 1045. Customers Who Bought All Products
WITH ProductCount AS (
    SELECT COUNT(*) AS total_products
    FROM Product
),
CustomerProductCount AS (
    SELECT customer_id, COUNT(DISTINCT product_key) AS purchased_products
    FROM Customer
    GROUP BY customer_id
)
SELECT c.customer_id
FROM CustomerProductCount c
JOIN ProductCount p
ON c.purchased_products = p.total_products;