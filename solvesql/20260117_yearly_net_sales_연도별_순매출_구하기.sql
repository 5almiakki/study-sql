SELECT
  YEAR(purchased_at) AS year,
  SUM(total_price - discount_amount) AS net_sales
FROM transactions
WHERE NOT is_returned
GROUP BY YEAR(purchased_at)
ORDER BY year ASC;
