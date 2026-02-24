SELECT
    Managers.employee_id AS employee_id,
    Managers.name AS name,
    COUNT(*) AS reports_count,
    ROUND(AVG(Employees.age)) AS average_age
FROM Employees
JOIN Employees AS Managers
    ON Employees.reports_to = Managers.employee_id
WHERE Employees.reports_to IS NOT NULL
GROUP BY Employees.reports_to
ORDER BY employee_id;
