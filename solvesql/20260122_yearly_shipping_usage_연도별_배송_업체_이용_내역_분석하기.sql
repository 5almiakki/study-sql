SELECT
  `year`,
  SUM(r + s) AS standard,
  SUM(e) AS express,
  SUM(o) AS overnight
FROM (
  SELECT
    CASE WHEN is_returned THEN 1 ELSE 0 END AS r,
    CASE shipping_method WHEN 'Standard' THEN 1 ELSE 0 END AS s,
    CASE shipping_method WHEN 'Express' THEN 1 ELSE 0 END AS e,
    CASE shipping_method WHEN 'Overnight' THEN 1 ELSE 0 END AS o,
    YEAR(purchased_at) AS `year`
  FROM transactions
  WHERE is_online_order
) AS t
GROUP BY `year`
ORDER BY `year` ASC;
