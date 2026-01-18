--Визначаємо всіх студентів, які проходять практичне навчання в автошколі, та всіх інструкторів, які працюють в тій автошколі

SELECT s.name, s.surname, i.name, i.surname
FROM Student s
INNER JOIN Membership m ON s.student_id = m.student_id
INNER JOIN Instructor i ON i.driving_school_id = s.driving_school_id
WHERE m.plan = 'practice' AND m.status = 'active';