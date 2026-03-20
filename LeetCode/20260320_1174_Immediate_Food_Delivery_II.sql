WITH
    f AS (
        SELECT *
        FROM (
            SELECT
                *,
                MIN(order_date) OVER (PARTITION BY customer_id) AS first_order_date
            FROM Delivery
        ) AS t
        WHERE first_order_date = order_date
    )
SELECT
    ROUND((
        SELECT COUNT(*)
        FROM f
        WHERE order_date = customer_pref_delivery_date
    ) / (
        SELECT COUNT(*)
        FROM f
    ) * 100, 2) AS immediate_percentage;
