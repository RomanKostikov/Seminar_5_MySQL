CREATE TABLE users (
username VARCHAR(50) PRIMARY KEY,
password VARCHAR(50) NOT NULL,
status VARCHAR(10) NOT NULL);

CREATE TABLE users_profile (
username VARCHAR(50) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE);

INSERT INTO users values
('admin' , '7856', 'Active'),
('staff' , '90802', 'Active'),
('manager' , '35462', 'Inactive');

INSERT INTO users_profile values
('admin', 'Administrator' , 'Dhanmondi', 'admin@test.com' ) ,
('staff', 'Jakir Nayek' , 'Mirpur', 'zakir@test.com' ),
('manager', 'Mehr Afroz' , 'Eskaton', 'mehr@test.com' );

-- SELECT * FROM users_profile;

-- 1.	Используя СТЕ, выведите всех пользователей из таблицы users_profile
WITH cte AS (
SELECT * FROM users_profile
)
SELECT * FROM cte;

-- 2.	Используя СТЕ, подсчитайте количество активных пользователей . Задайте псевдоним результирующему окну.
-- Пример:
WITH cte AS (
SELECT * FROM users WHERE STATUS = 'Active'
)
SELECT COUNT(*) AS TotalActiveUsers FROM cte;
-- 3. 	С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10:(пример для чисел от 1 до 3)
WITH RECURSIVE cte AS
(
SELECT 1 AS a, 1 AS result
UNION ALL
SELECT a + 1 AS a, (a+1)*(a+1) AS result FROM cte
WHERE a < 10
)
SELECT * FROM cte;