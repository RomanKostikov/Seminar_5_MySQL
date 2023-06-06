# Используя СТЕ, выведите всех пользователей из таблицы users_profile

# SELECT * FROM users_profile;

WITH cte AS (
SELECT * FROM users_profile
)
SELECT * FROM cte;

# Используя СТЕ, подсчитайте количество активных пользователей . Задайте псевдоним результирующему окну. 

WITH cte AS (
SELECT * FROM users WHERE status = 'Active'
)
SELECT COUNT(*) AS TotalActiveUsers FROM cte;

#С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10: (пример для чисел от 1 до 3)

WITH RECURSIVE cte AS
(
SELECT 1 AS a, 1 AS result
UNION ALL
SELECT a + 1 AS a, (a + 1) * (a + 1)  AS result FROM cte
WHERE a < 10
)
SELECT * FROM cte;


CREATE TABLE T  (
TB VARCHAR(2), ID_CLIENT INT, ID_DOG INT, OSZ INT, PROCENT_RATE INT, RATING INT, SEGMENT VARCHAR(10)
)

INSERT T VALUES 
('A', 1, 111, 100, 6, 10, 'SREDN')
,('A', 1, 222, 150, 6, 10, 'SREDN')
,('A', 2, 333, 50, 9, 15, 'MMB')
,('B', 1, 444, 200, 7, 10, 'SREDN')
,('B', 3, 555, 1000,5, 16, 'CIB')
,('B', 4, 666, 500, 10, 20, 'CIB')
,('B', 4, 777, 10, 12, 17, 'MMB')
,('C', 5, 888, 20, 11, 21, 'MMB')
,('C', 5, 999, 200, 9, 13, 'SREDN')

select * 
, MAX(OSZ) OVER(PARTITION BY TB) as MAX_OSZ 
, AVG(PROCENT_RATE) OVER(PARTITION BY TB, SEGMENT) as AVG_PROCENT_RATE
, COUNT(*) OVER() TOTAL_DOG
from T


WITH all_contracts AS (
select * 
, MAX(OSZ) OVER(PARTITION BY TB) as MAX_OSZ 
, AVG(PROCENT_RATE) OVER(PARTITION BY TB, SEGMENT) as AVG_PROCENT_RATE
, COUNT(*) OVER() TOTAL_DOG
, ROW_NUMBER() OVER()
, RANK() OVER(ORDER BY OSZ DESC)
, DENSE_RANK() OVER(ORDER BY OSZ DESC)
, RANK() OVER(PARTITION BY TB ORDER BY OSZ DESC) rn
from T
)
SELECT * FROM all_contracts
WHERE rn = 1
ORDER BY 1, 14




