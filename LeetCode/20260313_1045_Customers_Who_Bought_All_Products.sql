SELECT customer_id
FROM (
    SELECT *
    FROM Customer
    GROUP BY customer_id, product_key
) AS c
GROUP BY customer_id
HAVING COUNT(*) = (SELECT COUNT(*) FROM Product);
