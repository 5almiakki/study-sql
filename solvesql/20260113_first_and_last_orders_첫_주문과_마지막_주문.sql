SELECT
  MIN(DATE(order_purchase_timestamp)) as first_order_date,
  MAX(DATE(order_purchase_timestamp)) as last_order_date
FROM olist_orders_dataset;
