WITH t AS (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
)
SELECT e.name AS name
FROM t
JOIN Employee AS e
    ON t.managerId = e.id;
