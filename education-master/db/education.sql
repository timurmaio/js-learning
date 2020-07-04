 psql timing -U gulnara

 DROP DATABASE Timing;
 CREATE DATABASE Timing;

-- Задание:
-- Таблица 5_1. СТУДЕHТЫ (объединенные в гpуппы)
-- * Код студента
-- * Фамилия студента
-- * Пол
-- * Код группы
-- * Населенный пункт проживания

CREATE TYPE GENDER AS ENUM ('М', 'Ж');

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	sex GENDER NOT NULL,
	group_id INTEGER NOT NULL,
	town VARCHAR(50) NOT NULL DEFAULT 'Казань',
	CHECK (group_id >= 1)
);

-- ФАЙЛ 5_2. ГРУППЫ
-- * Код группы
-- * Номер группы
-- * Число студентов в группе
-- * Факультет
-- * Староста

-- CREATE TABLE groups (
-- 	id SERIAL PRIMARY KEY,
-- 	group_number VARCHAR(10) NOT NULL,
-- 	student_count INTEGER NOT NULL,
-- 	faculty VARCHAR(50) NOT NULL,
-- 	steward INTEGER NOT NULL,
-- 	FOREIGN KEY (steward) REFERENCES students(id) ON UPDATE CASCADE ON DELETE CASCADE
-- );
--Заполняем наши таблицы данными:

INSERT INTO students (name, surname, sex, group_id, town) VALUES ('Гульнара', 'Нигматзянова', 'Ж', '2', DEFAULT),
('Эмиль', 'Атажанов', 'М', '1', 'Астана'), ('Илюза', 'Сакаева', 'Ж', '1', 'Уфа'), ('Захар','Макаров','М','2','Москва'),
('Алина', 'Васильева', 'Ж', '5', DEFAULT),('Камиль', 'Морковников', 'М', '1', 'Рязань'),
('Марина', 'Петрушкина', 'Ж', '7', 'Арск'), ('Захар','Огурцов','М','2','Москва');

-- INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 3), ( '09-400', 28, 'ИВМиИТ', 1),
-- ( '09-307', 30, 'ИВМиИТ', 8),('09-306', 10, 'ИТИС', 4), ( '09-411', 17, 'ИВМиИТ', 7), ( '09-508', 12, 'ИВМиИТ', 2),
-- ('09-206', 21, 'ИВМиИТ', 2), ('09-211', 25, 'ИТИС', 6);
--
-- ALTER TABLE students ADD CONSTRAINT stud_group FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE;

-- Таблица 5_3. ПРЕПОДАВАТЕЛИ
-- * Код преподавателя
-- * Фамилия преподавателя
-- * Факультет
-- * Общая реальная нагрузка преподавателя(связать с таблицей занятия )
-- * Кафедра

-- CREATE TABLE professors (
-- 	id SERIAL PRIMARY KEY,
-- 	surname VARCHAR(50) NOT NULL,
-- 	faculty VARCHAR(50) NOT NULL,
-- 	classes INTEGER NOT NULL,
-- 	department VARCHAR(50) NOT NULL
-- );

-- Таблица 5_4. ПРЕДМЕТЫ
-- * Код предмета
-- * Наименование предмета*
-- * Вид отчетности (зачет, экзамен, курсовая)
-- * Тип (лекция или практика)
-- * Количество часов

-- CREATE TYPE REPORT_TYPE AS ENUM ('Зачет', 'Экзамен', 'Курсовая');
-- CREATE TYPE SUBJECT_TYPE AS ENUM ('Лекция', 'Практика');
--
-- CREATE TABLE subjects (
-- 	id SERIAL PRIMARY KEY,
-- 	name VARCHAR(50) NOT NULL,
-- 	report_type REPORT_TYPE NOT NULL,
-- 	subject_type SUBJECT_TYPE NOT NULL,
-- 	hours INTEGER NOT NULL
-- );


-- Таблица 5_5. ЗАHЯТИЯ (КТО, ЧТО, КОМУ - гpуппе, КОГДА, ГДЕ)
-- * Код преподавателя
-- * Код группы
-- * Код предмета
-- * Семестр
-- * Аудитория
-- * Время

-- CREATE TABLE classes (
-- 	id SERIAL PRIMARY KEY,
-- 	professors_id INTEGER NOT NULL REFERENCES professors(id),
-- 	group_id INTEGER NOT NULL,
-- 	subject_id INTEGER NOT NULL ,
-- 	semester INTEGER NOT NULL,
-- 	audience VARCHAR(10) NOT NULL,
-- 	start_time VARCHAR(11) NOT NULL,
-- 	FOREIGN KEY (group_id) REFERENCES groups(id),
-- 	FOREIGN KEY (subject_id) REFERENCES subjects(id)
-- );

--Заполняем наши таблицы данными:

-- INSERT INTO professors (surname,faculty, classes,department) VALUES ('Бухараев', 'ИВМИИТ', 0, 'КТП'), ('Еникеев', 'ИВМИИТ', 0, 'КТП'),
-- ('Георгиев', 'ИВМИИТ', 0, 'КТП'), ('Гусенков', 'ИВМИИТ', 0, 'КТП'), ('Туйкин', 'ИВМИИТ', 0, 'КТП'), ('Степанова', 'ИВМИИТ', 0, 'КТП'),
-- ('Мокичев', 'ИУЭФ', 0, 'КЭТ'), ('Серебряков', 'ИСФНМК', 0, 'КОФ'), ('Чебакова', 'ИВМИИТ', 0, 'КМС'), ('Турилова', 'ИВМИИТ', 0, 'КТП'),
-- ('Халиуллин', 'ИВМИИТ', 0, 'КТП');
--
-- INSERT INTO subjects (name, report_type, subject_type, hours) VALUES ('Базы Данных', 'Зачет', 'Лекция', 18), ('Базы Данных', 'Зачет', 'Практика', 18),
-- ('ПАПС', 'Зачет', 'Лекция', 18), ('ПАПС', 'Зачет', 'Практика', 36), ('ТПО', 'Зачет', 'Лекция', 18), ('ТПО', 'Зачет', 'Практика', 36),
-- ('ОИБ', 'Экзамен', 'Лекция', 36), ('ОКГ', 'Зачет', 'Практика', 18), ('ОКГ', 'Зачет', 'Практика', 36), ('Физ-ра', 'Зачет', 'Практика', 66);
--
-- INSERT INTO classes (professors_id, group_id, subject_id, semester, audience, start_time) VALUES (5, 3, 1, 5, '1111', '17:00-18:30');



-------------------------------------------EXPLAIN-----------------------------------------------------------------------------
-- EXPLAIN - команда выводит план выполнения, генерируемый планировщиком PostgreSQL для заданного оператора.
-- План выполнения показывает, как будут сканироваться таблицы, затрагиваемые оператором — 
-- просто последовательно, по индексу и т. д. — а если запрос связывает
-- несколько таблиц, какой алгоритм соединения будет выбран для объединения считанных из них строк.

 explain select * from students;

                          QUERY PLAN
-------------------------------------------------------------
 Seq Scan on students  (cost=0.00..12.00 rows=200 width=366)
(1 row)

-- данные читаются из таблицы последовательно, блок за блоком.
-- затратность на получение первой строки .. всех строк
-- приблизительное кол-во возвращаемых строк
-- средний размер одной строки в байтах
-- так как приблизительное количество строк отличается от реального, а explain -только ожидание
-- планировщика, попробуем сверить их с результатом на реальных данных

EXPLAIN (Analyze) select * from students;
--теперь количество возвращаемых строк равно количеству строк в таблице = 8

