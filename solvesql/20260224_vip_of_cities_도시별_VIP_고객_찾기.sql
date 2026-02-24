WITH
  t1 AS (
    SELECT
      customer_id, city_id,
      SUM(total_price - discount_amount) AS total_spent
    FROM transactions
    WHERE !is_returned
    GROUP BY customer_id, city_id
  ),
  t2 AS (
    SELECT
      city_id, MAX(total_spent) AS total_spent
    FROM t1
    GROUP BY city_id
  )
SELECT *
FROM t1
JOIN t2 USING (city_id, total_spent);
