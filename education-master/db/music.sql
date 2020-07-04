$ sudo -u postgres dropdb database
$ sudo -i -u postgres -- -i=--login -u=--user
$ createdb manufacture
$ dropdb manufacture
$ psql music
$ psql -l --показ всех баз

\l - список баз данных.
\dt - список всех таблиц.
\d table - структура таблицы table.
\du - список всех пользователей и их привилегий.
\dt+ - список всех таблиц с описанием.
\dt *s* - список всех таблиц, содержащих s в имени.
\i FILE - выполнить команды из файла FILE.
\o FILE - сохранить результат запроса в файл FILE.
\a - переключение между режимами вывода: с/без выравнивания.

CREATE TABLE Genres (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL
);

CREATE INDEX Genres_id ON Genres(id);

DELETE FROM Genres;
INSERT INTO Genres (name) Values ('Rap & Hip-Hop'), ('Pop'), ('Classical'), ('New Age'), ('Rock');

SELECT * FROM Genres
	ORDER BY id ASC;

UPDATE Genres 
	SET name = 'Hip-Hop'
	WHERE id = 1;

SELECT * FROM Genres
	ORDER BY id ASC;

SELECT name
	FROM Genres
	WHERE name LIKE 'Hip-Hop';

CREATE TABLE Countries (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL 
);

INSERT INTO Countries (name) Values ('United States'), ('Russia'), ('Great Britain'), ('Australia');

SELECT * FROM Countries;

CREATE TYPE GENDER AS ENUM ('М', 'Ж');

CREATE TABLE Persons (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	birthday DATETIME NOT NULL,
	gender GENDER NOT NULL
);

CREATE INDEX Person_id ON Persons(id);

INSERT INTO Persons (first_name, last_name, birthday, gender) 
VALUES ('Drake', 'Graham', '10-24-1986', 'М'), ('Вася', 'Вакуленко', ' 04-20-1980 ', 'М'), 
('John', 'Lennon', '10-9-1940', 'М'), ('Ella', 'Lani', '7-11-1996', 'Ж');

