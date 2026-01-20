SELECT title
FROM film
WHERE
  rating IN ('R', 'NC-17')
  AND SUBSTR(UPPER(title), -1) NOT IN ('A', 'E', 'I', 'O', 'U');
