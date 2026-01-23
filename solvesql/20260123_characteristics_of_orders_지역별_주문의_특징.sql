SELECT
  region AS Region,
  COUNT(DISTINCT(CASE category WHEN 'Furniture' THEN order_id END)) AS Furniture,
  COUNT(DISTINCT(CASE category WHEN 'Office Supplies' THEN order_id END)) AS `Office Supplies`,
  COUNT(DISTINCT(CASE category WHEN 'Technology' THEN order_id END)) AS Technology
FROM records
GROUP BY region
ORDER BY Region ASC;