CREATE TABLE Artists ( 
	id SERIAL PRIMARY KEY,
	pseudonym VARCHAR UNIQUE,
	person_id INTEGER NOT NULL,
	country_id INTEGER NOT NULL,
	FOREIGN KEY (person_id) REFERENCES Persons(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (country_id) REFERENCES Countries(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO Artists (pseudonym, person_id, country_id) VALUES ('Drake', 1, 1), ('Баста', 2, 2), 
('John Lennon', 3, 3), ('Lorde', 4, 4), ('Ноггано', 2, 2);

CREATE TABLE Groups (
	id SERIAL PRIMARY KEY,
	group_name VARCHAR
);

INSERT INTO Groups (group_name) VALUES ('The Beatles');

CREATE TABLE Artists_to_groups (
	group_id INTEGER NOT NULL,
	artist_id INTEGER NOT NULL,
	FOREIGN KEY (group_id) REFERENCES Groups(id) ON UPDATE CASCADE ON DELETE CASCADE, 
	FOREIGN KEY (artist_id) REFERENCES Artists(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Artists_to_groups VALUES (1, 1), (1, 2);

CREATE VIEW Groups_artists AS 
	SELECT a.pseudonym, g.group_name 
	FROM Artists_to_groups ag
	INNER JOIN Artists a ON (a.id = ag.artist_id)
	INNER JOIN Groups g ON (g.id = ag.group_id)

SELECT a.pseudonym, g.group_name 
	FROM Artists_to_groups ag
	INNER JOIN Artists a ON (a.id = ag.artist_id)
	INNER JOIN Groups g ON (g.id = ag.group_id);
	WHERE g.group_name LIKE 'Drake';

SELECT * FROM Groups_artists;

CREATE TABLE Albums (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER,
	group_id INTEGER,
	genre_id INTEGER NOT NULL,
	title VARCHAR NOT NULL,
	year DATE NOT NULL,
	number_tracks INTEGER DEFAULT 0,
	FOREIGN KEY (artist_id) REFERENCES Artists(id),
	FOREIGN KEY (group_id) REFERENCES Groups(id),
	FOREIGN KEY (genre_id) REFERENCES Genres(id),
	CHECK (number_tracks >= 0),
	CHECK ((artist_id IS NOT NULL AND group_id IS NULL) OR (artist_id IS NULL AND group_id IS NOT NULL))
);

INSERT INTO Albums (artist_id, group_id, genre_id, title, year, number_tracks) 
VALUES 
	(1, NULL, 1, 'If You’re Reading This It’s Too Late', '2-13-2015', DEFAULT), 
	(2, NULL, 1, 'Баста 4', '5-14-2013', 17), 
	(NULL, 1, 5, 'Imagine', '9-9-1971', 10), 
	(4, NULL, 2, 'Pure Heroine', '9-27-2013', 15);

INSERT INTO Albums (artist_id, group_id, genre_id, title, year, number_tracks) 
VALUES (1, 1, 1, 'If You’re Reading This It’s Too Late', '2-13-2015', DEFAULT);

CREATE TABLE Songs (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER,
	group_id INTEGER,
	album_id INTEGER, 
	genre_id INTEGER,
	title VARCHAR NOT NULL,
	duration INTEGER NOT NULL,  --в секундах 
	track_no SMALLINT, 
	FOREIGN KEY (artist_id) REFERENCES Artists(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (group_id) REFERENCES Groups(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (album_id) REFERENCES Albums(id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (genre_id) REFERENCES Genres(id) ON UPDATE CASCADE ON DELETE SET NULL,
	CHECK ((artist_id IS NOT NULL AND group_id IS NULL) OR (artist_id IS NULL AND group_id IS NOT NULL))
);

INSERT INTO Songs (artist_id, group_id, album_id, genre_id, title, duration, track_no) VALUES 
(4, NULL, 4, 2, 'Royals', 188, 3);
INSERT INTO Songs (artist_id, album_id, genre_id, title, duration, track_no) VALUES (1, 1, 1, 'Over', 188, 3);

CREATE VIEW Artists_persons AS
	SELECT c.name AS country, p.first_name, p.last_name, p.birthday, p.gender, a.pseudonym
	FROM Artists a 
	-- INNER JOIN Genres g ON (g.id = a.genre_id)
	INNER JOIN Countries c ON (c.id = a.country_id)
	INNER JOIN Persons p ON (p.id = a.person_id);

CREATE VIEW Artists_albums AS
	SELECT al.title, al.year, CONCAT(p.first_name, ' ', p.last_name) AS artist, a.pseudonym
	FROM Artists a
	INNER JOIN Albums al ON (al.artist_id = a.id)
	INNER JOIN Persons p ON (p.id = a.person_id);

CREATE OR REPLACE FUNCTION add_songs()
RETURNS TRIGGER AS $$
DECLARE 
	count INTEGER;
BEGIN 
	IF TG_OP = 'INSERT' THEN 
		SELECT number_tracks FROM Albums INTO count WHERE id = NEW.album_id;
		UPDATE Albums SET number_tracks = count + 1 WHERE id = NEW.album_id;
	RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF OLD.album_id <> NEW.album_id THEN
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = NEW.album_id) + 1) 
		WHERE id = NEW.album_id;
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = OLD.album_id) - 1) 
		WHERE id = OLD.album_id;
		END IF;
		IF OLD.album_id IS NULL THEN
		UPDATE Albums SET number_tracks = number_tracks + 1
		WHERE id = NEW.album_id;
		END IF;
		IF NEW.album_id IS NULL THEN
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = OLD.album_id) - 1) 
		WHERE id = OLD.album_id;
		END IF;
	RETURN NEW;
	ELSEIF TG_OP = 'DELETE' THEN
		UPDATE Albums SET number_tracks = ((SELECT number_tracks FROM Albums WHERE id = OLD.album_id) - 1) 
		WHERE id = OLD.album_id;
	RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_songs
AFTER INSERT OR UPDATE OR DELETE ON Songs FOR EACH ROW EXECUTE PROCEDURE add_songs();

SELECT s.title, g.name
	FROM Songs s INNER JOIN Genres g ON (s.genre_id = g.id);

UPDATE Albums
	SET number_tracks = 1
	WHERE id = 1;

INSERT INTO Songs (artist_id, title, duration, album_id, track_no) VALUES (1, 'More!', 180, 1, 4);

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---------------------------------------SOME SHIT STARTS

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

SELECT DISTINCT Artists_genre(genre_id) AS count
FROM Artists;

CREATE VIEW Artists_persons2 AS
	SELECT g.name AS genre, c.name AS country, p.first_name, p.last_name, p.birthday, p.gender, a.id
	FROM Artists a 
	INNER JOIN Genres g ON (g.id = a.genre_id)
	INNER JOIN Countries c ON (c.id = a.country_id)
	INNER JOIN Persons p ON (a.person_id = p.id);
 
CREATE VIEW Albums2 AS 
SELECT a.title, s.genre_id 
	FROM Albums a
	INNER JOIN Songs s ON (a.id = s.album_id);

SELECT al.title, g.name
	FROM Albums2 al
	INNER JOIN Genres g ON (al.genre_id = g.id);

CREATE VIEW Artists_genre AS
	SELECT ap.first_name, ap.last_name, g.name 
	FROM Artists_persons INNER JOIN 

SELECT ap.genre, ap.first_name, ap.last_name, a.id
	FROM Artists_persons2 ap INNER JOIN Artists a ON (a.id = ap.id)
	WHERE ap.genre = 'Hip-Hop';

SELECT a.title AS album_title, CONCAT(ap.first_name, ' ', ap.last_name) AS artist, a.id
	FROM Artists_persons2 ap INNER JOIN Albums a ON (a.artist_id = ap.id)
	WHERE ap.genre = 'Hip-Hop';

SELECT a.title AS album_title, CONCAT(ap.first_name, ' ', ap.last_name) AS artist, a.number_tracks
	FROM Artists_persons2 ap INNER JOIN Albums a ON (a.artist_id = ap.id)
	WHERE ap.genre = 'Hip-Hop'
	LIMIT 3 OFFSET 0;

INSERT INTO Songs (title, duration, album_id, track_no) VALUES ('Stop it!', 180, 1, 2);

UPDATE Albums 
	SET number_tracks = 0
	WHERE id = 1;

SELECT g.name
	FROM Genres g INNER JOIN Artists_persons2 ap ON (g.name = ap.genre)
	GROUP BY g.name
	HAVING COUNT(*) > 1;

DROP TABLE IF EXISTS Artists CASCADE;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---------------------------------------SOME SHIT ENDS

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---------------------------------------EXPLAIN JSON XML STARTS

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
EXPLAIN (ANALYZE) SELECT al.title, al.year, CONCAT(p.first_name, ' ', p.last_name) AS artist, a.pseudonym
	FROM Artists a
	INNER JOIN Albums al ON (al.artist_id = a.id)
	INNER JOIN Persons p ON (p.id = a.person_id);

Hash Join  (cost=62.97..111.77 rows=970 width=132) (actual time=0.122..0.137 rows=3 loops=1)
  Hash Cond: (a.person_id = p.id)
  ->  Hash Join  (cost=35.42..68.46 rows=970 width=72) (actual time=0.047..0.052 rows=3 loops=1)
        Hash Cond: (al.artist_id = a.id)
        ->  Seq Scan on albums al  (cost=0.00..19.70 rows=970 width=40) (actual time=0.004..0.004 rows=4 loops=1)
        ->  Hash  (cost=21.30..21.30 rows=1130 width=40) (actual time=0.018..0.018 rows=5 loops=1)
              Buckets: 2048  Batches: 1  Memory Usage: 17kB
              ->  Seq Scan on artists a  (cost=0.00..21.30 rows=1130 width=40) (actual time=0.003..0.007 rows=5 loops=1)
  ->  Hash  (cost=17.80..17.80 rows=780 width=68) (actual time=0.025..0.025 rows=4 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  Seq Scan on persons p  (cost=0.00..17.80 rows=780 width=68) (actual time=0.011..0.014 rows=4 loops=1)
Planning time: 0.625 ms
Execution time: 0.251 ms

CREATE INDEX al_artist_id_idx ON Albums(artist_id);

EXPLAIN (ANALYZE) SELECT al.title, al.year, CONCAT(p.first_name, ' ', p.last_name) AS artist, a.pseudonym
	FROM Artists a
	INNER JOIN Albums al ON (al.artist_id = a.id)
	INNER JOIN Persons p ON (p.id = a.person_id);

Nested Loop  (cost=0.30..26.65 rows=4 width=132) (actual time=0.057..0.113 rows=3 loops=1)
  ->  Nested Loop  (cost=0.15..25.76 rows=4 width=72) (actual time=0.033..0.059 rows=3 loops=1)
        ->  Seq Scan on albums al  (cost=0.00..1.04 rows=4 width=40) (actual time=0.015..0.017 rows=4 loops=1)
        ->  Index Scan using artists_pkey on artists a  (cost=0.15..6.17 rows=1 width=40) (actual time=0.007..0.007 rows=1 loops=4)
              Index Cond: (id = al.artist_id)
  ->  Index Scan using person_id on persons p  (cost=0.15..0.21 rows=1 width=68) (actual time=0.007..0.008 rows=1 loops=3)
        Index Cond: (id = a.person_id)
Planning time: 0.536 ms
Execution time: 0.217 ms

EXPLAIN SELECT * FROM Albums;

Seq Scan ON albums  (cost=0.00..19.70 rows=970 width=56)

EXPLAIN (Analyze) SELECT * FROM Albums;

Seq Scan on albums  (cost=0.00..19.70 rows=970 width=56) (actual time=0.161..0.162 rows=4 loops=1)
Planning time: 0.348 ms
Execution time: 0.437 ms

-----------
-- RANDOM DATA GENERATOR IN DATABASE 'Test'
-----------
CREATE DATABASE Test;

SELECT trunc(random()*21); --random() -случайное 0.0 < x < 1.0, trunc() - округление до целого;

CREATE TABLE test_table2 (
  id SERIAL PRIMARY KEY,
  x INT,
  y INT,
  s1 VARCHAR,
  s2 VARCHAR
);

CREATE OR REPLACE FUNCTION loop(n int) RETURNS VOID AS
$$ DECLARE
x int;
y int;
e int;
s varchar;
s1 varchar;
s2 varchar;
array1 varchar[];
array2 varchar[];
BEGIN
    s:='abcdefghijklmnopqrstuv';
    FOR i IN 1..n LOOP
        x := trunc(random()*100);
        y := trunc(random()*100);
        FOR j IN 1..5 LOOP
            e := trunc(random()*21+1);
            SELECT substring(s from e for 1) INTO s1;
            e := trunc(random()*21+1);
            SELECT substring(s from e for 1) INTO s2;
            array1:=array_append(array1, s1);
            array2:=array_append(array2, s2);
        END LOOP;
        s1 := array_to_string(array1,'');
        s2 := array_to_string(array2,'');
        INSERT INTO test_table2(x, y, s1, s2) VALUES (x, y, s1, s2);
        array1 := '{NULL}';
        array2 := '{NULL}';
        s1 := ' ';
        s2 := ' ';
    END LOOP;
END;
$$
LANGUAGE 'plpgsql';

SELECT * FROM loop(2000);

EXPLAIN (ANALYZE) SELECT * FROM test_table;

Seq Scan on test_table  (cost=0.00..33.20 rows=2020 width=24) (actual time=0.019..0.328 rows=2020 loops=1)
Planning time: 0.100 ms
Execution time: 0.831 ms

CREATE UNIQUE INDEX INDEX_ID ON test_table (id);

EXPLAIN (ANALYZE) SELECT * FROM test_table;

Seq Scan on test_table  (cost=0.00..33.20 rows=2020 width=24) (actual time=0.008..0.263 rows=2020 loops=1)
Planning time: 0.532 ms
Execution time: 0.436 ms

EXPLAIN (ANALYZE) SELECT * FROM test_table
WHERE id > 150 AND s1 LIKE 'a%';

Seq Scan on test_table  (cost=0.00..43.30 rows=94 width=24) (actual time=0.067..0.693 rows=99 loops=1)
  Filter: ((id > 150) AND ((s1)::text ~~ 'a%'::text))
  Rows Removed by Filter: 1921
Planning time: 0.138 ms
Execution time: 0.821 ms

EXPLAIN (ANALYZE) SELECT * FROM test_table
WHERE id < 150 AND s1 LIKE 'a%';

Index Scan using index_id on test_table  (cost=0.28..11.26 rows=8 width=24) (actual time=0.075..0.169 rows=9 loops=1)
  Index Cond: (id < 150)
  Filter: ((s1)::text ~~ 'a%'::text)
  Rows Removed by Filter: 140
Planning time: 0.282 ms
Execution time: 0.215 ms

CREATE UNIQUE INDEX STRING1_ID ON test_table (s1);

DROP INDEX STRING1_ID;

CREATE UNIQUE INDEX STRING1_ID ON test_table (s1 text_pattern_ops);

EXPLAIN (ANALYZE) SELECT * FROM test_table
WHERE id > 150 AND s1 LIKE 'a%';

Bitmap Heap Scan on test_table  (cost=5.51..20.33 rows=94 width=24) (actual time=0.153..0.335 rows=99 loops=1)
  Filter: ((id > 150) AND ((s1)::text ~~ 'a%'::text))
  Rows Removed by Filter: 9
  Heap Blocks: exact=13
  ->  Bitmap Index Scan on string1_id  (cost=0.00..5.49 rows=121 width=0) (actual time=0.111..0.111 rows=108 loops=1)
        Index Cond: (((s1)::text ~>=~ 'a'::text) AND ((s1)::text ~<~ 'b'::text))
Planning time: 0.477 ms
Execution time: 0.417 ms

-----------
-- JSON
-----------

ALTER TABLE test_table ADD COLUMN contacts jsonb;

SELECT * FROM test_table LIMIT 10;

UPDATE test_table SET contacts =  ('{ "email": "example@mail.com",
                          "telephone": { "home": "5113360", "mobile": "890531" } }') WHERE id = 1;
UPDATE test_table SET contacts =  ('{ "email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147",
                          "telephone": { "home": "5113361", "mobile": "890531" } }') WHERE id = 2;
UPDATE test_table SET contacts =  ('{ "email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.52, кв.177",
                          "telephone": { "home": "5113362", "mobile": "890538" },"skype":"iluzka95" }') WHERE id = 3;
UPDATE test_table SET contacts =  ('{ "email": "zahar@mail.com", "address": "г.Москва, ул. Подлужная д.2, кв.77",
                          "telephone": { "mobile": "890538333" },"skype":"zahar95" }') WHERE id = 4;
UPDATE test_table SET contacts =  ('{ "email": "alina@mail.com", "address": "г.Набережные Челны, ул. Роскольникова д.87, кв.3",
"telephone": { "home":"633245","mobile": "890538333" },"skype":"alinka995" }') WHERE id = 5;
UPDATE test_table SET contacts =  ('{ "email": "example3@mail.com", "address": "г.Москва, ул. Васкин д.29, кв.4",
                          "telephone": { "mobile": "890777333" }}') WHERE id = 6;
UPDATE test_table SET contacts =  ('{ "email": "example4@mail.com", "address": "г. Казань, ул. Гагарина д.89, кв.34",
"telephone": { "home":"63333333","mobile": "89012345" } }') WHERE id = 7;
UPDATE test_table SET contacts =  ('{ "email": "example5@mail.com",
                          "telephone": { "mobile": "8933333333" },"skype":"lalalala" }') WHERE id = 8;
UPDATE test_table SET contacts =  ('{ "address": "г.Набережные Челны, ул. Низамиева д.7, кв.54",
"telephone": { "home":"123456","mobile": "8977777777" },"skype":"myyyy995" }') WHERE id = 9;

SELECT * FROM test_table WHERE id < 11;
1	26	76	tsjmu	qhuba	{"email": "example@mail.com", "telephone": {"home": "5113360", "mobile": "890531"}}
2	54	69	aefpf	dtpul	{"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}
3	89	90	oapsb	bcgop	{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}
4	5	52	pmoif	nocpm	{"email": "zahar@mail.com", "skype": "zahar95", "address": "г.Москва, ул. Подлужная д.2, кв.77", "telephone": {"mobile": "890538333"}}
5	64	54	hktkj	hmiml	{"email": "alina@mail.com", "skype": "alinka995", "address": "г.Набережные Челны, ул. Роскольникова д.87, кв.3", "telephone": {"home": "633245", "mobile": "890538333"}}
6	71	21	rtgjm	mtuaa	{"email": "example3@mail.com", "address": "г.Москва, ул. Васкин д.29, кв.4", "telephone": {"mobile": "890777333"}}
7	72	29	daoua	cjobk	{"email": "example4@mail.com", "address": "г. Казань, ул. Гагарина д.89, кв.34", "telephone": {"home": "63333333", "mobile": "89012345"}}
8	66	98	tmpms	dhgmk	{"email": "example5@mail.com", "skype": "lalalala", "telephone": {"mobile": "8933333333"}}
9	52	20	jeahb	uaudh	{"skype": "myyyy995", "address": "г.Набережные Челны, ул. Низамиева д.7, кв.54", "telephone": {"home": "123456", "mobile": "8977777777"}}
10	62	77	arcbn	nbkao	

--начинается с ключа
SELECT * FROM test_table WHERE contacts @> '{"email":"example2@mail.com"}';
2	54	69	aefpf	dtpul	{"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}
3	89	90	oapsb	bcgop	{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}

--начинается и кончается
SELECT * FROM test_table WHERE contacts <@ '{"email":"example2@mail.com"}';

SELECT * FROM test_table WHERE contacts ?| array['email'];

SELECT * FROM test_table WHERE contacts ?| array['telephone'];

SELECT * FROM test_table WHERE contacts ?& array['email','telephone','address','skype'];
3	89	90	oapsb	bcgop	{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}
4	5	52	pmoif	nocpm	{"email": "zahar@mail.com", "skype": "zahar95", "address": "г.Москва, ул. Подлужная д.2, кв.77", "telephone": {"mobile": "890538333"}}
5	64	54	hktkj	hmiml	{"email": "alina@mail.com", "skype": "alinka995", "address": "г.Набережные Челны, ул. Роскольникова д.87, кв.3", "telephone": {"home": "633245", "mobile": "890538333"}}

SELECT
   array_to_json(array_agg(t)) AS test_table
FROM (
   SELECT x, s1, contacts FROM test_table ORDER BY id LIMIT 3) t;

[{"x":26,"s1":"tsjmu","contacts":{"email": "example@mail.com", "telephone": {"home": "5113360", "mobile": "890531"}}},{"x":54,"s1":"aefpf","contacts":{"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}},{"x":89,"s1":"oapsb","contacts":{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}}]

SELECT
   row_to_json(t) AS test_table
FROM (
   SELECT x, s1, contacts FROM test_table ORDER BY id LIMIT 3) t;

{"x":26,"s1":"tsjmu","contacts":{"email": "example@mail.com", "telephone": {"home": "5113360", "mobile": "890531"}}}
{"x":54,"s1":"aefpf","contacts":{"email": "example2@mail.com", "address": "г.Казань, ул. Челюскина д.48, кв.147", "telephone": {"home": "5113361", "mobile": "890531"}}}
{"x":89,"s1":"oapsb","contacts":{"email": "example2@mail.com", "skype": "iluzka95", "address": "г.Казань, ул. Челюскина д.52, кв.177", "telephone": {"home": "5113362", "mobile": "890538"}}}


SELECT * FROM jsonb_each(( SELECT contacts FROM test_table WHERE id = 1));

email	"example@mail.com"
telephone	{"home": "5113360", "mobile": "890531"}

SELECT * FROM jsonb_each_text(( SELECT contacts FROM test_table WHERE id = 1));

SELECT * FROM jsonb_each(( SELECT contacts FROM test_table WHERE id = 1)) t WHERE key = 'email';

SELECT * FROM jsonb_each((SELECT contacts->'telephone' FROM test_table WHERE id = 1));

SELECT table_to_xml('test_table', true, false, '');

SELECT query_to_xml('SELECT * FROM test_table where id < 11 ', true, false, '');

<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  <row>  
 <id>1</id>   <x>26</x>   <y>76</y>   
 <s1>tsjmu</s1>   <s2>qhuba</s2>  
  <contacts>{"email": "example@mail.com", "telephone": {"home": "5113360", "mobile": "890531"}}
  </contacts> 
  </row>  
  </table> 