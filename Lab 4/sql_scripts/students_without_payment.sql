--Визначаємо студентів, які ще не зробили оплату (поки таких у БД немає)
--Запит створено з використанням ШІ

SELECT s.name, s.surname
FROM Student s
WHERE NOT EXISTS (
  SELECT 1
  FROM Payment p
  WHERE p.student_id = s.student_id
);