CREATE OR REPLACE FUNCTION loop(n int) RETURNS VOID AS
$$ DECLARE
group_id int;
e int;
s varchar;
name varchar;
surname varchar;
town varchar;
array1 varchar[];
array2 varchar[];
array3 varchar[];
BEGIN
   s:='abcdefghijklmnopqrstuv';
       FOR i IN 1..n LOOP
       group_id := trunc(random()*8+1);
           FOR j IN 1..5 LOOP
           e := trunc(random()*21+1);
           SELECT substring(s from e for 1) INTO name;
           e := trunc(random()*21+1);
           SELECT substring(s from e for 1) INTO surname;
           e := trunc(random()*21+1);
           SELECT substring(s from e for 1) INTO town;
           array1:=array_append(array1, name);
           array2:=array_append(array2, surname);
           array3:=array_append(array2, town);
           END LOOP;
       name := array_to_string(array1,'');
       surname := array_to_string(array2,'');
       town := array_to_string(array3,'');
       INSERT INTO students(name, surname, sex, group_id, town) VALUES (name, surname, 'Ж',group_id, town);
       array1 := '{NULL}';
       array2 := '{NULL}';
       name := ' ';
       surname := ' ';
       town := ' ';
       END LOOP;
END;
$$
LANGUAGE 'plpgsql';

select loop(2992);

timing=> explain select * from students;

                          QUERY PLAN
---------------------------------------------------------------
 Seq Scan on students  (cost=0.00..521.00 rows=30000 width=31)
(1 row)
--теперь приблизительное количество возвращаемых строк равно количесту строк в таблице
--для запроса используется последовательный поиск

--создадим индекс в виде В-дерева для поля  в таблице students
create unique index student_id ON students (id);

--снова посмотрим на план запроса
timing=> explain select id from students;
                          QUERY PLAN
--------------------------------------------------------------
 Seq Scan on students  (cost=0.00..521.00 rows=30000 width=4)
(1 row)
--не смотря на большое количество данных и индекс, для запроса все равно используется seq scan
--попросим принудительно использовать только индекс
set enable_seqscan to off;
explain (analyze) select * from students
where id > 150;


                                                            QUERY PLAN
----------------------------------------------------------------------------------------------------------------------------------
 Index Scan using student_id on students  (cost=0.29..1081.71 rows=29853 width=31) (actual time=0.023..12.735 rows=29855 loops=1)
   Index Cond: (id > 150)
 Planning time: 0.210 ms
 Execution time: 15.187 ms
(4 rows)

-- теперь используется index scan по индексу student_id, затратность операции намного больше чем при
-- последовательном поиске, поэтому планировщик его и использовал изначально.
-- отменяем запрет
set enable_seqscan to on;

explain select * from students
where id < 150 ;

                                  QUERY PLAN
-------------------------------------------------------------------------------
 Index Scan using student_id on students  (cost=0.29..11.86 rows=147 width=31)
   Index Cond: (id < 150)
(2 rows)

explain select * from students
where id > 150 ;
                          QUERY PLAN
---------------------------------------------------------------
 Seq Scan on students  (cost=0.00..596.00 rows=29853 width=31)
   Filter: (id > 150)
(2 rows)

-- в первом случае планировщик использует поиск по индексу, потому что точно знает, сколько ему
-- понадобиться только записей, а во втором случае ему понадобятся все записи => уже не так важно
-- что использовать, ведь при поиске по индексу затратность операции намного больше.

-- добавим в запрос условие, связанное с текстовым полем
-- сначала для >150
timing=> explain select * from students
timing-> where id > 150 and name LIKE 'a%';
                          QUERY PLAN
--------------------------------------------------------------
 Seq Scan on students  (cost=0.00..671.00 rows=1212 width=31)
   Filter: ((id > 150) AND ((name)::text ~~ 'a%'::text))
(2 rows)
--используется seq scan и два условия в фильтр

timing=> explain select * from students
where id < 150 and name LIKE 'a%';
                                 QUERY PLAN
-----------------------------------------------------------------------------
 Index Scan using student_id on students  (cost=0.29..12.23 rows=6 width=31)
   Index Cond: (id < 150)
   Filter: ((name)::text ~~ 'a%'::text)
(3 rows)

--используется index scan и одно условие в фильтр, так как индекса по этому полю нет
-- созданим этот индекс

CREATE INDEX student_name ON students(name);

explain select * from students where name like 'a%';

                          QUERY PLAN
--------------------------------------------------------------
 Seq Scan on students  (cost=0.00..596.00 rows=1218 width=31)
   Filter: ((name)::text ~~ 'a%'::text)


-- индекс не используется потому что база для текстовых полей использует формат UTF-8.
-- при создании индекса нужно использовать класс оператора text_pattern_ops

DROP INDEX student_name;

CREATE INDEX student_name ON students(name text_pattern_ops);

timing=> explain select * from students
where name LIKE 'a%';

 QUERY PLAN
--------------------------------------------------------------------------------------
 Bitmap Heap Scan on students  (cost=29.34..266.28 rows=1218 width=31)
   Filter: ((name)::text ~~ 'a%'::text)
   ->  Bitmap Index Scan on student_name  (cost=0.00..29.04 rows=1275 width=0)
         Index Cond: (((name)::text ~>=~ 'a'::text) AND ((name)::text ~<~ 'b'::text))
(4 rows)

-- теперь планировщик воспользовался bitmap index scan для определения нужных нам записей с помощью
-- индекса student_name и width=0 так как планировщику не требуется читать строку таблицы.
-- затем он использует Bitmap Heap Scan по полю students, чтобы убедиться, что эти записи
-- существуют и width=31, так как приходится читать строку полностью.

-- seq scan - читается вся таблица
-- index scan - используется индекс (при where)
-- bitmap index scan - сначала index scan, затем выборка из таблицы.
-- index only scan - читается только индекс.

-- Воспользуемся order by (сортировкой) в запросе:
DROP INDEX student_id;
EXPLAIN (Analyze) select * from students order by id;

                                                              QUERY PLAN
--------------------------------------------------------------------------------------------------------------------------------------
 Index Scan using students_pkey on students  (cost=0.29..1010.29 rows=30000 width=31) (actual time=25.875..36.990 rows=30000 loops=1)
 Planning time: 0.287 ms
 Execution time: 39.318 ms
(3 rows)

-- так как на поле id весит первичный ключ, поработаем с полем town и вернем индекс для поля id
create index student_id ON students(id);

EXPLAIN (Analyze) select * from students order by town;

                                                    QUERY PLAN
-------------------------------------------------------------------------------------------------------------------
 Sort  (cost=2751.90..2826.90 rows=30000 width=31) (actual time=98.840..101.955 rows=30000 loops=1)
   Sort Key: town
   Sort Method: quicksort  Memory: 3113kB
   ->  Seq Scan on students  (cost=0.00..521.00 rows=30000 width=31) (actual time=0.013..5.358 rows=30000 loops=1)
 Planning time: 0.116 ms
 Execution time: 103.588 ms
(6 rows)

-- сначала используется последовательный поиск, затем сортировка:
-- (sort key - условие сортировки)
-- Sort Method: quicksort (- тип сортировки)  Memory: 3113kB говорит о том, что при сортировке используется временный файл
-- на диске объемом 3113kB

LIMIT

EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM students WHERE name LIKE 'ab%' LIMIT 10;

QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------------
Limit  (cost=5.03..158.63 rows=3 width=31) (actual time=0.091..0.136 rows=10 loops=1)
Buffers: shared hit=11
->  Bitmap Heap Scan on students  (cost=5.03..158.63 rows=3 width=31) (actual time=0.090..0.133 rows=10 loops=1)
Filter: ((name)::text ~~ 'ab%'::text)
Heap Blocks: exact=9
Buffers: shared hit=11
->  Bitmap Index Scan on student_name  (cost=0.00..5.03 rows=74 width=0) (actual time=0.056..0.056 rows=69 loops=1)
Index Cond: (((name)::text ~>=~ 'ab'::text) AND ((name)::text ~<~ 'ac'::text))
Buffers: shared hit=2
Planning time: 0.467 ms
Execution time: 0.189 ms
(11 rows)

--удалим индекс
DROP INDEX student_name;

EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM students WHERE name LIKE 'ab%' LIMIT 10;

