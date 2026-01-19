SELECT bike_id
FROM rental_history
WHERE YEAR(rent_at) = 2021 AND MONTH(rent_at) = 1
  AND YEAR(return_at) = 2021 AND MONTH(return_at) = 1
GROUP BY bike_id
HAVING SUM(`distance`) >= 50000;
