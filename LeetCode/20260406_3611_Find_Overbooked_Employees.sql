SELECT
    employees.*,
    COUNT(*) AS meeting_heavy_weeks
FROM (
    SELECT employee_id
    FROM meetings
    GROUP BY employee_id, YEAR(meeting_date), WEEK(meeting_date, 1)
    HAVING SUM(duration_hours) > 20
) AS t
JOIN employees USING (employee_id)
GROUP BY employee_id
HAVING COUNT(*) >= 2
ORDER BY meeting_heavy_weeks DESC, employee_name ASC;
