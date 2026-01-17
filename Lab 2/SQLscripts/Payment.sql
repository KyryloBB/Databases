CREATE TYPE payment_method AS ENUM ('cash', 'credit_card', 'GooglePay');
CREATE TYPE payment_status AS ENUM ('successful', 'failed');

CREATE TABLE Payment (
  Payment_id serial PRIMARY KEY,
  Membership_id integer references Membership(Membership_id) NOT NULL UNIQUE,
  Student_id integer references Student(Student_id) NOT NULL,
  Amount integer NOT NULL CHECK (Amount > 0),
  Method payment_method NOT NULL,
  Status payment_status NOT NULL,
  Date timestamp NOT NULL 
);