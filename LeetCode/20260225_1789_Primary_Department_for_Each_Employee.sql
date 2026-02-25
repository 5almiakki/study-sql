WITH t AS (
    SELECT
        employee_id, department_id,
        (
            primary_flag = 'Y'
            OR COUNT(*) OVER (PARTITION BY employee_id) = 1
        ) AS is_primary
    FROM Employee
)
SELECT employee_id, department_id
FROM t
WHERE is_primary;
