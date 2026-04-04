WITH
    positive_tests AS (
        SELECT *
        FROM covid_tests
        WHERE result = 'Positive'
    ),
    negative_tests AS (
        SELECT *
        FROM covid_tests
        WHERE result = 'Negative'
    )
SELECT
    patients.*,
    DATEDIFF(MIN(n.test_date), MIN(p.test_date)) AS recovery_time
FROM patients
JOIN positive_tests AS p
    USING (patient_id)
JOIN negative_tests AS n
    ON
        p.patient_id = n.patient_id
        AND DATEDIFF(n.test_date, p.test_date) > 0
GROUP BY patient_id
ORDER BY recovery_time ASC, patient_name ASC;
