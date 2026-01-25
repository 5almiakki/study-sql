SELECT name
FROM (
  SELECT
    g.name AS name,
    CASE
      WHEN p.name IN ('PS3', 'PS4', 'PSP', 'PSV') THEN 0
      WHEN p.name IN ('Wii', 'WiiU', 'DS', '3DS') THEN 1
      WHEN p.name IN ('X360', 'XONE') THEN 2
    END AS pg
  FROM games AS g
  LEFT JOIN platforms AS p
  ON g.platform_id = p.platform_id
  WHERE
    `year` >= 2012
  GROUP BY g.name, pg
) AS g
WHERE pg IS NOT NULL
GROUP BY name
HAVING COUNT(*) >= 2;
