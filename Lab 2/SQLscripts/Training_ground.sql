CREATE TABLE Training_ground (
  Training_ground_id serial PRIMARY KEY,
  Driving_school_id integer references Driving_school(Driving_school_id) NOT NULL UNIQUE,
  Address varchar(60) NOT NULL UNIQUE
);