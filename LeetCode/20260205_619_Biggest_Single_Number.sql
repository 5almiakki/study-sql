SELECT
    CASE COUNT(*)
        WHEN 0 THEN NULL
        ELSE num
    END AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
    ORDER BY num DESC
    LIMIT 1
) AS t;

SELECT MAX(num) AS num
FROM (
    SELECT MAX(num) AS num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS t;
