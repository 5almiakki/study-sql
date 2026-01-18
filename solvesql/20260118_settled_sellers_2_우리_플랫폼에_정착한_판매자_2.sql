SELECT seller_id, COUNT(*) AS orders
FROM (
  SELECT order_id, seller_id
  FROM olist_order_items_dataset
  WHERE price >= 50
  GROUP BY order_id, seller_id
) AS o
GROUP BY seller_id
HAVING COUNT(*) >= 100
ORDER BY orders DESC;
