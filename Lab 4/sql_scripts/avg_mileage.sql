--Визначаємо середній пробіг автомобілей з різними КПП

SELECT gearbox, AVG(mileage)
FROM Car
GROUP BY gearbox