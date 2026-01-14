SELECT ROUND(AVG(`sum`), 2) AS avg_sales
FROM (
  SELECT SUM(total_bill) AS sum
  FROM tips
  GROUP BY day
) AS s;
