SELECT c.name AS Customers
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.id = o.customerId
GROUP BY c.id
HAVING COUNT(o.id) = 0;
