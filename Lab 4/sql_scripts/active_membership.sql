--Визначаємо студентів, які мають активний абонимент
--Запит створено з використанням ШІ

SELECT s.student_id, s.name, s.surname
FROM Student s
WHERE s.student_id IN (
  SELECT m.student_id
  FROM Membership m
  WHERE m.status = 'active'
);
