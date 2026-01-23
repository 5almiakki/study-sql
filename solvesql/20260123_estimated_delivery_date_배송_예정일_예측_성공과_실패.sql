SELECT
  DATE(order_purchase_timestamp) AS purchase_date,
  SUM(
    CASE
      WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1
      ELSE 0
    END
  ) AS success,
  SUM(
    CASE
      WHEN order_delivered_customer_date > order_estimated_delivery_date > 0 THEN 1
      ELSE 0
    END
  ) AS fail
FROM olist_orders_dataset
WHERE
  YEAR(order_purchase_timestamp) = 2017 AND MONTH(order_purchase_timestamp) = 1
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY DATE(order_purchase_timestamp)
ORDER BY purchase_date;
