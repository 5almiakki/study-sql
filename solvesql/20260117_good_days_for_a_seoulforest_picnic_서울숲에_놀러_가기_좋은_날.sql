SELECT measured_at AS good_day
FROM measurements
WHERE YEAR(measured_at) = 2022 AND MONTH(measured_at) = 12 AND pm2_5 <= 9
ORDER BY good_day ASC;
