SELECT name
FROM SalesPerson AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS o
    JOIN Company AS c USING (com_id)
    WHERE c.name = 'RED' AND s.sales_id = o.sales_id
);

SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    SELECT o.sales_id AS sales_id
    FROM Orders AS o
    JOIN Company AS c USING (com_id)
    WHERE c.name = 'RED'
);
