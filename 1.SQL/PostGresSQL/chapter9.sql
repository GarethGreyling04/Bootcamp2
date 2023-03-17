--chapter 9

CREATE TABLE meat_poultry_egg_inspect (
             est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
             company varchar(100),
             street varchar(100),
             city varchar(30),
             st varchar(2),
             zip varchar(5),
             phone varchar(14),
             grant_date date,
             activities text,
             dbas text);

COPY meat_poultry_egg_inspect
FROM 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_09\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');
CREATE INDEX company_idx ON meat_poultry_egg_inspect (company);

SELECT * FROM meat_poultry_egg_inspect;

SELECT count(*) FROM meat_poultry_egg_inspect;

SELECT company,
street,
city,
st,
count(*) AS address_count
FROM meat_poultry_egg_inspect
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
GROUP BY st
ORDER BY st;

SELECT est_number,
company,
city,
st,
zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

SELECT company,
count(*) AS company_count
FROM meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

SELECT length(zip),
count(*) AS length_count
FROM meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;

SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
 WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN zip_copy varchar(5);
UPDATE meat_poultry_egg_inspect
SET zip_copy = zip;

UPDATE meat_poultry_egg_inspect
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;

UPDATE meat_poultry_egg_inspect
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;

CREATE TABLE state_regions (
st varchar(2) CONSTRAINT st_key PRIMARY KEY,
region varchar(20) NOT NULL
);
COPY state_regions
FROM 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_09\state_regions.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM state_regions;

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN inspection_date date;

UPDATE meat_poultry_egg_inspect inspect
SET inspection_date = '2019-12-01'
WHERE EXISTS (SELECT state_regions.region
FROM state_regions
WHERE inspect.st = state_regions.st
AND state_regions.region = 'New England');

SELECT inspection_date FROM meat_poultry_egg_inspect;
SELECT * FROM meat_poultry_egg_inspect;

SELECT st, inspection_date
FROM meat_poultry_egg_inspect
GROUP BY st, inspection_date
ORDER BY st;

DELETE FROM meat_poultry_egg_inspect
WHERE st IN('PR','VI');

ALTER TABLE meat_poultry_egg_inspect DROP COLUMN zip_copy;

DROP TABLE meat_poultry_egg_inspect_backup;

START TRANSACTION;

UPDATE meat_poultry_egg_inspect
SET company = 'AGRO Merchants Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

SELECT company
FROM meat_poultry_egg_inspect
WHERE company LIKE 'AGRO%'
ORDER BY company;

ROLLBACK;

COMMIT;

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT *,
'2018-02-07'::date AS reviewed_date
FROM meat_poultry_egg_inspect;

SELECT * FROM meat_poultry_egg_inspect_backup;

ALTER TABLE meat_poultry_egg_inspect RENAME TO meat_poultry_egg_inspect_temp;

ALTER TABLE meat_poultry_egg_inspect_backup
RENAME TO meat_poultry_egg_inspect;

ALTER TABLE meat_poultry_egg_inspect_temp
RENAME TO meat_poultry_egg_inspect_backup;