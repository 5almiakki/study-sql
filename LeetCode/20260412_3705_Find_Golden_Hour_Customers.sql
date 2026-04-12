WITH
    customers_3_orders AS (
        SELECT customer_id, COUNT(*) AS total_orders
        FROM restaurant_orders
        GROUP BY customer_id
        HAVING COUNT(*) >= 3
    ),
    restaurant_peak_orders AS (
        SELECT customer_id, COUNT(*) AS cnt
        FROM restaurant_orders
        WHERE
            TIME(order_timestamp) BETWEEN '11:00' AND '14:00'
            OR TIME(order_timestamp) BETWEEN '18:00' AND '21:00'
        GROUP BY customer_id
    ),
    customers_60_percent_peak_orders AS (
        SELECT customer_id, ROUND(100 * t1.cnt / t2.cnt) AS peak_hour_percentage
        FROM restaurant_peak_orders AS t1
        RIGHT JOIN (
            SELECT customer_id, COUNT(*) AS cnt
            FROM restaurant_orders
            GROUP BY customer_id
        ) AS t2
            USING (customer_id)
        WHERE 5 * t1.cnt >= 3 * t2.cnt
    ),
    customers_average_rating_4 AS (
        SELECT customer_id, ROUND(AVG(order_rating), 2) AS average_rating
        FROM restaurant_orders
        WHERE order_rating IS NOT NULL
        GROUP BY customer_id
        HAVING AVG(order_rating) >= 4
    ),
    customers_rated_50 AS (
        SELECT customer_id
        FROM restaurant_orders
        GROUP BY customer_id
        HAVING (SUM(IF(order_rating IS NULL, 0, 1)) << 1) >= COUNT(*)
    )
SELECT *
FROM customers_3_orders
JOIN customers_60_percent_peak_orders
    USING (customer_id)
JOIN customers_average_rating_4
    USING (customer_id)
JOIN customers_rated_50
    USING (customer_id)
ORDER BY average_rating DESC, customer_id DESC;
