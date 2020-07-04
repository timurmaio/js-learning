CREATE DATABASE Manufacture;

CREATE TYPE TAG AS ENUM ('Сборочная единица', 'Готовая деталь');

CREATE TABLE Parts ( --таблица деталей
	id SERIAL PRIMARY KEY,
	name VARCHAR,
	tag TAG NOT NULL);

INSERT INTO Parts (name, tag) VALUES
	('Литий','Сборочная единица'), --1
	('Ион','Сборочная единица'), --2
	('Батарея','Готовая деталь'), --3
	('Батарея','Сборочная единица'), --4
	('Матрица','Сборочная единица'), --5
	('Светодиод','Сборочная единица'), --6
	('Дисплей','Готовая деталь'), --7
	('Дисплей','Сборочная единица'), --8
	('Модуль памяти','Сборочная единица'), --9
	('Подложка','Сборочная единица'), --10
	('Оперативная память','Готовая деталь'), --11
	('Оперативная память','Сборочная единица'), --12
	('Пластик','Сборочная единица'), --13
	('Каркас','Сборочная единица'), --14
	('Корпус','Готовая деталь'), --15
	('Корпус','Сборочная единица'), --16
	('Транзистор','Сборочная единица'), --17
	('Процессор','Готовая деталь'), --18
	('Процессор','Сборочная единица'), --19
	('Смартфон','Готовая деталь'); --20

CREATE TABLE Workshops ( --таблица цехов
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL);

INSERT INTO Workshops (name) VALUES
('Цех производства смартфонов'); --1

CREATE TABLE Sites ( --таблица участков
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	workshop_id INTEGER NOT NULL,
	FOREIGN KEY (workshop_id) REFERENCES Workshops (id));

INSERT INTO Sites (name, workshop_id) VALUES
	('Участок сборки батарей',1), --1
	('Участок сборки дисплеев',1), --2
	('Участок сборки оперативной памяти',1), --3
	('Участок сборки корпусов',1), --4
	('Участок сборки процессоров',1), --5
	('Участок сборки смартфонов',1); --6

CREATE TABLE Assembly ( --таблица сборки
	id SERIAL PRIMARY KEY, --номер операции сборки
	finished_part_id INTEGER NOT NULL,
	incoming_part_id INTEGER NOT NULL,
	parts_no INTEGER DEFAULT 1,
	workshop_id INTEGER NOT NULL,
	site_id INTEGER DEFAULT 1,
	CHECK (parts_no > 0),
	FOREIGN KEY (finished_part_id) REFERENCES Parts(id),
	FOREIGN KEY (incoming_part_id) REFERENCES Parts(id),
	FOREIGN KEY (workshop_id) REFERENCES Workshops(id),
	FOREIGN KEY (site_id) REFERENCES Sites(id));

INSERT INTO Assembly (finished_part_id,incoming_part_id,parts_no,workshop_id,site_id) VALUES
	(3,1,DEFAULT,1,1),
	(3,2,DEFAULT,1,1),
	(7,5,DEFAULT,1,2),
	(7,6,30,1,2),
	(11,9,8,1,3),
	(11,10,DEFAULT,1,3),
	(15,13,3,1,4),
	(15,14,2,1,4),
	(18,17,1000,1,5),
	(18,10,DEFAULT,1,5),
	(20,4,DEFAULT,1,6),
	(20,8,DEFAULT,1,6),
	(20,12,2,1,6),
	(20,16,DEFAULT,1,6),
	(20,19,DEFAULT,1,6);

CREATE TABLE Plan (
	part_id INTEGER NOT NULL,
	year SMALLINT,
	per_year INTEGER NOT NULL, --план в штуках
	--start_date DATE,
	FOREIGN KEY (part_id) REFERENCES Parts(id));

CREATE TABLE Amount (
	part_id INTEGER,
	amount INTEGER DEFAULT 0,
	FOREIGN KEY (part_id) REFERENCES Parts(id));

INSERT INTO Amount (part_id,amount) VALUES
	(3,DEFAULT),
	(7,DEFAULT),
	(11,DEFAULT),
	(15,DEFAULT),
	(18,DEFAULT),
	(20,DEFAULT);

CREATE OR REPLACE FUNCTION add_amount()
	RETURNS TRIGGER AS $$
	DECLARE
		count INTEGER;
		BEGIN
			IF TG_OP = 'INSERT' THEN
				--SELECT per_year FROM Plan INTO count WHERE part_id = NEW.per_year;
				UPDATE Amount SET amount = amount + NEW.per_year WHERE part_id = NEW.part_id;
			RETURN NEW;
			END IF;
		END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_amount
	AFTER INSERT ON Plan FOR EACH ROW EXECUTE PROCEDURE add_amount();

INSERT INTO Plan (part_id,year,per_year) VALUES
	--(3,2010,100),
	--(3,2011,700),
	(7,2010,200),
	(7,2011,350);
