insert into countries_new (country_id ,country_name, region_id, population) values (9, 'Kazakhstan', 1, 99000);

UPDATE countries_new
SET population = population * 1.10
RETURNING country_name AS country_name, population AS "New Population";

delete from countries_new
where population < 100000;