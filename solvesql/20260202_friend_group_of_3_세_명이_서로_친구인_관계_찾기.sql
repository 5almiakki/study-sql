WITH e AS (
  SELECT user_a_id AS a, user_b_id AS b
  FROM edges
  WHERE user_a_id < user_b_id
  UNION
  SELECT user_b_id AS a, user_a_id AS b
  FROM edges
  WHERE user_b_id < user_a_id
)
SELECT
  e1.a AS user_a_id,
  e1.b AS user_b_id,
  e2.b AS user_c_id
FROM e AS e1
JOIN e AS e2
ON
  e1.b = e2.a
  AND 3820 IN (e1.a, e1.b, e2.b)
  AND (e1.a, e2.b) IN (
    SELECT *
    FROM e
  );
