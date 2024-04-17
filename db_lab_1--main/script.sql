CREATE TABLE country
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE departament
(
	id SERIAL PRIMARY KEY,
	country_id INT NOT NULL,
	name VARCHAR(255) NOT NULL
);

ALTER TABLE departament ADD CONSTRAINT fk_country 
	FOREIGN KEY(country_id)
	 	REFERENCES country(id) ON DELETE CASCADE;

CREATE TABLE spacemission 
(
	id SERIAL PRIMARY KEY,
	country_id INT NOT NULL
);

ALTER TABLE spacemission ADD CONSTRAINT fk_country_space
	FOREIGN KEY(country_id)
		REFERENCES country(id) ON DELETE CASCADE;


CREATE TABLE telescope 
(
	id SERIAL PRIMARY KEY
);


CREATE TABLE telescope_spacemission
(
	telescope_id INT NOT NULL,
	spacemission_id INT NOT NULL,
	PRIMARY KEY(telescope_id, spacemission_id),

	CONSTRAINT fk_telescope
		FOREIGN KEY(telescope_id)
			REFERENCES telescope(id) ON DELETE CASCADE,

	CONSTRAINT fk_spacemission
		FOREIGN KEY(spacemission_id)
			REFERENCES spacemission(id) ON DELETE CASCADE
);

CREATE TABLE spaceship
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE spaceship_spacemission
(
	spaceship_id INT NOT NULL,
	spacemission_id INT NOT NULL,
	PRIMARY KEY(spaceship_id, spacemission_id),

	CONSTRAINT fk_spaceship
		FOREIGN KEY(spaceship_id)
			REFERENCES spaceship(id) ON DELETE CASCADE,

	CONSTRAINT fk_spacemission
		FOREIGN KEY(spacemission_id)
			REFERENCES spacemission(id) ON DELETE CASCADE
);

CREATE TYPE gender AS ENUM ('MALE', 'FEMALE');

CREATE TABLE person
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	patronymic VARCHAR(255),
	gender gender
);

CREATE TABLE crew_member
(
	id INT PRIMARY KEY,
	spaceship_id INT NOT NULL,

	CONSTRAINT fk_person
		FOREIGN KEY(id)
			REFERENCES person(id) ON DELETE CASCADE,
	CONSTRAINT fk_spaceship
		FOREIGN KEY(spaceship_id)
			REFERENCES spaceship(id) ON DELETE CASCADE
);

CREATE TABLE scientist
(
	id INT PRIMARY KEY,

	CONSTRAINT fk_person
		FOREIGN KEY(id)
			REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE telescope_scientist
(
	telescope_id INT NOT NULL,
	scientist_id INT NOT NULL,
	PRIMARY KEY(telescope_id, scientist_id),

	CONSTRAINT fk_telescope
		FOREIGN KEY(telescope_id)
			REFERENCES telescope(id) ON DELETE CASCADE,

	CONSTRAINT fk_scientist
		FOREIGN KEY(scientist_id)
			REFERENCES scientist(id) ON DELETE CASCADE
);






INSERT INTO country (name) VALUES ('USA');
INSERT INTO country (name) VALUES ('CHINA');
INSERT INTO country (name) VALUES ('RUSSIA');

INSERT INTO departament (country_id, name) 
VALUES ((SELECT id FROM country WHERE name='USA'), 'GOSDEP');
INSERT INTO departament (country_id, name) 
VALUES ((SELECT id FROM country WHERE name='CHINA'), 'PINYIN');
INSERT INTO departament (country_id, name) 
VALUES ((SELECT id FROM country WHERE name='RUSSIA'), 'ROSCOSMOS');

INSERT INTO spacemission (country_id)
VALUES ((SELECT id FROM country WHERE name='USA'));
INSERT INTO spacemission (country_id)
VALUES ((SELECT id FROM country WHERE name='CHINA'));
INSERT INTO spacemission (country_id)
VALUES ((SELECT id FROM country WHERE name='RUSSIA'));

INSERT INTO telescope DEFAULT VALUES;
INSERT INTO telescope DEFAULT VALUES;
INSERT INTO telescope DEFAULT VALUES;

INSERT INTO telescope_spacemission (telescope_id, spacemission_id)
VALUES(
	(SELECT t.id FROM telescope as t WHERE id=1),
	(SELECT s.id FROM spacemission as s WHERE id=1)
);
INSERT INTO telescope_spacemission (telescope_id, spacemission_id)
VALUES(
	(SELECT t.id FROM telescope as t WHERE id=2),
	(SELECT s.id FROM spacemission as s WHERE id=2)
);
INSERT INTO telescope_spacemission (telescope_id, spacemission_id)
VALUES(
	(SELECT t.id FROM telescope as t WHERE id=3),
	(SELECT s.id FROM spacemission as s WHERE id=3)
);

INSERT INTO spaceship (name) VALUES ('OREON');
INSERT INTO spaceship (name) VALUES ('СHINA_LYOT');
INSERT INTO spaceship (name) VALUES ('RUSSO_LYOT');

INSERT INTO spaceship_spacemission (spaceship_id, spacemission_id)
VALUES (
	(SELECT s.id FROM spaceship as s WHERE id=1),
	(SELECT s.id FROM spacemission as s WHERE id=1)
);
INSERT INTO spaceship_spacemission (spaceship_id, spacemission_id)
VALUES (
	(SELECT s.id FROM spaceship as s WHERE id=2),
	(SELECT s.id FROM spacemission as s WHERE id=2)
);
INSERT INTO spaceship_spacemission (spaceship_id, spacemission_id)
VALUES (
	(SELECT s.id FROM spaceship as s WHERE id=3),
	(SELECT s.id FROM spacemission as s WHERE id=3)
);

INSERT INTO person(name, last_name, patronymic, gender) 
VALUES ('Erik', 'Karapetyan', 'Akopovich', 'FEMALE');
INSERT INTO person(name, last_name, patronymic, gender) 
VALUES ('Ivan', 'Kustarev', 'Pavlovich', 'MALE');
INSERT INTO person(name, last_name, patronymic, gender) 
VALUES ('Pavel', 'Danilov', 'Alexandrovich', 'MALE');
INSERT INTO person(name, last_name, patronymic, gender) 
VALUES ('Konstantin', 'Zinchenko', 'Petrovich', 'MALE');

INSERT INTO crew_member(id, spaceship_id) VALUES(
	(SELECT p.id FROM person as p WHERE id=1),
	(SELECT s.id FROM spaceship as s WHERE id=1)
);
INSERT INTO crew_member(id, spaceship_id) VALUES(
	(SELECT p.id FROM person as p WHERE id=2),
	(SELECT s.id FROM spaceship as s WHERE id=2)
);
INSERT INTO crew_member(id, spaceship_id) VALUES(
	(SELECT p.id FROM person as p WHERE id=3),
	(SELECT s.id FROM spaceship as s WHERE id=3)
);

INSERT INTO scientist(id) VALUES(
	(SELECT p.id FROM person as p WHERE id=4)
);

INSERT INTO telescope_scientist(telescope_id, scientist_id) VALUES(
	(SELECT t.id FROM telescope as t WHERE id=1),
	(SELECT s.id FROM scientist as s WHERE id=4)
);




drop table country, crew_member, departament, person, scientist, spacemission, spaceship, spaceship_spacemission, telescope, telescope_scientist, telescope_spacemission;