QUERY PLAN
------------------------------------------------------------------------------------------------------------
Limit  (cost=0.00..596.00 rows=3 width=31) (actual time=0.235..1.327 rows=10 loops=1)
Buffers: shared hit=33
->  Seq Scan on students  (cost=0.00..596.00 rows=3 width=31) (actual time=0.234..1.323 rows=10 loops=1)
Filter: ((name)::text ~~ 'ab%'::text)
Rows Removed by Filter: 4441
Buffers: shared hit=33
Planning time: 0.242 ms
Execution time: 1.368 ms
(8 rows)

--Производится сканирование Seq Scan строк таблицы и сравнение Filter их с условием.
--Как только наберётся 10 записей, удовлетворяющих условию, сканирование закончится.
--В нашем случае для того, чтобы получить 10 строк результата пришлось прочитать не всю таблицу,
--а только 4451 записи, из них 4441 были отвергнуты (Rows Removed by Filter).
--То же происходит и при Index Scan.

json
--Полноценная поддержка json в PostgreSQL (версия 9.4) появилась для эффективной работы с изменяющимися данными и
--данными типа ключ-значение. С появлением стандарта json и его популярностью, стало понятно,
--что простая модель ключ-значение уже не удовлетворяет потребности пользователей и в 2013 г был начат проект
--по созданию полноценной поддержки документно-ориентированного хранилища в PostgreSQL,
--который привел к появлению нового типа данных jsonb с индексной поддержкой и производительностью не хуже.

--jsonb синтаксически не имеет отличий от json, но данные хранятся в развёрнутом бинарном формате,
-- что замедляет добавление новых данных, но обеспечивает высокую скорость их обработки.
--В общем случае, хранить JSON лучше в jsonb.
-- Для jsonb есть возможность создавать индексы (GIN, btree и hash).

ALTER TABLE students ADD COLUMN contacts jsonb;
--поле contacts появилось и оно у всех записей пока пустое
select * from students limit 10;

--изменим самую первую запись, добавим известные нам контактные данные
UPDATE students SET contacts =  ('{ "email": "example@mail.com",
                          "telephone": { "home": "5113360", "mobile": "890531" } }') WHERE id = 1;
--посмотрим, что изменилось
select * from students where id = 1;
--в результате, теперь мы можем знать о студенте намного больше, нам не нужно создавать для каждых:
-- 1) email
-- 2) address
-- 3) telephone
-- 3) 1) home
-- 3) 2) mobile
-- отдельные поля, если данные нам известны, мы их добавим к записи с нужным id, если нет, то пропустим


   id |   name   |   surname    | sex | group_id |  town  |        contacts
  ----+----------+--------------+-----+----------+--------+-------------------------------------------------------------------------------------
    1 | Гульнара | Нигматзянова | Ж   |        2 | Казань | {"email": "example@mail.com", "telephone":
    {"home": "5113360", "mobile": "890531"}}
  (1 row)

--например, если мы знаем все о студенте, то заполним все
UPDATE students SET contacts =  ('{ "email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147",
                          "telephone": { "home": "5113361", "mobile": "890531" } }') WHERE id = 2;

select * from students where id = 2;

id | name  | surname  | sex | group_id |  town  |            contacts
----+-------+----------+-----+----------+--------+----------------------------------------------------------------------------------------------------------------------------------------
 2 | Эмиль | Атажанов | М   |        1 | Астана | {"email": "example2@mail.com", "address": "г.Казань,
 ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}
(1 row)

--если знаем чуть больше, то нам не придется создавать новых полей в таблице, мы просто запишем то, что знаем
UPDATE students SET contacts =  ('{ "email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.52, кв.177",
                          "telephone": { "home": "5113362", "mobile": "890538" },"skype":"iluzka95" }') WHERE id = 3;

select * from students where id = 3;

