WITH
  t1 AS (
    SELECT
      user_pseudo_id, event_timestamp_kst,
      LAG(event_timestamp_kst) OVER (ORDER BY event_timestamp_kst) AS lag_event_timestamp_kst
    FROM ga
    WHERE user_pseudo_id = 'S3WDQCqLpK'
  ),
  t2 AS (
    SELECT
      *,
      CASE
        WHEN lag_event_timestamp_kst IS NULL THEN 1
        WHEN TIMESTAMPDIFF(HOUR, event_timestamp_kst, lag_event_timestamp_kst) <= -1 THEN 1
        ELSE 0
      END AS session
    FROM t1
  ),
  t3 AS (
    SELECT
      *,
      SUM(session) OVER (ORDER BY event_timestamp_kst) AS session_id
    FROM t2
  )
SELECT
  user_pseudo_id,
  MIN(event_timestamp_kst) AS session_start,
  MAX(event_timestamp_kst) AS session_end
FROM t3
GROUP BY user_pseudo_id, session_id
ORDER BY session_start;
