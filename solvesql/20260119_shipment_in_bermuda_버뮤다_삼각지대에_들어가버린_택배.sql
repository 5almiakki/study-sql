SELECT
  DATE(order_delivered_carrier_date) as delivered_carrier_date,
  COUNT(*) AS orders
FROM olist_orders_dataset
WHERE
  YEAR(order_delivered_carrier_date) = 2017
  AND MONTH(order_delivered_carrier_date) = 1
  AND order_delivered_customer_date IS NULL
GROUP BY DATE(order_delivered_carrier_date)
ORDER BY delivered_carrier_date ASC;
