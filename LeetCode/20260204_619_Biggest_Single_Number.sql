SELECT
    *,
    CASE
        WHEN x > y AND x > z THEN IF(x < y + z, 'Yes', 'No')
        WHEN y > x AND y > Z THEN IF(y < x + z, 'Yes', 'No')
        ELSE IF (z < x + y, 'Yes', 'No')
    END AS triangle
FROM Triangle;
