SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[a-zA-Z][0-9a-zA-Z_\\.\\-]*@leetcode\\.com$', 'c');

SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[:alpha:][[:digit:][:alpha:]_\\.\\-]*@leetcode\\.com$', 'c');
