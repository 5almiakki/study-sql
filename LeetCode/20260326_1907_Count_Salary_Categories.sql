WITH category AS (
    SELECT "Low Salary" AS category, 0 AS category_id
    UNION ALL
    SELECT "Average Salary" AS category, 1 AS category_id
    UNION ALL
    SELECT "High Salary" AS category, 2 AS category_id
)
SELECT
    category,
    COUNT(account_id) AS accounts_count
FROM category
LEFT JOIN (
    SELECT
        *,
        CASE
            WHEN income < 20000 THEN 0
            WHEN income > 50000 THEN 2
            ELSE 1
        END AS category_id
    FROM Accounts
) AS t
USING (category_id)
GROUP BY category_id;

SELECT
    "Low Salary" AS category,
    SUM(IF(income < 20000, 1, 0)) AS accounts_count
FROM Accounts
UNION ALL
SELECT
    "Average Salary" AS category,
    SUM(IF(income BETWEEN 20000 AND 50000, 1, 0)) AS accounts_count
FROM Accounts
UNION ALL
SELECT
    "High Salary" AS category,
    SUM(IF(income > 50000, 1, 0)) AS accounts_count
FROM Accounts;

