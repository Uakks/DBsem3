UPDATE countries
SET population = population * 1.10
RETURNING country_name AS country_name, population AS "New Population";