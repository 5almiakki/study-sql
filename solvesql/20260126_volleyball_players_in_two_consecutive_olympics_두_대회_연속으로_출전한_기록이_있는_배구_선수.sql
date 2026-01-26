SELECT DISTINCT a.id, a.name
FROM athletes AS a
JOIN records AS r1
  ON r1.athlete_id = a.id
JOIN records AS r2
  ON r2.athlete_id = a.id
JOIN games AS g1
  ON r1.game_id = g1.id
JOIN games AS g2
  ON
    r2.game_id = g2.id
    AND g1.`year` + 4 = g2.`year`
WHERE
  r1.team_id IN (
    SELECT id
    FROM teams
    WHERE team = 'KOR'
  )
  AND r1.event_id IN (
    SELECT id
    FROM events
    WHERE event = 'Volleyball Women''s Volleyball'
  );
