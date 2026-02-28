SELECT employee_id
FROM (
    SELECT employee_id FROM Employees
    UNION
    SELECT employee_id FROM Salaries
) AS e
LEFT JOIN Employees USING (employee_id)
LEFT JOIN Salaries USING (employee_id)
WHERE name IS NULL OR salary IS NULL
ORDER BY employee_id ASC;
