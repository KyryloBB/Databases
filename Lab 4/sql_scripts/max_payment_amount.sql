--Визначаємо максимальну суму платежів, зроблених кожним з методів

SELECT method, MAX(amount)
FROM Payment
GROUP BY method;