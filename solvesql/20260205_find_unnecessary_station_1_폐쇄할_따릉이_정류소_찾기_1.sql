SELECT s1.station_id AS station_id, s1.name AS name
FROM station AS s1
JOIN station AS s2
ON
  s1.station_id != s2.station_id
  AND s1.updated_at < s2.updated_at
  AND (6356 << 1)
    *
    ASIN(SQRT(
      POW(
        SIN((RADIANS(s1.lat) - RADIANS(s2.lat)) / 2),
        2
      )
      +
      COS(RADIANS(s1.lat)) * COS(RADIANS(s2.lat))
      *
      POW(
        SIN((RADIANS(s1.lng) - RADIANS(s2.lng)) / 2),
        2
      )
    ))
  <= 0.3
GROUP BY s1.station_id
HAVING COUNT(*) >= 5;
