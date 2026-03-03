SELECT *
FROM products
WHERE REGEXP_LIKE(description, "(^| )SN[:digit:]{4}\\-[:digit:]{4}($| )", "c")
ORDER BY product_id ASC;
