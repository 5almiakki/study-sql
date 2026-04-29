SELECT
    Department.name AS Department,
    t.name AS Employee,
    salary AS Salary
FROM (
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS salary_rank
    FROM Employee
) AS t
JOIN Department
    ON departmentId = Department.id
WHERE salary_rank <= 3;
