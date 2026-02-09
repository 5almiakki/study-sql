SELECT product_id, product_name
FROM Product AS p
WHERE EXISTS (
    SELECT 1
    FROM Sales AS s
    WHERE
        p.product_id = s.product_id
        AND '2019-01-01' <= sale_date AND sale_date < '2019-04-01'
) AND NOT EXISTS (
    SELECT 1
    FROM Sales AS s
    WHERE
        p.product_id = s.product_id
        AND ('2019-01-01' > sale_date OR sale_date >= '2019-04-01')
)
GROUP BY product_id, product_name;
