SELECT
  a.cls AS classification,
  IFNULL(a1.cnt, 0) AS `2014`,
  IFNULL(a2.cnt, 0) AS `2015`,
  IFNULL(a3.cnt, 0) AS `2016`
FROM (
  SELECT DISTINCT(classification) AS cls
  FROM artworks
) AS a
LEFT JOIN (
  SELECT
    classification AS cls,
    COUNT(*) as cnt
  FROM artworks
  WHERE YEAR(acquisition_date) = 2014
  GROUP BY classification
) AS a1
ON
  a.cls = a1.cls
LEFT JOIN (
  SELECT
    classification AS cls,
    COUNT(*) as cnt
  FROM artworks
  WHERE YEAR(acquisition_date) = 2015
  GROUP BY classification
) AS a2
ON
  a.cls = a2.cls
LEFT JOIN (
  SELECT
    classification AS cls,
    COUNT(*) as cnt
  FROM artworks
  WHERE YEAR(acquisition_date) = 2016
  GROUP BY classification
) AS a3
ON
  a.cls = a3.cls
ORDER BY classification;

SELECT
  classification,
  SUM(CASE YEAR(acquisition_date) WHEN 2014 THEN 1 ELSE 0 END) AS `2014`,
  SUM(CASE YEAR(acquisition_date) WHEN 2015 THEN 1 ELSE 0 END) AS `2015`,
  SUM(CASE YEAR(acquisition_date) WHEN 2016 THEN 1 ELSE 0 END) AS `2016`
FROM artworks
GROUP BY classification
ORDER BY classification;
