# Subqueries 

# 1978. Employees Whose Manager Left the Company
SELECT employee_id
FROM Employees
WHERE salary < 30000
    AND manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id;

# 626. Exchange Seats
SELECT 
    CASE 
        WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;
    
# Movie rating
WITH UserRatings AS (
    SELECT 
        u.name AS user_name,
        COUNT(mr.movie_id) AS rating_count
    FROM 
        Users u
    JOIN 
        MovieRating mr
        ON u.user_id = mr.user_id
    GROUP BY 
        u.name
),
MaxRatings AS (
    SELECT 
        MAX(rating_count) AS max_count
    FROM 
        UserRatings
),
TopUser AS (
    SELECT 
        user_name
    FROM 
        UserRatings
    WHERE 
        rating_count = (SELECT max_count FROM MaxRatings)
    ORDER BY 
        user_name
    LIMIT 1
),
MovieAvgRatings AS (
    SELECT 
        m.title AS movie_name,
        AVG(mr.rating) AS avg_rating
    FROM 
        Movies m
    JOIN 
        MovieRating mr
        ON m.movie_id = mr.movie_id
    WHERE 
        mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY 
        m.title
),
MaxMovieRatings AS (
    SELECT 
        MAX(avg_rating) AS max_avg
    FROM 
        MovieAvgRatings
),
TopMovie AS (
    SELECT 
        movie_name
    FROM 
        MovieAvgRatings
    WHERE 
        avg_rating = (SELECT max_avg FROM MaxMovieRatings)
    ORDER BY 
        movie_name
    LIMIT 1
)
SELECT 
    user_name AS results
FROM 
    TopUser
UNION ALL
SELECT 
    movie_name AS results
FROM 
    TopMovie;
    
# 1321. Restaurant Growth
WITH
  Dates AS (
    SELECT DISTINCT visited_on
    FROM Customer
    WHERE visited_on >= (
      SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY)
      FROM Customer
    )
  )
SELECT
  Dates.visited_on,
  SUM(Customer.amount) AS amount,
  ROUND(SUM(Customer.amount) / 7, 2) AS average_amount
FROM Dates
LEFT JOIN Customer
  ON (DATEDIFF(Dates.visited_on, Customer.visited_on) BETWEEN 0 AND 6)
GROUP BY 1;

# 602. Friend Requests II: Who Has the Most Friends
select requester_id as id,
       (select count(*) from RequestAccepted
            where id=requester_id or id=accepter_id) as num
from RequestAccepted
group by requester_id
order by num desc limit 1;

# 602. Friend Requests II: Who Has the Most Friends
SELECT id, COUNT(*) AS num 
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC 
LIMIT 1;

# 585. Investments in 2016
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);

# 185. Department Top Three Salaries
SELECT
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e JOIN Department d ON e.departmentId = d.id
WHERE
    (
        SELECT COUNT(DISTINCT salary)
        FROM Employee e2
        WHERE e2.departmentId = e.departmentId AND e2.salary >= e.salary
    ) <= 3
ORDER BY
    Department, Salary DESC;