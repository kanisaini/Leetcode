# Basic Aggregate Functions 

# 620. Not Boring Movies
SELECT movie, description, rating
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

# 1251. Average Selling Price
SELECT p.product_id, IFNULL(ROUND(SUM(units*price)/SUM(units),2),0) AS average_price
FROM Prices p LEFT JOIN UnitsSold u
ON p.product_id = u.product_id AND
u.purchase_date BETWEEN start_date AND end_date
group by product_id;

# 1075. Project Employees I
SELECT p.project_id,ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id;

# 1633. Percentage of Users Attended a Contest
SELECT r.contest_id, ROUND(COUNT(DISTINCT r.user_id) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM Register r
GROUP BY r.contest_id
ORDER BY 
    percentage DESC, 
    r.contest_id ASC;
    
# 1211. Queries Quality and Percentage
SELECT query_name,
    ROUND(AVG(rating / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
    
# 1193. Monthly Transactions I
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    DATE_FORMAT(trans_date, '%Y-%m'), country;

# 1174. Immediate Food Delivery II
WITH FirstOrders AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM 
        Delivery
    GROUP BY 
        customer_id
),
FirstOrderDetails AS (
    SELECT 
        d.customer_id,
        d.order_date,
        d.customer_pref_delivery_date,
        CASE 
            WHEN d.order_date = d.customer_pref_delivery_date THEN 1
            ELSE 0
        END AS is_immediate
    FROM 
        Delivery d
    JOIN 
        FirstOrders f
    ON 
        d.customer_id = f.customer_id AND d.order_date = f.first_order_date
)
SELECT 
    ROUND(SUM(is_immediate) * 100.0 / COUNT(*), 2) AS immediate_percentage
FROM 
    FirstOrderDetails;

# 550. Game Play Analysis IV
WITH FirstLogin AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_login_date
    FROM 
        Activity
    GROUP BY 
        player_id
),
NextDayLogins AS (
    SELECT 
        f.player_id,
        CASE 
            WHEN a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY) THEN 1
            ELSE 0
        END AS logged_next_day
    FROM 
        FirstLogin f
    LEFT JOIN 
        Activity a
    ON 
        f.player_id = a.player_id
)
SELECT 
    ROUND(SUM(logged_next_day) * 1.0 / COUNT(DISTINCT player_id), 2) AS fraction
FROM 
    NextDayLogins;