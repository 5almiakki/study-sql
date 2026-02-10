SELECT
    query_name,
    ROUND(SUM(rating / position) / COUNT(*), 2) AS quality,
    ROUND(
        100 * SUM(IF(rating < 3, 1, 0)) / COUNT(*),
        2
    ) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
