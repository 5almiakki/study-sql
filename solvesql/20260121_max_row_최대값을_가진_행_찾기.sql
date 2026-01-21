SELECT id
FROM points
WHERE x IN (
  SELECT MAX(x)
  FROM points
) OR y IN (
  SELECT MAX(y)
  FROM points
)
ORDER BY id ASC;
