SELECT
  g1.game_id AS game_id,
  g1.name AS name,
  CASE
    WHEN g1.critic_score IS NULL THEN g2.critic_score
    ELSE g1.critic_score
  END AS critic_score,
  CASE
    WHEN g1.critic_count IS NULL THEN g2.critic_count
    ELSE g1.critic_count
  END AS critic_count,
  CASE
    WHEN g1.user_score IS NULL THEN g2.user_score
    ELSE g1.user_score
  END AS user_score,
  CASE
    WHEN g1.user_count IS NULL THEN g2.user_count
    ELSE g1.user_count
  END AS user_count
FROM games AS g1
JOIN (
  SELECT
    genre_id,
    ROUND(AVG(critic_score), 3) AS critic_score,
    CEIL(AVG(critic_count)) AS critic_count,
    ROUND(AVG(user_score), 3) AS user_score,
    CEIL(AVG(user_count)) AS user_count
  FROM games
  GROUP BY genre_id
) AS g2
ON
  g1.genre_id = g2.genre_id
WHERE
  g1.year >= 2015
  AND (
    g1.critic_score IS NULL
    OR g1.critic_count IS NULL
    OR g1.user_score IS NULL
    OR g1.user_count IS NULL
  );
