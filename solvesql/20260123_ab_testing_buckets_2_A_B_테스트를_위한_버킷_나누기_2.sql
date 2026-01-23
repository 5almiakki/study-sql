SELECT
  bucket,
  COUNT(*) AS user_count,
  ROUND(AVG(order_count), 2) AS avg_orders,
  ROUND(AVG(s), 2) AS avg_revenue
FROM (
  SELECT
    CASE customer_id % 10
      WHEN 0 THEN 'A'
      ELSE 'B'
    END AS bucket,
    customer_id,
    COUNT(*) AS order_count,
    SUM(total_price) AS s
  FROM transactions
  WHERE NOT is_returned
  GROUP BY customer_id
) AS t
GROUP BY bucket;