id | name  | surname | sex | group_id | town |             contacts
----+-------+---------+-----+----------+------+-------------------------------------------------------------------------------------------------------------------------------------------------------------
 3 | Илюза | Сакаева | Ж   |        1 | Уфа  | {"email": "example2@mail.com", "skype": "iluzka95",
 "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}
(1 row)

--заполним контактные данные еще 5 студентов
UPDATE students SET contacts =  ('{ "email": "zahar@mail.com", "address": "г.Москва, ул. Подлужная д.2, кв.77",
                          "telephone": { "mobile": "890538333" },"skype":"zahar95" }') WHERE id = 4;
UPDATE students SET contacts =  ('{ "email": "alina@mail.com", "address": "г.Набережные Челны, ул. Роскольникова д.87, кв.3",
"telephone": { "home":"633245","mobile": "890538333" },"skype":"alinka995" }') WHERE id = 5;
UPDATE students SET contacts =  ('{ "email": "example3@mail.com", "address": "г.Москва, ул. Васкин д.29, кв.4",
                          "telephone": { "mobile": "890777333" }}') WHERE id = 6;
UPDATE students SET contacts =  ('{ "email": "example4@mail.com", "address": "г. Казань, ул. Гагарина д.89, кв.34",
"telephone": { "home":"63333333","mobile": "89012345" } }') WHERE id = 7;
UPDATE students SET contacts =  ('{ "email": "example5@mail.com",
                          "telephone": { "mobile": "8933333333" },"skype":"lalalala" }') WHERE id = 8;
UPDATE students SET contacts =  ('{ "address": "г.Набережные Челны, ул. Низамиева д.7, кв.54",
"telephone": { "home":"123456","mobile": "8977777777" },"skype":"myyyy995" }') WHERE id = 14;


--посмотрим на первые 9 записей из таблице студентов
select * from students order by id limit 10;


id |   name   |   surname    | sex | group_id |  town  |             contacts

----+----------+--------------+-----+----------+--------+-----------------------
--------------------------------------------------------------------------------
------------------------------------------------------------------
  1 | Гульнара | Нигматзянова | Ж   |        2 | Казань | {"email": "example@mail.com",
  "telephone": {"home": "5113360", "mobile": "890531"}}
  2 | Эмиль    | Атажанов     | М   |        1 | Астана | {"email": "example2@mail.com",
  "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}
  3 | Илюза    | Сакаева      | Ж   |        1 | Уфа    | {"email": "example2@mail.com",
  "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}
  4 | Захар    | Макаров      | М   |        2 | Москва | {"email": "zahar@mail.com",
  "skype": "zahar95", "address": "г.Москва, ул. Подлужная д.2, кв.77", "telephone": {"mobile": "890538333"}}
  5 | Алина    | Васильева    | Ж   |        5 | Казань | {"email": "alina@mail.com", "skype": "alinka995",
  "address": "г.Набережные Челны, ул. Роскольникова д.87, кв.3", "telephone": {"home": "633245", "mobile": "890538333"}}
  6 | Камиль   | Морковников  | М   |        1 | Рязань | {"email": "example3@mail.com",
  "address": "г.Москва, ул. Васкин д.29, кв.4", "telephone": {"mobile": "890777333"}}
  7 | Марина   | Петрушкина   | Ж   |        7 | Арск   | {"email": "example4@mail.com",
  "address": "г. Казань, ул. Гагарина д.89, кв.34", "telephone": {"home": "63333333", "mobile": "89012345"}}
  8 | Захар    | Огурцов      | М   |        2 | Москва | {"email": "example5@mail.com",
  "skype": "lalalala", "telephone": {"mobile": "8933333333"}}
  14 | hrbme | ocuhf   | М   |        5 | ocuhfu | {"skype": "myyyy995", "address":
  "г.Набережные Челны, ул. Низамиева д.7, кв.54", "telephone": {"home": "123456", "mobile": "8977777777"}}
  15 | gslbm    | erqcl        | М   |        2 | erqcll |
 (10 rows)

-- теперь добавим ПО ОШИБКЕ одинаковые контактные данные для двух раздных студентов
UPDATE students SET contacts =  ('{ "email": "example55@mail.com"}') WHERE id = 15;
UPDATE students SET contacts =  ('{ "email": "example55@mail.com"}') WHERE id = 16;

-- проверим идентичность двух JSON объектов
SELECT * FROM students WHERE contacts = '{"email":"example55@mail.com"}';

id | name  | surname | sex | group_id |  town  |            contacts
----+-------+---------+-----+----------+--------+---------------------------------
15 | gslbm | erqcl   | М   |        2 | erqcll | {"email": "example55@mail.com"}
16 | fhhou | tpidd   | М   |        8 | tpidds | {"email": "example55@mail.com"}
(2 rows)

-- теперь посмотрим на все объекты, начинающиеся с ключа email и значения example2@mail.com
SELECT * FROM students WHERE contacts @> '{"email":"example2@mail.com"}';

-- мы видим, что у двух поля contacts начинанается с ключа email и значения example2@mail.com
id | name  | surname  | sex | group_id |  town  |                                                                          contacts
----+-------+----------+-----+----------+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------
 2 | Эмиль | Атажанов | М   |        1 | Астана | {"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}
 3 | Илюза | Сакаева  | Ж   |        1 | Уфа    | {"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}
(2 rows)

SELECT * FROM students WHERE contacts <@ '{"email":"example2@mail.com"}';
--такой запрос покажет нам строки, которые начинаются с данного ключа и значения и заканчиваются ими же
id | name  | surname | sex | group_id |  town  |            contacts
----+-------+---------+-----+----------+--------+---------------------------------
15 | gslbm | erqcl   | М   |        2 | erqcll | {"email": "example55@mail.com"}
16 | fhhou | tpidd   | М   |        8 | tpidds | {"email": "example55@mail.com"}
(2 rows)

-- запросим всех студентов, имеющих email
SELECT * FROM students WHERE contacts ?| array['email'];
-- запрос, который понадобиться, если деканату нужно связаться со студентами по телефону
SELECT * FROM students WHERE contacts ?| array['telephone'];
-- запрос, который понадобиться, если деканату нужно отправить письмо по почте
SELECT * FROM students WHERE contacts ?| array['address'];
-- запросим всех студентов, имеющих skype-аккаунты
SELECT * FROM students WHERE contacts ?| array['skype'];
-- запросим всех студентов, имеющих или email или телефон для связи
SELECT * FROM students WHERE contacts ?| array['email, telephone'];

--запросим всех студентов, имеющих и email и телефон для связи и адрес и skype-аккаунт
SELECT * FROM students WHERE contacts ?& array['email','telephone','address','skype'];
--таких студентов только трое
id | name  |  surname  | sex | group_id |  town  |                                                                                contacts
----+-------+-----------+-----+----------+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 3 | Илюза | Сакаева   | Ж   |        1 | Уфа    | {"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}
 4 | Захар | Макаров   | М   |        2 | Москва | {"email": "zahar@mail.com", "skype": "zahar95", "address": "г.Москва, ул. Подлужная д.2, кв.77", "telephone": {"mobile": "890538333"}}
 5 | Алина | Васильева | Ж   |        5 | Казань | {"email": "alina@mail.com", "skype": "alinka995", "address": "г.Набережные Челны, ул. Роскольникова д.87, кв.3", "telephone": {"home": "633245", "mobile": "890538333"}}
(3 rows)

-- допустим нам понадобиться отправить данные первых трех студентов, чтобы корректно получить всю имеющуюся информацию
-- о них, можно представить всю строку в виде массива типа json, воспользовавщись функцией array_to_json:

SELECT
   array_to_json(array_agg(t)) AS students
FROM (
   SELECT name, surname, contacts FROM students ORDER BY id LIMIT 3) t;

students
-----------------------------------------------------------------------------------------------
[{"name":"Гульнара","surname":"Нигматзянова","contacts":{"email": "example@mail.com", "telephone":
{"home": "5113360", "mobile": "890531"}}},{"name":"Эмиль","surname":"Атажанов",
"contacts":{"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147",
"telephone": {"home": "5113361", "mobile": "890531"}}},{"name":"Илюза","surname":"Сакаева",
"contacts":{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177",
"telephone": {"home": "5113362", "mobile": "890538"}}}]
(1 row)

--если мы захотим увидеть тот же результат, но в три строки, где каждая соответвует записи в таблице
--понадобится row_to_json(​record [, pretty_bool])

SELECT
   row_to_json(t) AS students
FROM (
   SELECT name, surname, contacts FROM students ORDER BY id LIMIT 3) t;

   students
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
{"name":"Гульнара","surname":"Нигматзянова","contacts":{"email": "example@mail.com", "telephone": {"home": "5113360", "mobile": "890531"}}}
{"name":"Эмиль","surname":"Атажанов","contacts":{"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}}
{"name":"Илюза","surname":"Сакаева","contacts":{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}}
(3 rows)

--запросим контактные данные самого первого студента в виде таблицы ключ, значение
SELECT * FROM jsonb_each(( SELECT contacts FROM students WHERE id = 1));

key    |                  value
-----------+-----------------------------------------
email     | "example@mail.com"
telephone | {"home": "5113360", "mobile": "890531"}
(2 rows)
--данные вернулись в типе JSON

--запросим контактные данные самого первого студента, но в типе текст
SELECT * FROM jsonb_each_text(( SELECT contacts FROM students WHERE id = 1));

key    |                  value
-----------+-----------------------------------------
email     | example@mail.com
telephone | {"home": "5113360", "mobile": "890531"}
(2 rows)

--если нам нужен только email первого студента
SELECT * FROM jsonb_each(( SELECT contacts FROM students WHERE id = 1)) t WHERE key = 'email';

key  |       value
-------+--------------------
email | "example@mail.com"
(1 row)

--если нам понадобится показать каждый из контактных телефонов
SELECT * FROM jsonb_each((SELECT contacts->'telephone' FROM students WHERE id = 1));

  key   |   value
--------+-----------
 home   | "5113360"
 mobile | "890531"
(2 rows)

--если же нам все таки понабится таблица контактных данных
CREATE TABLE contacts (
  id SERIAL PRIMARY KEY,
  email VARCHAR(50),
  skype VARCHAR(50),
  telephone jsonb,
  address VARCHAR(50)
);
-- или воспользуемся jsonb_populate_record и покажем в виде записи таблицы contacts
SELECT * FROM jsonb_populate_record(null::contacts, (SELECT contacts FROM students WHERE id = 1)) AS popo;

id |      email       | skype |                telephone                | address
----+------------------+-------+-----------------------------------------+---------
   | example@mail.com |       | {"home": "5113360", "mobile": "890531"} |
(1 row)


CREATE TYPE acontacts AS (
email VARCHAR(50),
skype VARCHAR(50),
telephone jsonb,
address VARCHAR(50));

-- или воспользуемся jsonb_populate_record и покажем в виде записи типа acontacts
SELECT * FROM jsonb_populate_record(null::acontacts, (SELECT contacts FROM students WHERE id = 1)) AS popo;

email       | skype |                telephone                | address
------------------+-------+-----------------------------------------+---------
example@mail.com |       | {"home": "5113360", "mobile": "890531"} |
(1 row)

--при использовании массива, возвратит количество его элементов
SELECT jsonb_array_length(contacts) FROM students WHERE id = 1;

--XML

SELECT table_to_xml('students', true, false, '');

SELECT query_to_xml('SELECT * FROM students where id = 1 ', true, false, '');

query_to_xml
------------------------------------------------------------------------------------------------------------
<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">                                             +                                                                                                          +
<row>                                                                                                     +
  <id>1</id>                                                                                              +
  <name>Гульнара</name>                                                                                   +
  <surname>Нигматзянова</surname>                                                                         +
  <sex>Ж</sex>                                                                                            +
  <group_id>2</group_id>                                                                                  +
  <town>Казань</town>                                                                                     +
  <contacts>{"email": "example@mail.com", "telephone": {"home": "5113360", "mobile": "890531"}}</contacts>+
 </row>                                                                                                    +                                                                                                         +
 </table>                                                                                                  +
(1 row)
:


SELECT query_to_xml('SELECT * FROM students ORDER BY id LIMIT 5 ', true, false, '');


EXPLAIN SELECT
   row_to_json(t) AS students
FROM (
   SELECT name, surname, contacts FROM students WHERE id = 1) t;

   QUERY PLAN
----------------------------------------------------------------------------
Index Scan using student_id on students  (cost=0.29..8.31 rows=1 width=44)
Index Cond: (id = 1)
(2 rows)

EXPLAIN SELECT query_to_xml('SELECT * FROM students where id = 1 ', true, false, '');

QUERY PLAN
------------------------------------------
Result  (cost=0.00..0.26 rows=1 width=0)
(1 row)

--Функция xmlconcat объединяет несколько XML-значений и выдаёт в результате один фрагмент XML-контента.
--Значения NULL отбрасываются, так что результат будет равен NULL, только если все аргументы равны NULL.
SELECT xmlconcat('<id>1</id>','<name>Гульнара</name>','<surname>Нигматзянова</surname>',
'<sex>Ж</sex>','<group_id>2</group_id> ','<town>Казань</town>','<contacts> {"email": "example@mail.com",
"telephone": {"home": "5113360", "mobile": "890531"}}</contacts>');

xmlconcat
--------------------------------------------------------------------------------------------------------------------------------------------------------------
<id>1</id><name>Гульнара</name><surname>Нигматзянова</surname><sex>Ж</sex><group_id>2</group_id> <town>Казань</town><contacts> {"email": "example@mail.com",+
"telephone": {"home": "5113360", "mobile": "890531"}}</contacts>
(1 row

SELECT xmlelement(name students, xmlattributes(id, name, surname)) FROM students LIMIT 10;

xmlelement
--------------------------------------------------
<students id="17" name="ieubn" surname="kbqqh"/>
<students id="18" name="failo" surname="cujbu"/>
<students id="19" name="jlgcj" surname="pkfna"/>
<students id="20" name="ddmon" surname="coafr"/>
<students id="21" name="mbguu" surname="qbjig"/>
<students id="22" name="iccie" surname="acrep"/>
<students id="23" name="kmajp" surname="ttamr"/>
<students id="24" name="rurbq" surname="mjudj"/>
<students id="25" name="ightq" surname="ptbfl"/>
<students id="26" name="dmmpe" surname="ktopm"/>
(10 rows)
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------




	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON
	XMLJSONXMLJSONXMLJSONXMLJSON

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
CREATE DATABASE education_g;

CREATE TYPE GENDER AS ENUM ('М', 'Ж');

-- UNIQUE, CHECK, NOT NULL, ON [UPDATE/DELETE] [CASCADE, RESTRICT]

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	gender GENDER NOT NULL, --пол
	group_id INTEGER NOT NULL,
	location VARCHAR(50) NOT NULL DEFAULT 'Казань', --населенный пункт проживания
	CHECK (group_id >= 1)
);

INSERT INTO students VALUES ('1','Гульнара', 'Нигматзянова', 'Ж', '2', DEFAULT);
INSERT INTO students (name, surname, gender, group_id, location) VALUES ('Эмиль', 'Атажанов', 'М', '2', 'Астана'), ('Илюза', 'Сакаева', 'Ж', '1', 'Уфа');

CREATE TABLE groups (
	id SERIAL PRIMARY KEY,
	group_no VARCHAR(10) NOT NULL, --номер группы
	student_quantity INTEGER NOT NULL, --количество студентов
	faculty VARCHAR(50) NOT NULL, --факультет
	steward INTEGER NOT NULL,
	FOREIGN KEY (steward) REFERENCES students(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO groups VALUES ('1', '1', 10, 'ИВМиИТ', 3);
INSERT INTO groups VALUES ('2', '2', 10, 'ИВМиИТ', 1);
ALTER TABLE students ADD CONSTRAINT stud_group FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE;

SELECT g.group_no, g.student_quantity, g.faculty, s.name, s.surname FROM students s INNER JOIN groups g ON (s.id = g.steward);

CREATE VIEW Stewards AS SELECT g.group_no, g.student_quantity, g.faculty, s.name, s.surname FROM students s INNER JOIN groups g ON (s.id = g.steward);
SELECT * FROM Stewards;

CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	surname VARCHAR(50) NOT NULL,
	faculty VARCHAR(50) NOT NULL, --факультет
	classes INTEGER NOT NULL REFERENCES classes(id), --че?
	department VARCHAR(50) NOT NULL --кафедра	
);

CREATE TYPE REPORT_TYPE AS ENUM ('Зачет', 'Экзамен', 'Курсовая');
CREATE TYPE SUBJECT_TYPE AS ENUM ('Лекция', 'Практика');

CREATE TABLE subjects (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	report_type REPORT_TYPE NOT NULL,
	subject_type SUBJECT_TYPE NOT NULL,
	hours INTEGER NOT NULL
);

CREATE TABLE classes (
	id SERIAL PRIMARY KEY,
	teacher_id INTEGER NOT NULL UNIQUE REFERENCES teachers(id),
	group_id INTEGER NOT NULL,
	subject_id INTEGER NOT NULLUNIQUE ,
	semester INTEGER NOT NULL,
	audience VARCHAR(10) NOT NULL,
	start_time VARCHAR(5) NOT NULL,
	FOREIGN KEY (group_id) REFERENCES groups(id),
	FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

/*
Таблица 5_1. СТУДЕHТЫ (объединенные в гpуппы)
* Код студента
* Фамилия студента
* Пол
* Код группы
* Населенный пункт проживания

Таблица 5_2. ПРЕПОДАВАТЕЛИ
* Код преподавателя
* Фамилия преподавателя
* Факультет
* Общая реальная нагрузка преподавателя(связать с таблицей занятия )
* Кафедра

Таблица 5_3. ПРЕДМЕТЫ
* Код предмета
* Наименование предмета
* Вид отчетности (зачет, экзамен, курсовая)
лекция или практика
* Количество часов

Таблица 5_4. ЗАHЯТИЯ (КТО, ЧТО, КОМУ - гpуппе, КОГДА, ГДЕ)
* Код преподавателя
* Код группы
* Код предмета
* Семестр
* Аудитория
* Время

ФАЙЛ5_5. ГРУППЫ
* Код группы
* Номер группы
* Число студентов в группе
* Факультет
* Староста
*/

+DROP DATABASE tim; --удалим бд, если бд с таким названием уже имеется
CREATE DATABASE tim;--создадим нашу бд

CREATE TYPE PERSONS_TYPE AS ENUM ('Профессор', 'Студент');
--Перечисления (enum) — это такие типы данных, которые состоят из статических, упорядоченных списков значений.

CREATE TABLE persons (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
surname VARCHAR(50) NOT NULL,
persons_type PERSONS_TYPE NOT NULL
);

INSERT INTO persons (name, surname,persons_type) VALUES ('Гульнара', 'Нигматзянова','Студент'), ('Эмиль', 'Атажанов','Студент'),
 ('Илюза', 'Сакаева','Студент'), ('Захар','Макаров','Студент'),('Алина', 'Васильева','Студент'),('Камиль', 'Морковников','Студент'),
 ('Марина', 'Петрушкина','Студент'),('Захар','Огурцов','Студент'),('Лариса', 'Блинчикова','Студент'),('Екатерина','Федулова','Студент'),
 ('Анвар','Туйкин', 'Профессор'),('Наиль','Бухараев', 'Профессор'),('Элина','Степанова', 'Профессор'),
 ('Арслан','Еникеев', 'Профессор'),('Александр','Гусенков', 'Профессор'),
 ('Виктор','Георгиев', 'Профессор'),('Михаиль','Щелкунов', 'Профессор'),
 ('Евгения','Михайловна', 'Профессор'),('Алия','Барисовна', 'Профессор'),
 ('Динара','Торфянова','Студент'),('Кристина','Аркадъевна','Студент'),('Вася','Пупкин','Студент'),
 ('Михаиль','Мочалкин','Студент'),('Иван','Иванов','Студент'),('Мария','Владимировна', 'Профессор'),('Критерий','Пирсона', 'Профессор'),
 ('Сергей','Мокичев', 'Профессор'),('Фаниль','Серебряков', 'Профессор'), ('Виолетта','Чебакова', 'Профессор'),
  ('Екатерина','Турилова', 'Профессор'),('Самигулла','Халиуллин', 'Профессор');

CREATE TYPE GENDER AS ENUM ('М', 'Ж');-- создадим тип для поля пол

CREATE TABLE students ( 
	id SERIAL PRIMARY KEY,
	id_person INTEGER UNIQUE,
	sex GENDER NOT NULL,
	group_id INTEGER NOT NULL,
	town VARCHAR(50) NOT NULL DEFAULT 'Казань',
	CHECK (group_id >= 1),
	FOREIGN KEY (id_person) REFERENCES persons(id) ON DELETE SET NULL
);

DELETE FROM students; --удалим якобы имеющиеся данные в таблице студенты
 
--посмотрим список всех девушек студенток
 SELECT *
 FROM persons
 WHERE persons_type = 'Студент' AND surname LIKE '%а';

--добавим данные
INSERT INTO students (id_person,group_id,sex, town) VALUES (1,1,'Ж',DEFAULT),
(3,4,'Ж','Рязань'),(5,3,'Ж','Москва'),(7,2,'Ж','Крым'),
(9,5,'Ж',DEFAULT),(10,1,'Ж','Тверь'),(20,1,'Ж','Уфа'),(21,1,'Ж','Алексеевск');
 
--запросим всех парней студентов
  SELECT *
 FROM persons
 WHERE persons_type = 'Студент' AND surname NOT LIKE '%а';

--добавим данные
INSERT INTO students (id_person,group_id,sex,  town) VALUES (2,5,'М','Москва'),
(4,5,'М',DEFAULT),(6,7,'М',DEFAULT),(8,1,'М','Агрыз'),(22,2,'М','Норильск'),(23,2,'М','Стерлитамак'),(24,1,'М','Киев');

--Индексы — один из самых мощных инструментов в реляционных базах данных, который используют,
-- когда нужно быстро найти какие-то значения, для объединения базы данных, ускорение работы SQL-операторов и т.д.
CREATE INDEX id_person ON persons(id);
CREATE INDEX id_student ON students (id);

/*
В каком порядке должны быть указаны данные при использовании команды insert?
-Список столбцов в данной команде не является обязательным параметром.
В этом случае должны быть указаны значения для всех полей таблицы в том порядке,
 как эти столбцы были перечислены в команде CREATE TABLE, например:
 INSERT INTO students VALUES (1,'Гульнара', 'Нигматзянова', 'Ж', '2', DEFAULT);
Что будет, если попытаться вставить запись, которая нарушает ограничение уникальности?
-Если пользователь пытается сохранить в какой-либо колонке данные, которые попадают под ограничение, возникнет ошибка. 
Что будет, если попытаться удалить из таблицы несуществующие значения?
-Запрос будет успешно выполнен, например:DELETE FROM students WHERE town ILIKE 'Махачкала';
*/

--посмотрим на нашу таблицу
SELECT *
FROM students;

UPDATE students 
set town = 'Махачкала'
 WHERE id_student = 1; 

UPDATE students 
set town = DEFAULT
 WHERE id_student = 1; 

/*
Что если в команде UPDATE не указать WHERE?
-Изменятся все данные.
*/

--выведим только id тех, кто из Москвы
SELECT id_student
FROM students
WHERE town ILIKE 'Москва';

SELECT id_student
FROM students
WHERE town LIKE 'москва'; --(ничего не выдаст из-за реестра)

--посмотрим на пересечние всех строк из таблицы persons и students, где id совпадают
SELECT s.*, p.*
FROM students s, persons p 
WHERE p.id = s.id_person ;

CREATE SEQUENCE serial;--создадим последовательность

CREATE TABLE example ( --создадим таблицу для примера использования созданной нами последовательности
	id INTEGER DEFAULT nextval('serial')
);

ALTER TABLE example ADD COLUMN name VARCHAR;--добавим столбец в таблицу
ALTER TABLE example ADD CONSTRAIN colName UNIQUE (name);--добавим ему именнованое ограничение - уникальность
ALTER TABLE example ALTER COLUMN colName SET NOT NULL;--добавим ограничение NOT NULL
ALTER TABLE example ALTER COLUMN colName SET DEFAULT 'Наименование'; --добавим ограничение  DEFAULT
ALTER TABLE example RENAME COLUMN name TO NewName,  RENAME TO newExample;--переименуем столбец и саму таблицу
ALTER TABLE newExample ALTER COLUMN colName DROP DEFAULT;-- уберем ограничение DEFAULT
ALTER TABLE newExample ALTER COLUMN colName DROP NOT NULL;--уберем ограничение NOT NULL
ALTER TABLE newExample DROP CONSTRAIN colName;--уберем ограничение уникальности
ALTER TABLE newExample DROP COLUMN NewName;--удалим столбец

DROP SEQUENCE serial;
--если мы попытаемся удалить последовательность, которая уже используется, у нас это не получится. Поэтому
--удалим сеначала таблицу,а затем уже последовательность.
DROP TABLE example;
DROP SEQUENCE serial;

--вернемся к select
--запросим данные студентов, остортированные по убыванию кода группы
SELECT s.id,s.group_id, p.name, p.surname
    FROM students s, persons p
    WHERE s.id_person = p.id
    ORDER BY group_id DESC;

--запросим данные  всех студентов, осортированные по возрастанию. Причем, результат нашей выборки будет
--ограничен нам покажут только 3 записи, смещенные на 2 записи от начала.
SELECT s.id,s.group_id, p.name, p.surname
 FROM students s, persons p
ORDER BY p.surname
LIMIT 3 OFFSET 2;

--создадим функцию, результатом которой будет записи тех студентов, код которых больше 12.
CREATE FUNCTION one()
 RETURNS SETOF record AS '
select *
  from students
  where id>12;
'
LANGUAGE sql;

--посмотрим на результат функции
SELECT  one() AS result;

--создадим таблицу группы
CREATE TABLE groups (
	id SERIAL PRIMARY KEY,
	group_number VARCHAR(10) NOT NULL, --номер/наименование группы
	student_count INTEGER NOT NULL, --число студентов в группе
	faculty VARCHAR(50) NOT NULL, --факультет
	steward INTEGER , --староста (внешний ключ)
	FOREIGN KEY (steward) REFERENCES students(id)  ON DELETE SET NULL 
	
);

// DROP TABLE IF EXISTS groups CASCADE; --если мы на данном этапе удалим таблицу,
-- придется воспользоваться каскадным удалением

INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 6),
 ( '09-400', 28, 'ИВМиИТ', 10), ( '09-307', 30, 'ИВМиИТ', 9), ('09-306', 10, 'ИТИС', 6), ( '09-411', 7, 'ИВМиИТ',2),
( '09-508', 12, 'ИВМиИТ', 3),('09-206', 21, 'ИВМиИТ', 1), ('09-211', 25, 'ИТИС', 4), ('09-221', 25, 'ИТИС', 5);
INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 6),
 ( '09-400', 28, 'ИВМиИТ', 10), ( '09-307', 30, 'ИВМиИТ', 9), ('09-306', 10, 'ИТИС', 6), ( '09-411', 7, 'ИВМиИТ',2),
( '09-508', 12, 'ИВМиИТ', 3),('09-206', 21, 'ИВМиИТ', 1), ('09-211', 25, 'ИТИС', 4), ('09-221', 25, 'ИТИС', 5);
/* мы добавили в нашу таблицу данные, затем повторили. Теперь в нашей таблице дублированные данные.
запросим номер группы и id старосты всех, уникальных по номеру группы, данных.*/
SELECT DISTINCT ON (group_number)
 group_number, steward
FROM groups ; 

--посмотрим на все дублирующиеся данные
SELECT g.*
FROM groups g
INNER JOIN 
(
SELECT group_number, COUNT(*) AS cnt
FROM groups
GROUP BY group_number
HAVING COUNT(*) >1
)b ON (b.group_number= g.group_number);

/*Как справиться с дублирующимися данными???
Сначала я попыталась сделать запрос для удаления их, не смотря на то, что запрос был успешно выполнен содержание
таблицы никак не изменилось :( */

delete
 from groups
 where (group_number,student_count, faculty, steward) 
 not in (SELECT DISTINCT ON (group_number)
 group_number,student_count, faculty, steward
FROM groups);

 --Тогда я воспользовалась этим запросом:

DELETE FROM groups T1 WHERE EXISTS 
  (SELECT * FROM groups T2 WHERE 
     (T2.group_number = T1.group_number or (T2.group_number is null and T2.group_number is null)) AND 
     (T2.student_count = T1.student_count or (T2.student_count is null and T2.student_count is null)) AND 
     (T2.faculty = T1.faculty or (T2.faculty is null and T2.faculty is null)) AND 
     (T2.steward = T1.steward or (T2.steward is null and T2.steward is null)) AND 
     (T2.id > T1.id));

/*Больше дублирующихся данных в таблице нет.
И, чтобы они не повторялись, добавим ограничение на уникальность номера группы.*/
ALTER TABLE groups ADD CONSTRAINT group_number_un UNIQUE (group_number);

 --Попытаемся снова добавить дубликат:
 INSERT INTO groups (group_number,student_count, faculty, steward) VALUES ( '09-308', 26, 'ИВМиИТ', 3),
 ( '09-400', 28, 'ИВМиИТ', 1), ( '09-307', 30, 'ИВ('09-221', 25, 'ИТИС', 24);МиИТ', 8), ('09-306', 10, 'ИТИС', 4), ( '09-411', 17, 'ИВМиИТ', 7),
( '09-508', 12, 'ИВМиИТ', 2),('09-206', 21, 'ИВМиИТ', 2), ('09-211', 25, 'ИТИС', 6),('09-302', 24, 'ИВМиИТ', 21);
--У нас это не получится, тк повторяющееся значение ключа нарушает ограничение уникальности "group_number_un".

--добавим связь. Теперь удаление или изменение родительского ключа распространается на зависящий от него ключ
ALTER TABLE students ADD 
CONSTRAINT stud_group 
FOREIGN KEY (group_id) REFERENCES groups(id)
 ON UPDATE CASCADE ON DELETE SET NULL;
 --но данные в таблице студентов нарушают целостность, поэтому увеличим все коды групп в таблице студентов 

UPDATE  students SET group_id = group_id + 20 ;

--попробуем еще раз и все работает.
ALTER TABLE students ADD 
CONSTRAINT stud_group 
FOREIGN KEY (group_id) REFERENCES groups(id)
 ON UPDATE CASCADE ON DELETE SET NULL;

--посмотрим номер группы, число студентов, факультет и код старосты этой группы.
SELECT g.group_number, g.student_count, g.faculty, s.id
FROM students s INNER JOIN groups g ON (s.id = g.steward);

--чтобы не писать постоянно запрос, создадим представление.
CREATE VIEW Stewards_id AS SELECT g.group_number, g.student_count, 
g.faculty, s.id
FROM students s INNER JOIN groups g ON (s.id = g.steward);

--наше представление совпадает с запросом, написанным ранее.
SELECT * FROM Stewards_id;

--также нам понадобиться представление, с помощью которого мы сможем узнать не только код,но и имя, фамилию старосты.

CREATE VIEW Stewards AS SELECT s_id.group_number, s_id.student_count, 
s_id.faculty, p.name, p.surname 
FROM persons p INNER JOIN Stewards_id s_id ON (s_id.id = p.id);

SELECT *
FROM Stewards
ORDER BY surname;
--теперь мы сможем узнать имена и фамилии старосты конткретной группы одной  простой командой
SELECT *
FROM Stewards
WHERE group_number = '09-308';

--функция, результатом которой будет количество записей в бд о студентах из группы, id которой равно 23
CREATE FUNCTION students_count() RETURNS integer AS '
DECLARE
i integer;

BEGIN
select count(*) from students into i where students.group_id=23;

return i;
END;
' LANGUAGE plpgsql;

SELECT  students_count() AS i;

--запросим минимальное количество студентов среди всех групп.
  SELECT MIN(g.student_count) FROM groups g;

//создадим таблицу профессоров
CREATE TABLE professors (
	id SERIAL PRIMARY KEY,
	id_person INTEGER UNIQUE,
	faculty VARCHAR(50) NOT NULL, 
	classes INTEGER NOT NULL, --REFERENCES classes(id), 
	department VARCHAR(50) NOT NULL 	
);

--запросим всех профессоров из таблицы persons
SELECT *
FROM persons
WHERE persons_type = 'Профессор';

INSERT INTO professors (id_person,faculty,classes,department) VALUES (11,'ИВМиИТ',0,'КТП'),(12,'ИВМиИТ',0,'КТП'),
(13,'ИВМиИТ',0,'КТП'),(14,'ИВМиИТ',0,'КТП'),(15,'ИВМиИТ',0,'КТП'),(16,'ИВМиИТ',0,'КТП'),(17,'ИТИС',0,'КТТ'),
(18,'ИТИС',0,'КТТ'),(19,'ИТИС',0,'КТТ'),(25,'ИТИС',0,'КТТ'),(26,'ИВМиИТ',0,'КМС'),(29,'ИВМиИТ',0,'КМС'),
(30,'ИВМиИТ',0,'КМС'),(31,'ИВМиИТ',0,'КМС'),(27,'ИСФНиМК',0,'КОФ'),(28,'ИУЭиФ',0,'КЭТ');

//Запросим всех профессоров из кафедры Технологии программирования
SELECT *
FROM professors
WHERE department ILIKE 'КТП';

--к сожалению, мы можем увидеть только код того или иного преподавателя. Воспользуемся представлением для более подробной информации

CREATE VIEW professors_ns 
AS SELECT p.name,p.surname,pr.faculty, pr.classes,pr.department
FROM persons p INNER JOIN professors pr
ON (pr.id_person = p.id);

--теперь мы можем увидеть не только код преподавателей, но и имя и фамилию) остортированные по возрастанию
SELECT *
FROM professors_ns
WHERE department ILIKE 'КТП'
ORDER BY surname ;

SELECT * 
FROM professors_ns;  

--функция, которая возвращает количество записей по конкретному значению кафедры
CREATE FUNCTION prof_count(str VARCHAR) RETURNS integer AS '
DECLARE
i integer;

BEGIN

select count(*)
from professors p into i 
where p.department= str;

return i;
END;
' LANGUAGE plpgsql;

--запросим все имеющиеся кафедры и количество профессоров, работающих в них
SELECT DISTINCT  department, prof_count(department) AS i
FROM professors;

CREATE TYPE REPORT_TYPE AS ENUM ('Зачет', 'Экзамен', 'Курсовая');
CREATE TYPE SUBJECT_TYPE AS ENUM ('Лекция', 'Практика');

CREATE TABLE subjects (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	report_type REPORT_TYPE NOT NULL,
	subject_type SUBJECT_TYPE NOT NULL,
	hours INTEGER NOT NULL
);

INSERT INTO subjects (name, report_type, subject_type, hours) VALUES ('Базы Данных', 'Зачет', 'Лекция', 18), ('Базы Данных', 'Зачет', 'Практика', 18);
INSERT INTO subjects (name, report_type, subject_type, hours) VALUES ('ПАПС', 'Зачет', 'Лекция', 18), ('ПАПС', 'Зачет', 'Практика', 36), ('ТПО', 'Зачет', 'Лекция', 18),
 ('ТПО', 'Зачет', 'Практика', 36), ('ОИБ', 'Экзамен', 'Лекция', 36), ('ОКГ', 'Зачет', 'Практика', 18), ('ОКГ', 'Зачет', 'Практика', 36), ('Физ-ра', 'Зачет', 'Практика', 66);

 //запросим все лекционные предметы по возрастанию количества часов

SELECT *
FROM 
(SELECT DISTINCT ON (s.name) *
FROM subjects s
WHERE s.subject_type = 'Лекция'
ORDER BY s.name DESC) ss
ORDER BY ss.hours DESC;

CREATE TABLE classes (
	id SERIAL PRIMARY KEY,
	professors_id INTEGER NOT NULL ,
	group_id INTEGER NOT NULL,
	subject_id INTEGER NOT NULL ,
	semester INTEGER NOT NULL,
	audience VARCHAR(10) NOT NULL,
	start_time VARCHAR(5) NOT NULL,
	FOREIGN KEY (professors_id)  REFERENCES professors(id),
	FOREIGN KEY (group_id) REFERENCES groups(id),
	FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

--напишем функцию, которая будет вычислять количество записей для определенного преподавателя
CREATE OR REPLACE FUNCTION add_to_prof()
RETURNS TRIGGER AS $$
DECLARE 
id1 integer;
iid integer;
count integer;
newcount integer;
count2 integer;
newcount2 integer;
BEGIN 
IF TG_OP = 'INSERT' THEN 
id1 := NEW.professors_id;
SELECT classes FROM professors p INTO count WHERE p.id = id1;  --count := (SELECT classes FROM professors p WHERE p.id = id);
newcount := count + 1;
UPDATE professors p SET classes = newcount WHERE p.id = id1;
RETURN NEW;
ELSIF TG_OP = 'UPDATE'
THEN
id1 = OLD.professors_id;
iid = NEW.professors_id;
IF id1 <> iid THEN
count = (SELECT classes FROM professors p WHERE p.id = id1);
newcount = count - 1;
count2 = (SELECT classes FROM professors p WHERE p.id = iid);
newcount2 = count2 + 1;
UPDATE professors p SET classes = newcount WHERE p.id = id1;
UPDATE professors p SET classes = newcount2 WHERE p.id = iid;
END IF;
RETURN NEW;
ELSEIF TG_OP='DELETE' THEN
id1 = OLD.professors_id;
count = (SELECT classes FROM professors p WHERE p.id = id1);
newcount = count - 1;
UPDATE professors p  SET classes = newcount WHERE p.id = id1;
RETURN OLD;
END IF;
END;
 $$ LANGUAGE plpgsql;

 --она понадобится нам для триггера
 CREATE TRIGGER t_classes
AFTER INSERT OR UPDATE OR DELETE ON classes FOR EACH ROW EXECUTE PROCEDURE add_to_prof();

/* теперь каждый раз, когда в таблицу занятий будут добавлять/изменять/удалять запись
наш триггер будет вызывать функцию, которая при каждом определенном дейтствии будет изменять
запись преподавателя в таблице профессоров.
Для примера посмотрим таблицу профессоров сейчас, у всех в поле нагрузка стоит 0 */

SELECT *
FROM professors_ns;

--добавим данные для таблицы занятия
INSERT INTO classes (professors_id, group_id, subject_id, semester, audience, start_time)
 VALUES (5, 23, 1, 5, '1111', '17:00');

--cнова взглянем на таблицу профессоров. Она изменилась, теперь поле нагузка стало вычислимым)
SELECT *
FROM professors_ns;

INSERT INTO classes (professors_id, group_id, subject_id, semester, audience, start_time)
 VALUES (1, 19, 2, 5, '910', '15:20'), (6, 19, 3, 5, '905', '18:40'), (6, 19, 3, 5, '1111', '13:35'),
  (4, 19, 5, 5, '1008', '10:10'),(4, 19, 6, 5, '909', '08:30'), (3, 19, 8, 4, '905', '10:10'), 
  (3, 19, 9, 5, '910', '10:10'), (14, 19, 7, 5, '1008', '13:35');

CREATE VIEW Prof_clas AS SELECT p.surname, p.name,p.id, c.subject_id, c.group_id,c.audience, c.start_time 
FROM classes c INNER JOIN professors_ns p
 ON (p.id = c.professors_id);

CREATE VIEW Prof_clas AS SELECT p.id, p.name, p.surname, 
c.id_subject, c.semestr, s.audiense, c.start_time
FROM classes c INNER JOIN (SELECT pr.id, ps.name, ps.surname
FROM persons ps, professors pr
WHERE ps.id = pr.id_person) p
 ON (p.id = c.professors_id);

--таблица код профессора, имя и фамилия.
SELECT pr.id, ps.name, ps.surname
FROM persons ps, professors pr
WHERE ps.id = pr.id_person;

--таблица код занятия, код предмета, наименование предмета, леция/практика, 
--код профессора, который ведет занятие, семестр, аудитория, время начала занятия.
SELECT c.id AS classes_id, sub.id AS subject_id, name AS subject_name,
subject_type, c.professors_id, c.semester, c.audience, c.start_time
FROM classes c, subjects sub
WHERE c.subject_id = sub.id;

--представление, с помощью которого можно узнать подробные данные о преподавателе и о занятии, которое он ведет
CREATE VIEW Prof_clas AS SELECT p.id, p.name, p.surname, c.group_id
, c.subject_name, c.subject_type, c.semester, c.audience, c.start_time
FROM (SELECT c.id AS classes_id, sub.id AS subject_id, c.group_id, name AS subject_name,
subject_type, c.professors_id, c.semester, c.audience, c.start_time
FROM classes c, subjects sub
WHERE c.subject_id = sub.id) c INNER JOIN (SELECT pr.id, ps.name, ps.surname
FROM persons ps, professors pr
WHERE ps.id = pr.id_person) p
 ON (p.id = c.professors_id);

Select *
From Prof_clas
WHERE semester = 5 AND group_id = 19
ORDER BY start_time;

--представление, с помощью которого можно узнать подробные данные о преподавателе и о занятии, которое он ведет и о группе
CREATE VIEW Prof_clas_group AS SELECT  p.name, p.surname, g.group_number, 
p.subject_name, p.subject_type, p.semester, p.audience, p.start_time
FROM Prof_clas p INNER JOIN groups g
ON (p.group_id = g.id);

 Вывести список студенток, прослушавших определенный курс(Базы Данных) в 5 семестре 
•	фамилия студента
•	код группы
•	наименование предмета
•	количество часов
•	вид (лекция\практика)

-- имя и фамилия студентки, код группы, в которой она учится
SELECT ps.surname, ps.name, s.id, s.group_id
FROM persons ps INNER JOIN students s
ON (ps.id = s.id_person)
WHERE s.sex = 'Ж';

--имя и фамилия студентки, код группы, код предмета, семестр
SELECT st.name, st.surname, c.group_id, c.subject_id, c.semester
FROM classes c INNER JOIN (SELECT ps.surname, ps.name, s.id, s.group_id
FROM persons ps INNER JOIN students s
ON (ps.id = s.id_person)
WHERE s.sex = 'Ж') st
ON c.group_id = st.group_id
WHERE c.semester = 5;

--окончательная таблица
SELECT  st.name, st.surname, st.group_id,
 sub.name, sub.hours, sub.subject_type,  st.semester
FROM subjects sub INNER JOIN
(SELECT st.name, st.surname, c.group_id, c.subject_id, c.semester
FROM classes c INNER JOIN (SELECT ps.surname, ps.name, s.id, s.group_id
FROM persons ps INNER JOIN students s
ON (ps.id = s.id_person)
WHERE s.sex = 'Ж') st
ON c.group_id = st.group_id
WHERE c.semester = 5) st
ON sub.id = st.subject_id
WHERE sub.name ILIKE 'Базы Данных';

/*Найти и вывести список студентов, прослушавших все курсы, которые читаются  некоторым преподавателем
1)Узнать, какие курсы вел конкретный преподаватель
2)Узнать, какие группы были на каждом из этих курсов
3)Список студентов, состоящих в каждой группе
*/

CREATE OR REPLACE FUNCTION two (idd integer)
  RETURNS TABLE(name VARCHAR, surname VARCHAR ) AS 
$BODY$ 
 DECLARE
 rec RECORD;
 i integer;
BEGIN
i := (SELECT  group_id
FROM prof_clas p_c
WHERE p_c.id= idd);

FOR rec IN EXECUTE 'SELECT p.name, p.surname
FROM persons p INNER JOIN (SELECT id_person
FROM students 
WHERE group_id = i) pp
ON (p.id = pp.id_person)'
	LOOP
		name = rec.name;
		surname =rec.surname;
		
		RETURN next;
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION two(idd integer) OWNER TO postgres;

SELECT *
FROM two(5) ;

DROP FUNCTION two (idd integer);
