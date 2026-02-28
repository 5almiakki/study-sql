SELECT employee_id
FROM Employees
WHERE
    salary < 30000
    AND manager_id IS NOT NULL
    AND manager_id NOT IN (SELECT DISTINCT(employee_id) FROM Employees)
ORDER BY employee_id ASC;

SELECT employee_id
FROM Employees AS e
WHERE
    salary < 30000
    AND e.manager_id IS NOT NULL
    AND NOT EXISTS (
    SELECT 1
    FROM Employees AS m
    WHERE e.manager_id = m.employee_id
)
ORDER BY employee_id ASC;
