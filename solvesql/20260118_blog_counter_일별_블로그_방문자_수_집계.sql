SELECT dt, COUNT(*) AS users
FROM (
  SELECT DATE(event_timestamp_kst) AS dt, user_first_touch_timestamp_kst
  FROM ga
  WHERE DATE(event_timestamp_kst) BETWEEN '2021-08-02' AND '2021-08-09'
  GROUP BY DATE(event_timestamp_kst), user_first_touch_timestamp_kst
) AS t
GROUP BY dt
ORDER BY dt ASC;
