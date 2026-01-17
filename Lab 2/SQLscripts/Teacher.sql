CREATE TABLE Teacher (
  Teacher_id serial PRIMARY KEY,
  Driving_school_id integer references Driving_school(Driving_school_id) NOT NULL,
  Contact_data_id integer references Contact_data(Contact_data_id) NOT NULL UNIQUE,
  Name varchar(32) NOT NULL,
  Surname varchar(32) NOT NULL,
  Seniority interval NOT NULL
);