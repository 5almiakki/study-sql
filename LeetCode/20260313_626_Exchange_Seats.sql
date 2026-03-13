WITH s AS (
    SELECT
        *,
        LAG(student) OVER (ORDER BY id) AS lag_student,
        LEAD(student) OVER (ORDER BY id) AS lead_student
    FROM Seat
)
SELECT
    id,
    CASE
        WHEN id % 2 = 0 THEN lag_student
        ELSE IFNULL(lead_student, student)
    END AS student
FROM s;
