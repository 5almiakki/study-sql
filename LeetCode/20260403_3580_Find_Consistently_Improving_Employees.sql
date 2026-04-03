WITH
    t1 AS (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn,
            LEAD(rating) OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS lead_rating
        FROM performance_reviews
    ),
    t2 AS (
        SELECT
            *,
            CASE
                WHEN rn = 3 THEN 1
                WHEN rating - lead_rating > 0 THEN 1
                ELSE 0
            END AS flag
        FROM t1
        WHERE rn <= 3
    ),
    t3 AS (
        SELECT employee_id
        FROM t2
        GROUP BY employee_id
        HAVING SUM(flag) = 3
    )
SELECT
    employee_id, name,
    MAX(rating) - MIN(rating) AS improvement_score
FROM t3
JOIN employees USING (employee_id)
JOIN t2 USING (employee_id)
GROUP BY employee_id
ORDER BY improvement_score DESC, name ASC;
