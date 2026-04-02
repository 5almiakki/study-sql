WITH
    season_category_sales AS (
        SELECT
            season, category,
            SUM(quantity) AS total_quantity,
            SUM(quantity * price) AS total_revenue
        FROM (
            SELECT
                *,
                CASE
                    WHEN MONTH(sale_date) BETWEEN 3 AND 5 THEN 'Spring'
                    WHEN MONTH(sale_date) BETWEEN 6 AND 8 THEN 'Summer'
                    WHEN MONTH(sale_date) BETWEEN 9 AND 11 THEN 'Fall'
                    ELSE 'Winter'
                END AS season
            FROM sales
        ) AS t
        JOIN products USING (product_id)
        GROUP BY category, season
    ),
    window_season_category_sales AS (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) AS rn
        FROM season_category_sales
        WINDOW w AS (PARTITION BY season)
    )
SELECT season, category, total_quantity, total_revenue
FROM window_season_category_sales
WHERE rn = 1
ORDER BY season ASC;
