--Визначаємо інструкторів, чий стаж не менший за стаж інших інструкторів у тій самій автошколі
--Запит створено з використанням ШІ

SELECT i.name, i.surname, i.seniority
FROM Instructor i
WHERE i.seniority >= (
  SELECT AVG(i2.seniority)
  FROM Instructor i2
  WHERE i2.driving_school_id = i.driving_school_id
);