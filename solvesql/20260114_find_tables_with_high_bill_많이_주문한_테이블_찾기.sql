SELECT *
FROM tips
WHERE (
  SELECT AVG(total_bill)
  FROM tips
) < total_bill;
