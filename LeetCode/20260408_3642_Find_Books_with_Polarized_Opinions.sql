WITH
    books_5_sessions AS (
        SELECT book_id
        FROM reading_sessions
        GROUP BY book_id
        HAVING COUNT(*) >= 5
    ),
    books_high_rating AS (
        SELECT book_id, COUNT(*) AS high_rating_cnt
        FROM reading_sessions
        WHERE session_rating >= 4
        GROUP BY book_id
        HAVING COUNT(*) >= 1
    ),
    books_low_rating AS (
        SELECT book_id, COUNT(*) AS low_rating_cnt
        FROM reading_sessions
        WHERE session_rating <= 2
        GROUP BY book_id
        HAVING COUNT(*) >= 1
    ),
    polarized_reading_sessions AS (
        SELECT
            book_id,
            ANY_VALUE(high_rating_cnt) AS high_rating_cnt,
            ANY_VALUE(low_rating_cnt) AS low_rating_cnt,
            MAX(session_rating) AS highest_rating,
            MIN(session_rating) AS lowest_rating,
            COUNT(*) AS total_cnt
        FROM reading_sessions
        JOIN books_5_sessions USING (book_id)
        JOIN books_high_rating USING (book_id)
        JOIN books_low_rating USING (book_id)
        GROUP BY book_id
    )
SELECT
    books.*,
    highest_rating - lowest_rating AS rating_spread,
    ROUND((high_rating_cnt + low_rating_cnt) / total_cnt, 2) AS polarization_score
FROM books
JOIN polarized_reading_sessions USING (book_id)
WHERE (high_rating_cnt + low_rating_cnt) / total_cnt >= 0.6
ORDER BY polarization_score DESC, title DESC;
