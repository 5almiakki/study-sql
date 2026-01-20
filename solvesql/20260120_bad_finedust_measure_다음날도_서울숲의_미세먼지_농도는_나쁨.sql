SELECT
  m1.measured_at AS today,
  m2.measured_at AS next_day,
  m1.pm10 AS pm10,
  m2.pm10 AS next_pm10
FROM measurements AS m1
JOIN measurements AS m2
ON
  ADDDATE(m1.measured_at, 1) = m2.measured_at
  AND m2.pm10 > m1.pm10;
