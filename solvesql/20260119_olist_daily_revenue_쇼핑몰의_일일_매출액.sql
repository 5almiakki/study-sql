SELECT
  DATE(order_purchase_timestamp) AS dt,
  ROUND(SUM(payment_value), 2) AS revenue_daily
FROM olist_orders_dataset AS o
JOIN olist_order_payments_dataset AS p
ON o.order_id = p.order_id
WHERE DATE(order_purchase_timestamp) >= '2018-01-01'
GROUP BY DATE(order_purchase_timestamp)
ORDER BY dt ASC;
