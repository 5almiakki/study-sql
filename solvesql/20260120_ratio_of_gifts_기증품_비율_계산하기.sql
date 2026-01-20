SELECT ROUND(100 * g.c / t.c, 3) AS ratio
FROM (
  SELECT COUNT(*) AS c
  FROM artworks
  WHERE LOWER(credit) LIKE '%gift%'
) AS g
JOIN (
  SELECT COUNT(*) AS c
  FROM artworks
) AS t
ON true;
