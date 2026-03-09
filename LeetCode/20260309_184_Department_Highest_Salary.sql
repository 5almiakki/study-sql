WITH e AS (
    SELECT
        *,
        MAX(salary) OVER (PARTITION BY departmentId) AS max_salary
    FROM Employee
)
SELECT
    d.name AS Department,
    e.name AS Employee,
    salary AS Salary
FROM e
JOIN Department AS d
    ON e.departmentId = d.id
WHERE salary = max_salary;
