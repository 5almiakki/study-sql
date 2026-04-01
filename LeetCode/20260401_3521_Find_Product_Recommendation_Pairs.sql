SELECT
    product1_id, product2_id, product1_category, product2_category,
    COUNT(*) AS customer_count
FROM (
    SELECT
        p1.user_id AS user_id,
        p1.product_id AS product1_id,
        p2.product_id AS product2_id,
        pi1.category AS product1_category,
        pi2.category AS product2_category
    FROM ProductPurchases AS p1
    JOIN ProductPurchases AS p2
        ON p1.user_id = p2.user_id AND p1.product_id < p2.product_id
    JOIN ProductInfo AS pi1
        ON p1.product_id = pi1.product_id
    JOIN ProductInfo AS pi2
        ON p2.product_id = pi2.product_id
    GROUP BY p1.user_id, p1.product_id, p2.product_id
) AS t
GROUP BY product1_id, product2_id
HAVING COUNT(*) >= 3
ORDER BY customer_count DESC, product1_id ASC, product2_id ASC;
