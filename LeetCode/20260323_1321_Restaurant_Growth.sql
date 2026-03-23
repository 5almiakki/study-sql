SELECT visited_on, amount, average_amount
FROM (
    SELECT
        visited_on, first_date,
        SUM(amount) OVER (ORDER BY visited_on RANGE INTERVAL 6 DAY PRECEDING) AS amount,
        ROUND(AVG(amount) OVER (ORDER BY visited_on RANGE INTERVAL 6 DAY PRECEDING), 2) AS average_amount
    FROM (
        SELECT
            visited_on,
            SUM(amount) AS amount,
            MIN(visited_on) OVER () AS first_date
        FROM Customer
        GROUP BY visited_on
    ) AS c
) AS t
WHERE DATEDIFF(visited_on, first_date) >= 6;
