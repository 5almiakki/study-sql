WITH
  f1 AS (
    SELECT user_id, COUNT(user_b_id) AS cnt
    FROM users AS u
    LEFT JOIN edges AS e
    ON u.user_id = user_a_id
    GROUP BY user_id
  ),
  f2 AS (
    SELECT user_id, COUNT(user_a_id) AS cnt
    FROM users AS u
    LEFT JOIN edges AS e
    ON u.user_id = user_b_id
    GROUP BY user_id
  )
SELECT
  user_id,
  f1.cnt + f2.cnt AS num_friends
FROM f1
JOIN f2 USING (user_id)
ORDER BY num_friends DESC, user_id ASC;
