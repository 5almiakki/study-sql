SELECT
  SUBSTR(order_date, 1, 7) AS order_month,
  SUM(
    CASE SUBSTR(o.order_id, 1, 1)
      WHEN 'C' THEN 0
      ELSE price * quantity
    END
  ) AS ordered_amount,
  SUM(
    CASE SUBSTR(o.order_id, 1, 1)
      WHEN 'C' THEN price * quantity
      ELSE 0
    END
  ) AS canceled_amount,
  SUM(price * quantity) AS total_amount
FROM orders AS o
JOIN order_items
  ON o.order_id = order_items.order_id
GROUP BY SUBSTR(order_date, 1, 7)
ORDER BY order_month ASC;
