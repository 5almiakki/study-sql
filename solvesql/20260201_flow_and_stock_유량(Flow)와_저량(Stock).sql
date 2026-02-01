SELECT
  y AS `Acquisition year`,
  cnt AS `New acquisitions this year (Flow)`,
  SUM(cnt) OVER (ROWS UNBOUNDED PRECEDING) AS `Total collection size (Stock)`
FROM (
  SELECT
    YEAR(acquisition_date) AS y,
    COUNT(*) AS cnt
  FROM artworks
  WHERE YEAR(acquisition_date) IS NOT NULL
  GROUP BY YEAR(acquisition_date)
) AS a
ORDER BY y ASC;
