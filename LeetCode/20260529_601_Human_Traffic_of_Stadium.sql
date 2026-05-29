WITH
    t1 AS (
        SELECT
            *,
            LAG(id) OVER () AS lag_id
        FROM Stadium
        WHERE people >= 100
    ),
    t2 AS (
        SELECT
            *,
            IF(lag_id IS NULL OR id - lag_id > 1, 1, 0) AS group_flag
        FROM t1
    ),
    t3 AS (
        SELECT
            *,
            SUM(group_flag) OVER (ORDER BY id) AS group_id
        FROM t2
    ),
    t4 AS (
        SELECT
            *,
            COUNT(*) OVER (PARTITION BY group_id) AS cnt
            FROM t3
    )
SELECT id, visit_date, people
FROM t4
WHERE cnt >= 3
ORDER BY visit_date;
