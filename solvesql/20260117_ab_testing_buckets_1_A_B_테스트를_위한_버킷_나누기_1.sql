SELECT
  customer_id,
  CASE customer_id % 10
      WHEN 0 THEN 'A'
      ELSE 'B'
    END AS 'bucket'
FROM transactions
GROUP BY customer_id
ORDER BY customer_id;
