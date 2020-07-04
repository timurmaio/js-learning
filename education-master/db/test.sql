------------------------------
------------------------------
------------------------------
---------------
---------------------JSON
---------------
------------------------------
------------------------------
------------------------------
CREATE TABLE json_test (
  id serial primary key,
  data jsonb
);

INSERT INTO json_test (data) VALUES 
  ('{}'),
  ('{"a": 1}'),
  ('{"a": 2, "b": ["c", "d"]}'),
  ('{"a": 1, "b": {"c": "d", "e": true}}'),
  ('{"b": 2}');

SELECT * FROM json_test;

COPY (SELECT row_to_json(t)
FROM (select * from json_test) t)
TO '/Users/Timur/Dev/json_test.json';

COPY 5 -- success

SELECT * FROM json_test WHERE data = '{"a":1}';

2	{"a": 1}

SELECT * FROM json_test WHERE data @> '{"a":1}';

2	{"a": 1}
4	{"a": 1, "b": {"c": "d", "e": true}}

SELECT * FROM json_test WHERE data <@ '{"a":1}';

1	{}
2	{"a": 1}

SELECT * FROM json_test WHERE data ?| array['a', 'b'];

2 {"a": 1}
3 {"a": 2, "b": ["c", "d"]}
4 {"a": 1, "b": {"c": "d", "e": true}}
5 {"b": 2}

SELECT * FROM json_test WHERE data ?& array['a','b'];

3 {"a": 2, "b": ["c", "d"]}
4 {"a": 1, "b": {"c": "d", "e": true}}

SELECT * FROM json_test WHERE data ?| array['a'];

2 {"a": 1}
3 {"a": 2, "b": ["c", "d"]}
4 {"a": 1, "b": {"c": "d", "e": true}}

------------------------------
------------------------------
------------------------------
---------------
---------------------EXPLAIN
---------------
------------------------------
------------------------------
------------------------------
-----------
-- RANDOM DATA GENERATOR IN DATABASE 'Test'
-----------
CREATE DATABASE Test;

SELECT trunc(random()*21); --random() -случайное 0.0 < x < 1.0, trunc() - округление до целого;

CREATE TABLE test_table (
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
        INSERT INTO test_table(x, y, s1, s2) VALUES (x, y, s1, s2);
        array1 := '{NULL}';
        array2 := '{NULL}';
        s1 := ' ';
        s2 := ' ';
    END LOOP;
END;
$$
LANGUAGE 'plpgsql';

SELECT * FROM loop(1000);

EXPLAIN (ANALYZE) SELECT * FROM test_table;

Seq Scan on test_table  (cost=0.00..33.20 rows=2020 width=24) (actual time=0.019..0.328 rows=2020 loops=1)
Planning time: 0.100 ms
Execution time: 0.831 ms

CREATE INDEX test_id_idx ON test_table (id);

EXPLAIN (ANALYZE) SELECT * FROM test_table;

Seq Scan on test_table  (cost=0.00..33.20 rows=2020 width=24) (actual time=0.008..0.263 rows=2020 loops=1)
Planning time: 0.532 ms
Execution time: 0.436 ms

EXPLAIN (ANALYZE) SELECT * FROM test_table
WHERE id < 500 ;

Seq Scan on test_table  (cost=0.00..19.50 rows=500 width=24) (actual time=0.025..0.591 rows=499 loops=1)
  Filter: (id < 500)
  Rows Removed by Filter: 501
Planning time: 0.170 ms
Execution time: 0.700 ms

SET enable_seqscan TO off;

Index Scan using test_id_idx on test_table  (cost=0.28..28.02 rows=500 width=24) (actual time=0.048..0.294 rows=499 loops=1)
  Index Cond: (id < 500)
Planning time: 0.256 ms
Execution time: 0.373 ms

SET enable_seqscan TO on;

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
WHERE id > 150 AND s1 LIKE 'a%' AND s2 LIKE 'b%';

Bitmap Heap Scan on test_table  (cost=4.88..12.93 rows=2 width=24) (actual time=0.188..0.214 rows=3 loops=1)
  Filter: ((id > 150) AND ((s1)::text ~~ 'a%'::text) AND ((s2)::text ~~ 'b%'::text))
  Rows Removed by Filter: 47
  Heap Blocks: exact=7
  ->  Bitmap Index Scan on string1_id  (cost=0.00..4.88 rows=60 width=0) (actual time=0.136..0.136 rows=50 loops=1)
        Index Cond: (((s1)::text ~>=~ 'a'::text) AND ((s1)::text ~<~ 'b'::text))
Planning time: 3.056 ms
Execution time: 0.318 ms

------------------------------
------------------------------
------------------------------
---------------
---------------------XML
---------------
------------------------------
------------------------------
------------------------------

SELECT query_to_xml('SELECT * FROM test_table limit 10', true, false, '');

<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<row>
  <id>10</id>
  <x>62</x>
  <y>77</y>
  <s1>arcbn</s1>
  <s2>nbkao</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>11</id>
  <x>40</x>
  <y>39</y>
  <s1>uujbk</s1>
  <s2>usksg</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>12</id>
  <x>94</x>
  <y>50</y>
  <s1>fonct</s1>
  <s2>fhgot</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>13</id>
  <x>78</x>
  <y>5</y>
  <s1>ibljj</s1>
  <s2>rbkkj</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>14</id>
  <x>38</x>
  <y>92</y>
  <s1>urqta</s1>
  <s2>jjpbn</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>15</id>
  <x>40</x>
  <y>69</y>
  <s1>tijta</s1>
  <s2>ksdsa</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>16</id>
  <x>94</x>
  <y>55</y>
  <s1>kbsst</s1>
  <s2>iujrp</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>17</id>
  <x>28</x>
  <y>70</y>
  <s1>jqseo</s1>
  <s2>ekdqm</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>18</id>
  <x>65</x>
  <y>13</y>
  <s1>qamhh</s1>
  <s2>lrtbj</s2>
  <contacts xsi:nil="true"/>
</row>

<row>
  <id>19</id>
  <x>5</x>
  <y>24</y>
  <s1>sbnlm</s1>
  <s2>trhcg</s2>
  <contacts xsi:nil="true"/>
</row>
</table>

COPY (SELECT query_to_xml('SELECT * FROM test_table limit 10', true, false, '')) TO '/Users/Timur/Dev/xml_test.xml';



