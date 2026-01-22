SELECT m3.measured_at AS date_alert
FROM measurements AS m1
JOIN measurements AS m2
ON
  DATEDIFF(m2.measured_at, m1.measured_at) = 1
  AND m1.pm10 < m2.pm10
JOIN measurements AS m3
ON
  DATEDIFF(m3.measured_at, m2.measured_at) = 1
  AND m2.pm10 < m3.pm10
  AND m3.pm10 >= 30
ORDER BY date_alert ASC;
