CREATE TYPE membership_plan AS ENUM ('theory', 'practice');
CREATE TYPE membership_status AS ENUM ('active', 'terminated', 'payment failed');

CREATE TABLE Membership (
  Membership_id serial PRIMARY KEY,
  Student_id integer references Student(Student_id) NOT NULL,
  Driving_school_id integer references Driving_school(Driving_school_id) NOT NULL,
  Start_date date NOT NULL,
  End_date date NOT NULL,
  Duration interval NOT NULL,
  Plan membership_plan NOT NULL,
  Status membership_status NOT NULL
);