SELECT *
FROM Users
WHERE email REGEXP '^[_[:alnum:]]+\\@[:alpha:]+\\.com$'
ORDER BY user_id;
