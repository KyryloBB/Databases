CREATE TABLE Driving_school (
  Driving_school_id serial PRIMARY KEY,
  Contact_data_id integer references Contact_data(Contact_data_id) NOT NULL UNIQUE,
  Address varchar(60) NOT NULL UNIQUE,
  Director varchar(60) NOT NULL UNIQUE
);