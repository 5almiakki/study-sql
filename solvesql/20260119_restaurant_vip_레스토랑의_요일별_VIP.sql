SELECT *
FROM tips
WHERE (`day`, total_bill) IN (
  SELECT `day`, MAX(total_bill) AS m
  FROM tips
  GROUP BY `day`
);
