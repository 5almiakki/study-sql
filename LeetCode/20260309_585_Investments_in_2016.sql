SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance AS i1
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Insurance AS i2
        WHERE i1.pid != i2.pid AND i1.lat = i2.lat AND i1.lon = i2.lon
    )
    AND EXISTS (
        SELECT 1
        FROM Insurance AS i2
        WHERE i1.pid != i2.pid AND i1.tiv_2015 = i2.tiv_2015
    );
