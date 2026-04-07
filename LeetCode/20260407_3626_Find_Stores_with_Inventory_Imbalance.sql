WITH
    most_expensive_inventory AS (
        SELECT *
        FROM (SELECT *, MAX(price) OVER (PARTITION BY store_id) AS max_price FROM inventory) AS t
        WHERE price = max_price
    ),
    cheapest_inventory AS (
        SELECT *
        FROM (SELECT *, MIN(price) OVER (PARTITION BY store_id) AS min_price FROM inventory) AS t
        WHERE price = min_price
    )
SELECT
    stores.*,
    most_expensive_inventory.product_name AS most_exp_product,
    cheapest_inventory.product_name AS cheapest_product,
    ROUND(cheapest_inventory.quantity / most_expensive_inventory.quantity, 2) AS imbalance_ratio
FROM stores
JOIN most_expensive_inventory USING (store_id)
JOIN cheapest_inventory USING (store_id)
WHERE
    store_id IN (SELECT store_id FROM inventory GROUP BY store_id HAVING COUNT(*) >= 3)
    AND cheapest_inventory.quantity > most_expensive_inventory.quantity
ORDER BY imbalance_ratio DESC, store_name ASC;
