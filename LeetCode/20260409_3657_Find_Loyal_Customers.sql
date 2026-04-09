WITH
    refund_rate_20 AS (
        SELECT customer_id
        FROM (
            SELECT customer_id, COUNT(*) AS total_sum
            FROM customer_transactions
            GROUP BY customer_id
        ) AS t1
        LEFT JOIN (
            SELECT customer_id, IFNULL(COUNT(*), 0) AS refund_sum
            FROM customer_transactions
            WHERE transaction_type = 'refund'
            GROUP BY customer_id
        ) AS t2
            USING (customer_id)
        WHERE 5 * IFNULL(refund_sum, 0) < total_sum
    ),
    active_30_days_3_purchases AS (
        (
            SELECT customer_id
            FROM (
                SELECT customer_id, transaction_date
                FROM customer_transactions
                GROUP BY customer_id, transaction_date
            ) AS t
            GROUP BY customer_id
            HAVING DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30
        )
        INTERSECT
        (
            SELECT customer_id
            FROM customer_transactions
            WHERE transaction_type = 'purchase'
            GROUP BY customer_id
            HAVING COUNT(*) >= 3
        )
    )
SELECT *
FROM refund_rate_20
JOIN active_30_days_3_purchases
    USING (customer_id)
ORDER BY customer_id ASC;
