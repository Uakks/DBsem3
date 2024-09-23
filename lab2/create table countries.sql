create table countries (
    country_id serial primary key,
    country_name varchar(100),
    region_id integer,
    population integer
);