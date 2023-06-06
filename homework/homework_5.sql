use seminar_5;

# task001
-- Таблица автомобилей
create table if not exists auto (
	id_auto int auto_increment primary key,
    name varchar(50) not null,
    cost decimal (10, 2) check (cost > 0)
);

insert into auto (name, cost) values
('Audi', 52642.00),
('Mersedes', 57127.00),
('Skoda', 9000.00),
('Volvo', 29000.00),
('Bently', 350000.00),
('Citroen', 21000.00),
('Hummer', 41400.00),
('Volkswagen', 21600.00);

select * from auto;

-- 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
create or replace view car_cost as
(select * from auto where cost < 25000.00);

-- проверка
select * from car_cost;

-- 2.	Изменить в существующем представлении порог для стоимости:
--      пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
alter view car_cost as
(select * from auto where cost < 30000.00);

-- проверка
select * from car_cost;

-- 3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
create or replace view car_model as
(select * from auto where name in ('Skoda', 'Audi'));

-- проверка
select * from car_model;

# task002
-- Таблицы: анализ, группы, заказ.
-- Создание и заполнение таблиц
create table if not exists Groupses(
	gr_id int auto_increment primary key,
    gr_name varchar(100) not null,
    gr_temp float
);

create table if not exists Analysis (
	an_id int auto_increment primary key,
    an_name varchar(100) not null,
    an_cost decimal (10,2),
    an_price decimal (10,2) check (an_price > 0),
    an_group int,
    foreign key (an_group) references Groupses(gr_id) on delete cascade
);

create table if not exists Orders(
	ord_id int auto_increment primary key,
    ord_datetime timestamp,
    ord_an int,
    foreign key (ord_an) references Analysis(an_id) on delete cascade
);

insert into Groupses (gr_name, gr_temp) values
('Группа анализов №1', -18.5),
('Группа анализов №2', -15),
('Группа анализов №3', -1.5);

insert into Analysis (an_name, an_cost, an_price, an_group) values
('Анализ №1', 1000.00, 3300.00, 1),
('Анализ №2', 3000.00, 6000.00, 1),
('Анализ №3', 1500.00, 4500.00, 2),
('Анализ №4', 5500.00, 2125.00, 2),
('Анализ №5', 1500.00, 4000.00, 3),
('Анализ №6', 5000.00, 13000.00, 3);

insert into Orders (ord_datetime, ord_an) values
('2020-01-30 09:00:00', 1),
('2020-02-06 14:00:00', 2),
('2020-02-06 13:30:00', 3),
('2020-02-07 15:30:00', 4),
('2020-02-09 12:00:00', 5),
('2020-02-10 11:30:00', 6),
('2020-02-05 14:30:00', 3),
('2020-02-08 12:30:00', 2),
('2020-02-14 11:00:00', 1);

/*
Вывести название и цену для всех анализов,
которые продавались 5 февраля 2020 и всю следующую неделю.
*/

with date_ord as
(select * from Orders
where ord_datetime regexp '2020-02-([0][5-9]|[1][0-2])')
select an_name 'Название анализа', an_price 'Стоимость анализа', ord_datetime 'Дата проведения'
from Analysis
join date_ord
on an_id = ord_an
order by ord_datetime;

# task003
-- оконные функции
-- Создание и заполнение таблицы
create table if not exists Travel (
	train_id int,
    station varchar(20) not null,
    station_time time
);

insert into Travel (train_id, station, station_time) values
	(110, 'San Francisco', '10:00:00'),
	(110, 'Redwood City', '10:54:00'),
	(110, 'Palo Alto', '11:02:00'),
	(110, 'San Jose', '12:35:00'),
	(120, 'San Francisco', '11:00:00'),
	(120, 'Palo Alto', '12:49:00'),
	(120, 'San Jose', '13:30:00');

select * from Travel;
/*
Добавьте новый столбец под названием «время до следующей станции».
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает значения из одной строки со следующей строкой, 
чтобы получить результат. В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/

select *,
timediff(lead(station_time) over (partition by train_id order by station_time), station_time) 'time_to_next_station'
from Travel;