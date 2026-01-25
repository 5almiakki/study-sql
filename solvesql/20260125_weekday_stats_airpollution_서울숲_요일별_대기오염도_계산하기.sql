SELECT
  `weekday`,
  ROUND(AVG(no2), 4) AS no2,
  ROUND(AVG(o3), 4) AS o3,
  ROUND(AVG(co), 4) AS co,
  ROUND(AVG(so2), 4) AS so2,
  ROUND(AVG(pm10), 4) AS pm10,
  ROUND(AVG(pm2_5), 4) AS pm2_5
FROM (
  SELECT
    *,
    (DAYOFWEEK(measured_at) + 5) % 7 AS idx,
    CONCAT(
      CASE DAYOFWEEK(measured_at)
        WHEN 1 THEN '일'
        WHEN 2 THEN '월'
        WHEN 3 THEN '화'
        WHEN 4 THEN '수'
        WHEN 5 THEN '목'
        WHEN 6 THEN '금'
        ELSE '토'
      END,
      '요일'
    ) AS `weekday`
  FROM measurements
) AS m
GROUP BY `weekday`, idx
ORDER BY idx;
