# BASIC JOINS 

# 1378. Replace Employee ID With The Unique Identifier
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;

# 1068. Product Sales Analysis I
Select Product.product_name, Sales.year, Sales.price 
FROM Sales JOIN Product
ON Sales.product_id = Product.product_id; 

# 1581. Customer Who Visited but Did Not Make Any Transactions
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits v LEFT JOIN Transactions t
ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;

# 197. Rising Temperature
SELECT w1.id
FROM Weather w1 JOIN Weather w2
ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;

# 1661. Average Time of Process per Machine
SELECT A.machine_id, ROUND(AVG(E.timestamp - S.timestamp), 3) AS processing_time
FROM Activity A
JOIN Activity S ON A.machine_id = S.machine_id 
                    AND A.process_id = S.process_id 
                    AND S.activity_type = 'start'
JOIN Activity E ON A.machine_id = E.machine_id 
                    AND A.process_id = E.process_id 
                    AND E.activity_type = 'end'
GROUP BY A.machine_id;
    
# 577. Employee Bonus
Select Employee.name, Bonus.bonus 
From employee Left Join Bonus 
ON Employee.empId = Bonus.empId where bonus <1000 OR bonus IS NULL;

# 1280. Students and Examinations
SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;

# 570. Managers with at Least 5 Direct Reports
SELECT e.name
FROM Employee e
JOIN Employee emp ON e.id = emp.managerId
GROUP BY e.id, e.name
HAVING COUNT(emp.id) >= 5;

# 1934. Confirmation Rate
SELECT S.user_id, ROUND(
        IFNULL(SUM(CASE WHEN C.action = 'confirmed' THEN 1 ELSE 0 END) / 
               COUNT(C.action), 0), 2) AS confirmation_rate
FROM Signups S
LEFT JOIN Confirmations C ON S.user_id = C.user_id
GROUP BY S.user_id;