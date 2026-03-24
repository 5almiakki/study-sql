(
    SELECT name AS results
    FROM (
        SELECT
            user_id, name,
            COUNT(*) AS cnt
        FROM MovieRating
        JOIN Users USING (user_id)
        GROUP BY user_id
    ) AS t1
    ORDER BY cnt DESC, name ASC
    LIMIT 1
)
UNION ALL
(
    SELECT
        title AS results
    FROM (
        SELECT
            movie_id, title,
            AVG(rating) AS avg_rating
        FROM MovieRating
        JOIN Movies USING (movie_id)
        WHERE YEAR(created_at) = 2020 AND MONTH(created_at) = 2
        GROUP BY movie_id
    ) AS t2
    ORDER BY avg_rating DESC, title ASC
    LIMIT 1
);
