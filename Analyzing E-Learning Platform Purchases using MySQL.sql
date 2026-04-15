-- PROJECT: Analyzing E-Learning Platform Purchases using MySQL --
-- To Create socialmedia_db database --
create database if not exists E_Learning_db;
use E_Learning_db;

-- 1. Create the database and schema --
-- create a learners table:
/*
| Attribute        | Type            |
| -------------- | ------------------|
| learner id     | INT (primary key) |
| full_name      | varchar           |
| country        | varchar           |
*/

-- -- create a courses table:
/*
| Attribute      | Type              |
| -------------- | ------------------|
| course_id       | INT (primary key) |
|course_name     | varchar           |
| category       | varchar           |
|unit_price      |int                |
*/
-- -- create a purchases table:
/*
| Attribute      | Type              |
| -------------- | ------------------|
| purchase_id    | INT (primary key) |
|learner_id      | foreign key       |
| course_id      | foreign key       |
|quantity        |int                |
|purchase_date   | datetime          |
*/

create table if not exists learners(
learner_id INT PRIMARY KEY AUTO_INCREMENT,
full_name varchar(100) not null,		
Country VARCHAR(50)
 );

create table if not exists courses(
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name varchar(100) not null,
category varchar(50) not null,
unit_price int not null
);

create table if not exists purchases(
purchase_id INT PRIMARY KEY auto_increment,
learner_id int,
course_id int,
Quantity INT not null,
purchase_date datetime,
FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

--- INSERT SAMPLE DATA --
INSERT INTO learners (full_name, country) VALUES
('John Doe', 'USA'),
('Priya Sharma', 'India'),
('Arun Kumar', 'India'),
('Emily Clark', 'UK'),
('Michael Lee', 'Canada'),
('Sophia Brown', 'Australia'),
('Rahul Verma', 'India'),
('David Miller', 'USA'),
('Aisha Khan', 'UAE'),
('Divya Kumar', 'Spain');

INSERT INTO courses (course_name, category, unit_price) VALUES
('SQL for Beginners', 'Data Analytics', 2000),
('Advanced Python', 'Programming', 3500),
('Power BI Dashboard', 'Data Analytics', 3000),
('Machine Learning Basics', 'AI', 5000),
('Web Development Bootcamp', 'Development', 4000),
('Excel for Data Analysis', 'Data Analytics', 1500),
('Java Programming', 'Programming', 3200),
('Digital Marketing', 'Marketing', 2500),
('Cloud Computing', 'IT', 4500),
('Cyber Security Fundamentals', 'IT', 4800);

INSERT INTO purchases (learner_id, course_id, quantity, purchase_date) VALUES
(1, 1, 1, '2025-01-10'),
(2, 2, 1, '2025-01-18'),
(3, 3, 2, '2025-02-05'),
(4, 4, 1, '2025-02-20'),
(5, 5, 1, '2025-03-12'),
(6, 6, 3, '2025-03-25'),
(7, 7, 1, '2025-04-08'),
(8, 8, 2, '2025-04-22'),
(9, 9, 1, '2025-05-10'),
(10, 10, 1, '2025-05-28'),

(1, 3, 1, '2025-06-15'),
(2, 5, 2, '2025-06-30'),
(3, 2, 1, '2025-07-07'),
(4, 6, 2, '2025-07-19'),
(5, 1, 1, '2025-08-03'),
(6, 4, 1, '2025-08-17'),
(7, 8, 2, '2025-09-01'),
(8, 7, 1, '2025-09-14'),
(9, 10, 3, '2025-10-06'),
(10, 9, 1, '2025-10-25');

select * from learners;
select * from courses;
select * from purchases;

-- 2. Data Exploration Using Joins --
-- Format currency values to 2 decimal places --
SELECT 
    format(SUM(c.unit_price * p.quantity), 2)
FROM purchases p
JOIN courses c ON p.course_id = c.course_id;

-- Use aliases for column names (e.g., AS total_revenue) --
SELECT 
    SUM(c.unit_price * p.quantity) AS total_revenue
FROM purchases p
JOIN courses c ON p.course_id = c.course_id;

-- Sort results appropriately (e.g., highest total_spent first) --
SELECT 
    l.full_name AS learner_name,
    SUM(c.unit_price * p.quantity) AS total_spent
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.full_name
ORDER BY total_spent DESC;

-- Use SQL INNER JOIN, LEFT JOIN, and RIGHT JOIN to: --
-- Combine learner, course, and purchase data. --
SELECT 
    l.full_name AS learner_name,
    c.course_name AS course,
    p.quantity AS quantity,
    p.purchase_date AS purchase_date
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id;

-- Display each learner’s purchase details (course name, category, quantity, total amount, and purchase date). --
select l.full_name ,c.course_name,c.category,p.quantity, (c.unit_price * p.quantity) AS total_amount,p.purchase_date 
from purchases p
join learners l on p.learner_id = l.learner_id
join courses c on p.course_id = c.course_id;

-- 3. Analytical Queries --
-- Q1. Display each learner’s total spending (quantity × unit_price) along with their country --
select l.full_name,l.country, sum(c.unit_price * p.quantity) AS total_spent
from purchases p
join learners l on p.learner_id = l.learner_id
join courses c on p.course_id = c.course_id
GROUP BY l.full_name, l.country;

-- Q2. Find the top 3 most purchased courses based on total quantity sold --
select c.course_name, SUM(p.quantity) AS total_quantity
from purchases p
join courses c on p.course_id = c.course_id
group by c.course_name
order by total_quantity desc
limit 3;

-- Q3. Show each course category’s total revenue and the number of unique learners who purchased from that category --
select c.category, COUNT(DISTINCT p.learner_id), SUM(c.unit_price * p.quantity) AS total_revenue
from purchases p
join courses c on p.course_id = c.course_id
group by c.category;

-- Q4. List all learners who have purchased courses from more than one category -- 
	select l.full_name,
		COUNT(DISTINCT c.category) AS category_count
	FROM purchases p
	JOIN learners l ON p.learner_id = l.learner_id
	JOIN courses c ON p.course_id = c.course_id
	GROUP BY l.full_name
	HAVING COUNT(DISTINCT c.category) > 1;

-- Q5. Identify courses that have not been purchased at all --
SELECT 
    c.course_name
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.course_id IS NULL;

-- Q6. Find the most active learner (who made the most purchases) --
select l.full_name, COUNT(p.purchase_id) AS total_purchases
from purchases p
Join learners l on  p.learner_id = l.learner_id
group by l.full_name
order by total_purchases desc
limit 1;

-- Q7. Find the lowest revenue generating course --
select c.course_name, SUM(c.unit_price * p.quantity) AS total_revenue
from purchases p
join courses c on p.course_id = c.course_id
group by c.course_name
order by total_revenue ASC
limit 3;

-- Q8. Find the highest revenue generating course --
select c.course_name, SUM(c.unit_price * p.quantity) AS total_revenue
from purchases p
join courses c on p.course_id = c.course_id
group by c.course_name
order by total_revenue desc
limit 3;

-- Q9. Find monthly revenue based on purchase date --
 SELECT MONTH(p.purchase_date) AS month, SUM(c.unit_price * p.quantity) AS total_revenue
from purchases p
join courses c on p.course_id - c.course_id
GROUP BY MONTH(p.purchase_date)
ORDER BY month;

