CREATE TABLE Car (
  Car_id serial PRIMARY KEY,
  Driving_school_id integer references Driving_school(Driving_school_id) NOT NULL,
  Model varchar(60) NOT NULL,
  Gearbox gearbox NOT NULL,
  Year_of_production integer NOT NULL CHECK (Year_of_production >= 2015 AND Year_of_production <= 2026),
  Mileage integer NOT NULL,
  License_plate char(8) NOT NULL UNIQUE
);