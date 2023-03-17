COPY us_ocunties_2010
FROM 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_04\your_file.csv'
WITH (FORMAT CSV, HEADER);



CREATE TABLE us_counties_2010 (
    geo_name varchar(90),                    
    state_us_abbreviation varchar(2),       
    summary_level varchar(3),               
    region smallint,                         
    division smallint,                    
    state_fips varchar(2),                  
    area_water bigint,                        
    population_count_100_percent integer,    
    housing_unit_count_100_percent integer,  
    internal_point_lat numeric(10,7),        
    internal_point_lon numeric(10,7),        

    -- This section is referred to as P1. Race:
    p0010001 integer,   
    p0010002 integer,  
    p0010003 integer,
    p0010004 integer,      
    p0010005 integer,       
    p0010006 integer,      
    p0010007 integer,       
    p0010008 integer,       
    p0010009 integer,  
    p0010010 integer,   
    p0010011 integer,     
    p0010012 integer,       
    p0010013 integer,     
    p0010014 integer,     
    p0010015 integer,      
    p0010016 integer,    
    p0010017 integer,      
    p0010018 integer,     
    p0010019 integer,      
    p0010020 integer,      
    p0010021 integer,      
    p0010022 integer,      
    p0010023 integer,      
    p0010024 integer,       
    p0010025 integer,
    p0010026 integer,   
    p0010047 integer,   
    p0010063 integer,   
    p0010070 integer,  

    -- This section is referred to as P2. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    p0020001 integer,   
    p0020002 integer,   
    p0020003 integer,   
    p0020004 integer,  
    p0020005 integer,     
    p0020006 integer,       
    p0020007 integer,       
    p0020008 integer,   
    p0020009 integer,       
    p0020010 integer,      
    p0020011 integer,   
    p0020012 integer,   
    p0020028 integer,   
    p0020049 integer,   
    p0020065 integer,   
    p0020072 integer,   

    -- This section is referred to as P3. RACE FOR THE POPULATION 18 YEARS AND OVER
    p0030001 integer,  
    p0030002 integer,
    p0030003 integer,      
    p0030004 integer,     
    p0030005 integer,     
    p0030006 integer,      
    p0030007 integer,     
    p0030008 integer,      
    p0030009 integer,   
    p0030010 integer,   
    p0030026 integer,   
    p0030047 integer,   
    p0030063 integer,   
    p0030070 integer,   
	
    -- This section is referred to as P4. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    -- FOR THE POPULATION 18 YEARS AND OVER
    p0040001 integer,   
    p0040002 integer,   
    p0040003 integer,   
    p0040004 integer,  
    p0040005 integer,  
    p0040006 integer,   
    p0040007 integer,  
    p0040008 integer,   
    p0040009 integer, 
    p0040010 integer,  
    p0040011 integer,  
    p0040012 integer,  
    p0040028 integer,   
    p0040049 integer,  
    p0040065 integer,   
    p0040072 integer,   

    -- This section is referred to as H1. OCCUPANCY STATUS
    h0010001 integer,   
    h0010002 integer,   
    h0010003 integer    
);

SELECT * FROM us_counties_2010;


COPY us_counties_2010
FROM 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_04\us_counties_2010.csv'
WITH (FORMAT CSV, HEADER);

-- Checking the data

SELECT * FROM us_counties_2010;

SELECT geo_name, state_us_abbreviation, area_land
FROM us_counties_2010
ORDER BY area_land DESC
LIMIT 3;

SELECT geo_name, state_us_abbreviation, internal_point_lon
FROM us_counties_2010
ORDER BY internal_point_lon DESC
LIMIT 5;


-- Listing 4-4: Creating a table to track supervisor salaries

CREATE TABLE supervisor_salaries (
    town varchar(30),
    county varchar(30),
    supervisor varchar(30),
    start_date date,
    salary money,
    benefits money
);

-- Check the data
SELECT * FROM supervisor_salaries LIMIT 2;

-- Use a temporary table to add a default value to a column during
-- import

DELETE FROM supervisor_salaries;

CREATE TEMPORARY TABLE supervisor_salaries_temp (LIKE supervisor_salaries);

COPY supervisor_salaries_temp (town, supervisor, salary)
FROM 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_04\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries (town, county, supervisor, salary)
SELECT town, 'Some County', supervisor, salary
FROM supervisor_salaries_temp;

DROP TABLE supervisor_salaries_temp;

-- Check the data
SELECT * FROM supervisor_salaries LIMIT 2;

-- Export an entire table with COPY

COPY us_counties_2010
TO 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_04\us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');


-- Exporting selected columns from a table with COPY

COPY us_counties_2010 (geo_name, internal_point_lat, internal_point_lon)
TO 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_04\us_counties_latlon_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- Exporting query results with COPY

COPY (
    SELECT geo_name, state_us_abbreviation
    FROM us_counties_2010
    WHERE geo_name ILIKE '%mill%'
     )
TO 'C:\Users\User\OneDrive\Documents\PostGresSQL\practical-sql-main\Chapter_04\us_counties_mill_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');
