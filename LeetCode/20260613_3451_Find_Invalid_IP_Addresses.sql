WITH
    RECURSIVE t1 (log_id, ip, status_code, num, n) AS (
        SELECT
            *,
            REGEXP_SUBSTR(ip, '[^. ]+[.]?', 1, 1),
            2
        FROM logs
        UNION ALL
        SELECT
            log_id, ip, status_code,
            REGEXP_SUBSTR(ip, '[^. ]+[.]?', 1, n),
            n + 1
        FROM t1
        WHERE REGEXP_SUBSTR(ip, '[^. ]+[.]?', 1, n) IS NOT NULL
    ),
    t2 AS (
        SELECT
            *,
            COUNT(*) OVER (PARTITION BY log_id) AS octet_cnt
        FROM t1
    ),
    t3 AS (
        SELECT
            *,
            (
                num LIKE '0%'
                || num > 255
                || octet_cnt != 4
            ) AS invalid
        FROM t2
    )
SELECT
    ip,
    COUNT(log_id) AS invalid_count
FROM (
    SELECT *
    FROM t3
    WHERE invalid
    GROUP BY ip, log_id
) AS t
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;
