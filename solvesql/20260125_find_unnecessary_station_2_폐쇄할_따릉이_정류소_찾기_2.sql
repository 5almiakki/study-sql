SELECT
  station_id,
  name,
  `local`,
  ROUND(100 * u2019 / u2018, 2) AS usage_pct
FROM (
  SELECT
    station_id,
    SUM(CASE YEAR(t) WHEN 2018 THEN 1 ELSE 0 END) AS u2018,
    SUM(CASE YEAR(t) WHEN 2019 THEN 1 ELSE 0 END) AS u2019
  FROM (
    SELECT
      rent_station_id AS station_id,
      rent_at AS t
    FROM rental_history
    WHERE SUBSTR(rent_at, 1, 7) IN ('2018-10', '2019-10')
    UNION ALL
    SELECT
      return_station_id AS station_id,
      return_at AS t
    FROM rental_history
    WHERE SUBSTR(return_at, 1, 7) IN ('2018-10', '2019-10')
  ) AS h
  GROUP BY station_id
  HAVING
    SUM(CASE YEAR(t) WHEN 2018 THEN 1 ELSE 0 END) > 0
    AND SUM(CASE YEAR(t) WHEN 2019 THEN 1 ELSE 0 END) > 0
) AS h
JOIN station USING(station_id)
WHERE
  ROUND(100 * u2019 / u2018, 2) <= 50;
