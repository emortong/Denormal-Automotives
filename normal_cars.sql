DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars normal_user;
\i scripts/denormal_data.sql;

DROP TABLE IF EXISTS make_table;

DROP TABLE IF EXISTS model_table;

CREATE TABLE IF NOT EXISTS make_table (
  id serial,
  make_code character varying(125),
  make_title character varying(125)
);

CREATE TABLE IF NOT EXISTS model_table (
  id serial,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL,
  make_id integer,
  year integer NOT NULL
);

INSERT into make_table (make_code, make_title) SELECT DISTINCT make_code, make_title FROM car_models;

INSERT into model_table (model_code, model_title, year) SELECT DISTINCT model_code, model_title, year FROM car_models;

