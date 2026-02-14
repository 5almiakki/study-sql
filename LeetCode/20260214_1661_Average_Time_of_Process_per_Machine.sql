SELECT
    machine_id,
    ROUND(AVG(end.`timestamp` - start.`timestamp`), 3) AS processing_time
FROM (
    SELECT machine_id, process_id, `timestamp`
    FROM Activity
    WHERE activity_type = 'start'
) AS start
JOIN (
    SELECT machine_id, process_id, `timestamp`
    FROM Activity
    WHERE activity_type = 'end'
) AS end
USING (machine_id, process_id)
GROUP BY machine_id;
