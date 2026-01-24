SELECT
  DATE(o.order_purchase_timestamp) AS dt,
  COUNT(DISTINCT(customer_id)) AS pu,
  ROUND(SUM(payment_value), 2) AS revenue_daily,
  ROUND(SUM(payment_value) / COUNT(DISTINCT(customer_id)), 2) AS arppu
FROM (
  SELECT *
  FROM olist_orders_dataset
  WHERE order_purchase_timestamp >= '2018-01-01'
) AS o
JOIN olist_order_payments_dataset AS p
ON o.order_id = p.order_id
GROUP BY DATE(o.order_purchase_timestamp);
