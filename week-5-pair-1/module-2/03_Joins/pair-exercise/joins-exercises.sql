-- Write queries to return the following:
-- The following queries utilize the "world" database.

-- 1. The city name, country name, and city population of all cities in Europe with population greater than 1 million
-- (36 rows)

SELECT c.name
        , co.name
        , c.population
FROM city AS c
INNER JOIN country AS co
        ON c.countrycode = co.code
WHERE co.continent = 'Europe'
        AND c.population > 1000000;        


-- 2. The city name, country name, and city population of all cities in countries where French is an official language and the city population is greater than 1 million
-- (2 rows)

SELECT c.name
        , co.name
        , c.population
FROM city AS c
INNER JOIN country AS co
        ON c.countrycode = co.code
INNER JOIN countrylanguage AS cl
        ON co.code = cl.countrycode
WHERE cl.language = 'French'
        AND cl.isofficial = 'true'
        AND c.population > 1000000;



-- 3. The name of the countries and continents where the language Javanese is spoken
-- (1 row)

SELECT co.name
        , co.continent
FROM country AS co
INNER JOIN countrylanguage AS cl
        ON cl.countrycode = co.code
WHERE cl.language = 'Javanese';


-- 4. The names of all of the countries in Africa that speak French as an official language
-- (5 row)

SELECT co.name
FROM country AS co
INNER JOIN countrylanguage AS cl
        ON cl.countrycode = co.code
WHERE co.continent = 'Africa'
        AND cl.language = 'French'
         AND cl.isofficial = 'true';



-- 5. The average city population of cities in Europe
-- (average city population in Europe: 287,684)

SELECT AVG(c.population) AS average_city_population
FROM city AS c
INNER JOIN country AS co
        ON c.countrycode = co.code
WHERE continent = 'Europe';




-- 6. The average city population of cities in Asia
-- (average city population in Asia: 395,019)

SELECT AVG(c.population) AS average_city_population
FROM city AS c
INNER JOIN country AS co
        ON c.countrycode = co.code
WHERE continent = 'Asia';




-- 7. The number of cities in countries where English is an official language
-- (number of cities where English is official language: 523)

SELECT COUNT(c.name) AS number_of_cities
        , cl.language
FROM city AS c
INNER JOIN country AS co
        ON c.countrycode = co.code
INNER JOIN countrylanguage AS cl
        ON co.code = cl.countrycode
WHERE cl.language = 'English'
        AND cl.isofficial = 'true'
GROUP BY cl.language;

-- 8. The average population of cities in countries where the official language is English
-- (average population of cities where English is official language: 285,809)

SELECT AVG(c.population) AS number_of_cities
        , cl.language
FROM city AS c
INNER JOIN country AS co
        ON c.countrycode = co.code
INNER JOIN countrylanguage AS cl
        ON co.code = cl.countrycode
WHERE cl.language = 'English'
        AND cl.isofficial = 'true'
GROUP BY cl.language;

-- 9. The names of all of the continents and the population of the continent’s largest city
-- (6 rows, largest population for North America: 8,591,309)

SELECT MAX (c.population) AS largest_city
        , continent
FROM country AS co
INNER JOIN city AS c
        ON c.countrycode = co.code
GROUP BY continent;


-- 10. The names of all of the cities in South America that have a population of more than 1 million people
-- and the official language of each city’s country
-- (29 rows)

SELECT c.name AS city_name
        , c.population
        , cl.isofficial
FROM city AS c
INNER JOIN country AS co
        ON co.code = c.countrycode
INNER JOIN countrylanguage AS cl
        ON cl.countrycode = co.code
WHERE continent = 'South America'
        AND c.population > 1000000
        AND cl.isofficial = TRUE;