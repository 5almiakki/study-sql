SELECT user_a_id, user_b_id, id_sum
FROM (
  SELECT
    *,
    user_a_id + user_b_id AS id_sum,
    ROW_NUMBER() OVER(ORDER BY user_a_id + user_b_id) AS rn,
    COUNT(*) OVER() AS cnt
  FROM edges
) AS e
WHERE rn * 1000 <= cnt;
