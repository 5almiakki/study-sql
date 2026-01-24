SELECT
  mentee.employee_id AS mentee_id,
  mentee.name AS mentee_name,
  mentor.employee_id AS mentor_id,
  mentor.name AS mentor_name
FROM (
  SELECT *
  FROM employees
  WHERE join_date BETWEEN SUBDATE('2021-12-31', INTERVAL 3 MONTH) AND '2021-12-31'
) AS mentee
JOIN (
  SELECT *
  FROM employees
  WHERE join_date <= SUBDATE('2021-12-31', INTERVAL 2 YEAR)
) AS mentor
ON mentee.department != mentor.department
ORDER BY mentee_id ASC, mentor_id ASC;
