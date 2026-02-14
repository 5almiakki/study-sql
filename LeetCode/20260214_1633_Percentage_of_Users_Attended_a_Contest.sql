SELECT
    contest_id,
    ROUND(100 * COUNT(*) / c, 2) AS percentage
FROM (
    SELECT COUNT(*) AS c
    FROM Users
) AS u
JOIN Register ON true
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;
