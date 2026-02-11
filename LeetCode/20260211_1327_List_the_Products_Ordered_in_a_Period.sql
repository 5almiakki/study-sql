SELECT product_name, SUM(unit) AS unit
FROM Orders
JOIN Products USING (product_id)
WHERE
    YEAR(order_date) = 2020 AND MONTH(order_date) = 2
GROUP BY product_id
HAVING SUM(unit) >= 100;
