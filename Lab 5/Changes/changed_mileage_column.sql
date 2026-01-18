ALTER TABLE Car
ALTER COLUMN mileage TYPE varchar(10)
USING mileage::varchar;

UPDATE Car
SET mileage = mileage || ' km'