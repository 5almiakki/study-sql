SELECT DISTINCT(athlete_id)
FROM records AS r
JOIN events AS e
ON
  r.event_id = e.id
  AND e.sport = 'Golf';
