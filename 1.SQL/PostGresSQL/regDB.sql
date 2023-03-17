--Testing ERD

CREATE TABLE licenses (
license_id varchar(10),
first_name varchar(50),
last_name varchar(50),
CONSTRAINT licenses_key PRIMARY KEY (license_id)
);

CREATE TABLE registrations (
registration_id varchar(10),
registration_date date,
license_id varchar(10) REFERENCES licenses (license_id) ON DELETE CASCADE,
CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id)
);

INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '2017/03/17', 'T229901');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A75772', '2017/03/17', 'T000001');

SELECT * FROM registrations;

SELECT * FROM licenses;

DELETE FROM licenses
WHERE license_id ='T229901';

DROP TABLE registrations;

CREATE TABLE check_constraint_example (
user_id bigserial,
user_role varchar(50),
salary integer,
CONSTRAINT user_id_key PRIMARY KEY (user_id),
CONSTRAINT check_role_in_list CHECK (user_role IN('Admin', 'Staff')),
CONSTRAINT check_salary_not_zero CHECK (salary > 0)
);

INSERT INTO check_constraint_example(salary, user_role)
VALUES 
(50000, 'Staff');




CREATE TABLE unique_constraint_example (
contact_id bigserial CONSTRAINT contact_id_key PRIMARY KEY,
first_name varchar(50),
last_name varchar(50),
email varchar(200),
CONSTRAINT email_unique UNIQUE (email));

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Samantha', 'Lee', 'slee@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Betty', 'Diaz', 'bdiaz@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Sasha', 'Lee', 'slee@example.org');

CREATE TABLE not_null_example (
student_id bigserial,
first_name varchar(50) NOT NULL,
last_name varchar(50)NOT NULL,
CONSTRAINT student_id_key PRIMARY KEY (student_id)
);

INSERT INTO not_null_example(first_name)
Values('Gareth' );

DROP TABLE not_null_example;

SELECT * FROM not_null_example;

DELETE FROM not_null_example;

ALTER TABLE not_null_example ALTER COLUMN last_name DROP NOT NULL;

ALTER TABLE not_null_example ALTER COLUMN last_name SET NOT NULL ;





CREATE TABLE new_york_addresses (
longitude numeric(9,6),
latitude numeric(9,6),
street_number varchar(10),
street varchar(32),
unit varchar(7),
postcode varchar(5),
id integer CONSTRAINT new_york_key PRIMARY KEY
);
COPY new_york_addresses
FROM 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_07\city_of_new_york.csv'
WITH (FORMAT CSV, HEADER);

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = '52 STREET';

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'ZWICKY AVENUE';

CREATE INDEX street_idx ON new_york_addresses (street);

