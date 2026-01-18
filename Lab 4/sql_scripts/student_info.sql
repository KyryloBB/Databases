--Визначаємо адреси електронних пошт студентів та кількість грошей, яку вони витратили на послуги автошколи 

SELECT name, surname, email, amount
FROM Student s
INNER JOIN Contact_data cd ON s.contact_data_id = cd.contact_data_id
INNER JOIN Payment p ON p.student_id = s.student_id;