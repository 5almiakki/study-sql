SELECT a.name AS name
FROM (
  SELECT athlete_id, team_id
  FROM records
  WHERE
    medal IS NOT NULL
    AND game_id IN (
      SELECT id
      FROM games
      WHERE `year` >= 2000
    )
  GROUP BY athlete_id, team_id
) AS r
JOIN athletes AS a
  ON a.id = r.athlete_id
GROUP BY a.id
HAVING COUNT(*) >= 2
ORDER BY name;
