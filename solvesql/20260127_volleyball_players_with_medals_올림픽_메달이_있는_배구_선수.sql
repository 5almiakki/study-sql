SELECT
  athletes.id AS id,
  athletes.name AS name,
  GROUP_CONCAT(DISTINCT(medal) SEPARATOR ',') AS medals
FROM (
  SELECT *
  FROM records
  WHERE medal IS NOT NULL
) AS r
JOIN events
  ON
    r.event_id = events.id
    AND events.event = 'Volleyball Women''s Volleyball'
JOIN teams
  ON
    r.team_id = teams.id
    AND teams.team = 'KOR'
JOIN athletes
  ON
    r.athlete_id = athletes.id
GROUP BY athletes.id;
