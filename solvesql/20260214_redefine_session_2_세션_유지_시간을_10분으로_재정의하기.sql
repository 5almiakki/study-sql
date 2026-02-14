WITH
  t1 AS (
    SELECT
      user_pseudo_id, event_timestamp_kst, event_name, ga_session_id,
      LAG(event_timestamp_kst) OVER (ORDER BY event_timestamp_kst) AS lag_event_timestamp_kst
    FROM ga
    WHERE user_pseudo_id = 'a8Xu9GO6TB'
  ),
  t2 AS (
    SELECT
      *,
      TIMESTAMPDIFF(MINUTE, lag_event_timestamp_kst, event_timestamp_kst) AS timestamp_diff
    FROM t1
  ),
  t3 AS (
    SELECT
      *,
      CASE
        WHEN timestamp_diff IS NULL OR timestamp_diff >= 10 THEN 1
        ELSE 0
      END AS new_session_flag
    FROM t2
  )
SELECT
  user_pseudo_id, event_timestamp_kst, event_name, ga_session_id,
  SUM(new_session_flag) OVER (ORDER BY event_timestamp_kst) AS new_session_id
FROM t3
ORDER BY event_timestamp_kst;
