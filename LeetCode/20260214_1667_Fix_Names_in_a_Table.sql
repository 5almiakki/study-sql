SELECT
    user_id,
    CONCAT(
        UPPER(SUBSTR(name FROM 1 FOR 1)),
        LOWER(SUBSTR(name FROM 2))
    ) AS name
FROM Users
ORDER BY user_id ASC;
