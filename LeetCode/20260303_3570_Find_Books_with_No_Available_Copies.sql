SELECT book_id, title, author, genre, publication_year, current_borrowers
FROM (
    SELECT book_id, COUNT(*) AS current_borrowers
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
) AS borrow_count
JOIN library_books USING (book_id)
WHERE total_copies = current_borrowers
ORDER BY current_borrowers DESC, title ASC;
