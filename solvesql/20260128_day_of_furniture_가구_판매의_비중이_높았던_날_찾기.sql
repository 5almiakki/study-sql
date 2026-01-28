SELECT
  order_date,
  SUM(CASE furniture_cnt WHEN 0 THEN 0 ELSE 1 END) AS furniture,
  ROUND(100 * SUM(CASE furniture_cnt WHEN 0 THEN 0 ELSE 1 END) / COUNT(*), 2) AS furniture_pct
FROM (
  SELECT
    order_date, order_id,
    SUM(CASE category WHEN 'Furniture' THEN 1 ELSE 0 END) AS furniture_cnt
  FROM records
  GROUP BY order_date, order_id
) AS r
GROUP BY order_date
HAVING
  COUNT(*) >= 10
  AND 100 * SUM(CASE furniture_cnt WHEN 0 THEN 0 ELSE 1 END) / COUNT(*) >= 40
ORDER BY furniture_pct DESC, order_date ASC;
