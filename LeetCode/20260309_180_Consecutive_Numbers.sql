WITH
    t1 AS (
        SELECT
            *,
            CASE LAG(num) OVER (ORDER BY id)
                WHEN num THEN 0
                ELSE 1
            END AS group_num_delta
        FROM Logs
    ),
    t2 AS (
        SELECT
            *,
            SUM(group_num_delta) OVER (ORDER BY id ASC) AS group_num
        FROM t1
    )
SELECT
    DISTINCT(num) AS ConsecutiveNums
FROM (
    SELECT num, group_num
    FROM t2
    GROUP BY num, group_num
    HAVING COUNT(*) >= 3
) AS t;
