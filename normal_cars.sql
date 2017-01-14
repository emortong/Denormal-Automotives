DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars normal_user;
\i scripts/denormal_data.sql;

DROP TABLE IF EXISTS model_table;

DROP TABLE IF EXISTS make_table;


CREATE TABLE make_table (
  make_code character varying(125),
  make_title character varying(125),
  id serial primary key
);

CREATE TABLE model_table (
  id serial primary key,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL,
  year integer NOT NULL,
  make_id integer references make_table(id)
);

INSERT into make_table (make_code, make_title) SELECT DISTINCT make_code, make_title FROM car_models;

INSERT INTO model_table (model_title, model_code, year, make_id)
SELECT DISTINCT model_title, model_code, year, id AS make_id
FROM car_models
INNER JOIN make_table ON car_models.make_title = make_table.make_title;

SELECT DISTINCT make_title FROM car_models;

-- SELECT DISTINCT model_title FROM car_models WHERE make_code = 'VOLKS';

-- SELECT DISTINCT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM';

-- SELECT DISTINCT * FROM car_models WHERE year BETWEEN 2010 AND 2015;

