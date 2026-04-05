WITH
    first_half AS (
        SELECT driver_id, AVG(distance_km / fuel_consumed) AS first_half_avg
        FROM trips
        WHERE MONTH(trip_date) BETWEEN 1 AND 6
        GROUP BY driver_id
    ),
    second_half AS (
        SELECT driver_id, AVG(distance_km / fuel_consumed) AS second_half_avg
        FROM trips
        WHERE MONTH(trip_date) BETWEEN 7 AND 12
        GROUP BY driver_id
    )
SELECT
    driver_id, driver_name,
    ROUND(first_half_avg, 2) AS first_half_avg,
    ROUND(second_half_avg, 2) AS second_half_avg,
    ROUND(second_half_avg - first_half_avg, 2) AS efficiency_improvement
FROM first_half
JOIN second_half USING (driver_id)
JOIN drivers USING (driver_id)
WHERE second_half_avg - first_half_avg > 0
ORDER BY efficiency_improvement DESC, driver_name ASC;
