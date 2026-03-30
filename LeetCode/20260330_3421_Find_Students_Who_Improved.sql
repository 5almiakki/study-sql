SELECT *
FROM (
    SELECT
        student_id, subject,
        SUM(IF(exam_date = first_date, score, 0)) AS first_score,
        SUM(IF(exam_date = latest_date, score, 0)) AS latest_score
    FROM (
        SELECT
            *,
            MIN(exam_date) OVER (PARTITION BY student_id, subject) AS first_date,
            MAX(exam_date) OVER (PARTITION BY student_id, subject) AS latest_date
        FROM Scores
    ) AS t
    GROUP BY student_id, subject
) AS t
WHERE first_score < latest_score
ORDER BY student_id ASC, subject ASC;
