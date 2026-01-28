SELECT
  `day`, `time`, sex, total_bill
FROM (
  SELECT
    *,
    DENSE_RANK() OVER (PARTITION BY `day` ORDER BY total_bill DESC) AS r
  FROM tips
) AS t
WHERE r <= 3;
