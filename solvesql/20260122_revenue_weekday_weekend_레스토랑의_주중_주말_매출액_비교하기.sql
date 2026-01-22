SELECT `week`, SUM(total_bill) AS sales
FROM (
  SELECT
    total_bill,
    CASE
      WHEN `day` IN ('Sat', 'Sun') THEN 'weekend'
      ELSE 'weekday'
    END AS `week`
  FROM tips
) AS t
GROUP BY `week`
ORDER BY sales DESC;
