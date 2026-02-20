WITH
  e AS (
    SELECT user_a_id AS user_id, user_b_id AS friend_id FROM edges
    UNION ALL
    SELECT user_b_id AS user_id, user_a_id AS friend_id FROM edges
  ),
  user_friends AS (
    SELECT user_id, COUNT(*) AS friends
    FROM e
    GROUP BY user_id
  ),
  candidate_friends AS (
    SELECT
      e.user_id AS user_id,
      user_friends.friends AS friends,
      e.friend_id AS friend_id,
      friend_friends.friends AS friends_of_friends
    FROM e
    JOIN user_friends AS user_friends
      ON e.user_id = user_friends.user_id
    JOIN user_friends AS friend_friends
      ON e.friend_id = friend_friends.user_id
  )
SELECT
  user_id, friends,
  SUM(friends_of_friends) AS friends_of_friends,
  ROUND(SUM(friends_of_friends) / friends, 2) AS ratio
FROM candidate_friends
WHERE friends >= 100
GROUP BY user_id
ORDER BY SUM(friends_of_friends) / friends DESC
LIMIT 5;
