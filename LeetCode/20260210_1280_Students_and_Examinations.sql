SELECT student_id, student_name, subject_name, IFNULL(cnt, 0) AS attended_exams
FROM Students
CROSS JOIN Subjects
LEFT JOIN (
    SELECT *, COUNT(*) AS cnt
    FROM Examinations
    GROUP BY student_id, subject_name
) AS e
USING (student_id, subject_name)
ORDER BY student_id, subject_name;
