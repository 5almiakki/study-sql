SELECT
  a.first_name AS first_name,
  a.last_name AS last_name,
  SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN rental AS r
  ON p.rental_id = r.rental_id
JOIN inventory AS i
  ON r.inventory_id = i.inventory_id
JOIN film_actor AS fa
  ON i.film_id = fa.film_id
JOIN actor AS a
  ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY total_revenue DESC
LIMIT 5;
