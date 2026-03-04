SELECT
    CASE COUNT(*)
        WHEN 0 THEN NULL
        ELSE salary
    END AS SecondHighestSalary
FROM (
    SELECT
        salary,
        RANK() OVER (ORDER BY salary DESC) AS dr
    FROM (SELECT DISTINCT(salary) FROM Employee) AS t
) AS t
WHERE dr = 2;
