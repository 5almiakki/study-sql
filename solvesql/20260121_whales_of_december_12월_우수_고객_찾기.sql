SELECT customer_id
FROM records
WHERE YEAR(order_date) = 2020 AND MONTH(order_date) = 12
GROUP BY customer_id
HAVING SUM(sales) >= 1000;
