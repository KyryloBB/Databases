--Визначаємо інформацію про студентів та їх членства

SELECT name, surname, plan, status
FROM Student s
LEFT JOIN Membership m ON s.student_id = m.student_id