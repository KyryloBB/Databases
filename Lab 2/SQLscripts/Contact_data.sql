CREATE TABLE Contact_data (
  Contact_data_id serial PRIMARY KEY,
  Phone varchar(13) NOT NULL UNIQUE,
  Email varchar(32) UNIQUE
);