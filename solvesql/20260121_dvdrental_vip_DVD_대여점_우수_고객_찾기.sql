SELECT rental.customer_id AS customer_id
FROM rental
JOIN customer
ON
  rental.customer_id = customer.customer_id
  AND customer.active
GROUP BY rental.customer_id
HAVING COUNT(*) >= 35;
