SELECT c.name AS name
FROM companies AS c
JOIN games AS g
ON c.company_id = g.publisher_id
GROUP BY c.company_id
HAVING COUNT(*) >= 10;
