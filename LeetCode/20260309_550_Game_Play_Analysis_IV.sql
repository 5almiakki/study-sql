WITH t AS (
    SELECT
        *,
        MIN(event_date) OVER (PARTITION BY player_id) AS first_date
    FROM Activity
)
SELECT
    ROUND((
        SELECT COUNT(DISTINCT(player_id))
        FROM t
        WHERE event_date = DATE_ADD(first_date, INTERVAL 1 DAY)
    ) / (
        SELECT COUNT(DISTINCT(player_id))
        FROM Activity
    ), 2) AS fraction
