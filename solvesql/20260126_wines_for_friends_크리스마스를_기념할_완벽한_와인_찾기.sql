WITH white_wines AS (
  SELECT *
  FROM wines
  WHERE color = 'white'
)
SELECT *
FROM wines
WHERE
  color = 'white'
  AND quality >= 7
  AND density > (
    SELECT AVG(density)
    FROM wines
  )
  AND residual_sugar > (
    SELECT AVG(residual_sugar)
    FROM wines
  )
  AND pH < (
    SELECT AVG(pH)
    FROM white_wines
  )
  AND citric_acid > (
    SELECT AVG(citric_acid)
    FROM white_wines
  );
