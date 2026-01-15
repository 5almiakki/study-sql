SELECT title, year, rotten_tomatoes
FROM movies
WHERE title LIKE '%Love%' OR title LIKE '%love%'
ORDER BY rotten_tomatoes DESC, year DESC;
