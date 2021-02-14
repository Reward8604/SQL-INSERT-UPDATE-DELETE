-- Write queries to return the following:
-- Make the following changes in the "world" database.

--INSERT INTO <table>(<available columns>)
--VALUES (<values>)

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)

SELECT *
FROM city;

INSERT INTO city
(
        name
        , countrycode
        , district
        , population
)
VALUES
(
        'Smallville'
        , 'USA'
        , 'Kansas'
        , 45001
);

SELECT *
FROM city
WHERE district = 'Kansas';

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

SELECT *
FROM countrylanguage;

INSERT INTO countrylanguage
(
        countrycode
        , language
        , isofficial
        , percentage
)
VALUES
(
        'USA'
        , 'Kryptonese'
        , false
        , 0.0001
);

SELECT *
FROM countrylanguage
WHERE countrycode = 'USA';

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.

SELECT *
FROM countrylanguage
WHERE countrycode = 'USA';

UPDATE countrylanguage
SET language = 'Krypto-babble'
WHERE language = 'Kryptonese';

SELECT *
FROM countrylanguage
WHERE countrycode = 'USA';

-- 4. Set the US captial to Smallville, Kansas in the country table.

--current 3813
-- Smallville code: 4080
SELECT *
FROM country
WHERE code = 'USA';

SELECT *
FROM city
WHERE countrycode = 'USA'
        AND district = 'Kansas';

SELECT *
FROM country
WHERE code = 'USA';

UPDATE country
SET capital = 4080
WHERE code = 'USA';

SELECT *
FROM country
WHERE code = 'USA';

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city
WHERE name = 'Smallville';

-- 6. Return the US captial to Washington.

UPDATE country
SET capital = 3813
WHERE code = 'USA';

SELECT *
FROM country
WHERE code = 'USA';

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city
WHERE name = 'Smallville';

SELECT *
FROM city
WHERE countrycode = 'USA'
        AND district = 'Kansas';

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)

SELECT *
FROM countrylanguage;

SELECT cl.countrycode
        , cl.isofficial
        , NOT cl.isofficial 
FROM country AS c
JOIN countrylanguage AS cl
        ON cl.countrycode = c.code
WHERE indepyear >= 1800
        AND indepyear <= 1972;

BEGIN TRANSACTION;

UPDATE countrylanguage
SET isofficial = NOT isofficial
WHERE countrycode IN
(
        SELECT code
        FROM country
        WHERE indepyear >= 1800
                AND indepyear <= 1972
);
        
ROLLBACK TRANSACTION;

COMMIT TRANSACTION;
        
     
SELECT *
FROM countrylanguage;

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)

SELECT *
FROM city;

BEGIN TRANSACTION;

UPDATE city
SET population = population / 1000
WHERE population > 0;

ROLLBACK TRANSACTION;

COMMIT TRANSACTION;


-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to 
-- square meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)

-- FRA - 551500.0
SELECT name
        , code
        , surfacearea
FROM country
WHERE code = 'FRA';

SELECT *
FROM countrylanguage
WHERE language ILIKE 'French'
        AND percentage >= 20.0;

BEGIN TRANSACTION;

UPDATE country
SET surfacearea = (surfacearea * 1609.34)
WHERE code IN
(
        SELECT countrycode
        FROM countrylanguage
        WHERE language ILIKE 'French'
                AND percentage >= 20.0
);

ROLLBACK TRANSACTION;

COMMIT TRANSACTION;