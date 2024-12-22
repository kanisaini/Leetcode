# SQL 50

# SELECT 
# 1757. Recyclable and Low Fat Products
Select product_id FROM Products Where low_fats="Y" and recyclable="Y";

# 584. Find Customer Referee
Select name FROM Customer Where referee_id != 2 OR referee_id IS NULL;

# 595. Big Countries
SELECT name, population, area FROM World WHERE area >= 3000000 OR population >= 25000000;

# 1148. Article Views I
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id ASC;

# 1683. Invalid Tweets
SELECT tweet_id FROM Tweets WHERE LENGTH(content) > 15;


