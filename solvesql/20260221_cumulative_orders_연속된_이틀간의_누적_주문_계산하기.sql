WITH
  tx AS (
    SELECT DATE(purchased_at) AS order_date, COUNT(*) AS cnt
    FROM transactions
    WHERE is_online_order AND YEAR(purchased_at) = 2023
    GROUP BY DATE(purchased_at)
  ),
  yesterday_tx AS (
    SELECT ADDDATE(order_date, 1) AS order_date, cnt
    FROM tx
    GROUP BY order_date
  )
SELECT
  order_date,
  CASE DAYOFWEEK(order_date)
    WHEN 1 THEN "Sunday"
    WHEN 2 THEN "Monday"
    WHEN 3 THEN "Tuesday"
    WHEN 4 THEN "Wednesday"
    WHEN 5 THEN "Thursday"
    WHEN 6 THEN "Friday"
    WHEN 7 THEN "Saturday"
  END AS `weekday`,
  tx.cnt AS num_orders_today,
  IFNULL(tx.cnt + yesterday_tx.cnt, tx.cnt) AS num_orders_from_yesterday
FROM tx
LEFT JOIN yesterday_tx USING (order_date)
ORDER BY order_date;
