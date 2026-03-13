WITH
    p1 AS (
        SELECT
            *,
            MAX(change_date) OVER (PARTITION BY product_id) AS last_change_date
        FROM Products
        WHERE change_date <='2019-08-16'
    ),
    p2 AS (
        SELECT *
        FROM p1
        WHERE change_date = last_change_date
    )
SELECT
    product_id,
    IFNULL(new_price, 10) AS price
FROM (
    SELECT DISTINCT(product_id) AS product_id
    FROM Products
) AS p
LEFT JOIN p2 USING (product_id);
