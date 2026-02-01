SELECT tw.id AS id
FROM Weather AS yw
JOIN Weather AS tw
ON
    ADDDATE(yw.recordDate, INTERVAL 1 DAY) = tw.recordDate
    AND yw.temperature < tw.temperature;
