WITH cgp AS (
  SELECT
    c.name AS developer,
    p.name AS platform,
    SUM(sales_na + sales_eu + sales_jp + sales_other) AS sales,
    DENSE_RANK() OVER (
      PARTITION BY c.company_id ORDER BY SUM(sales_na + sales_eu + sales_jp + sales_other) DESC
    ) AS dr
  FROM companies AS c
  JOIN games AS g
    ON c.company_id = g.developer_id
  JOIN platforms AS p USING(platform_id)
  GROUP BY c.company_id, p.platform_id
)
SELECT developer, platform, sales
FROM cgp
WHERE dr = 1;
