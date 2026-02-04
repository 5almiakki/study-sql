SELECT
  category, sub_category,
  COUNT(DISTINCT order_id) AS cnt_orders
FROM records
WHERE (customer_id, order_date) IN (
  SELECT customer_id, first_order_date AS order_date
  FROM customer_stats
  GROUP BY customer_id, first_order_date
)
GROUP BY category, sub_category
ORDER BY cnt_orders DESC;
