WITH r AS (
    SELECT
        requester_id AS a,
        accepter_id AS b
    FROM RequestAccepted
    UNION
    SELECT
        accepter_id AS a,
        requester_id AS b
    FROM RequestAccepted
)
SELECT
    a AS id,
    COUNT(*) AS num
FROM r
GROUP BY a
ORDER BY COUNT(*) DESC
LIMIT 1;
