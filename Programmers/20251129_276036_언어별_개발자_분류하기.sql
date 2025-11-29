WITH
    fes (FES) AS (
        SELECT SUM(`CODE`)
        FROM SKILLCODES
        WHERE CATEGORY = 'Front End'
    ),
    p (P) AS (
        SELECT SUM(`CODE`)
        FROM SKILLCODES
        WHERE NAME = 'Python'
    ),
    c (C) AS (
        SELECT SUM(`CODE`)
        FROM SKILLCODES
        WHERE NAME = 'C#'
    )
SELECT 'A' AS GRADE, ID, EMAIL
FROM DEVELOPERS
WHERE
    (SKILL_CODE & (SELECT FES FROM fes)) != 0
    AND
    (SKILL_CODE & (SELECT P FROM p)) != 0
UNION
SELECT 'B' AS GRADE, ID, EMAIL
FROM DEVELOPERS
WHERE
    (
        (SKILL_CODE & (SELECT FES FROM fes)) = 0
        OR
        (SKILL_CODE & (SELECT P FROM p)) = 0
    )
    AND
    (SKILL_CODE & (SELECT c FROM C)) != 0
UNION
SELECT 'C' AS GRADE, ID, EMAIL
FROM DEVELOPERS
WHERE
    (SKILL_CODE & (SELECT FES FROM fes)) != 0
    AND
    (SKILL_CODE & (SELECT P FROM p)) = 0
    AND
    (SKILL_CODE & (SELECT C FROM c)) = 0
ORDER BY GRADE ASC, ID ASC;

WITH
    fes (FES) AS (
        SELECT SUM(`CODE`)
        FROM SKILLCODES
        WHERE CATEGORY = 'Front End'
    ),
    p (P) AS (
        SELECT SUM(`CODE`)
        FROM SKILLCODES
        WHERE NAME = 'Python'
    ),
    c (C) AS (
        SELECT SUM(`CODE`)
        FROM SKILLCODES
        WHERE NAME = 'C#'
    )
SELECT *
FROM (
    SELECT
        CASE
            WHEN (SKILL_CODE & (SELECT FES FROM fes)) != 0
                AND (SKILL_CODE & (SELECT P FROM p)) != 0
                THEN 'A'
            WHEN (SKILL_CODE & (SELECT c FROM C)) != 0
                THEN 'B'
            WHEN (SKILL_CODE & (SELECT FES FROM fes)) != 0
                THEN 'C'
        END AS GRADE,
        ID,
        EMAIL
    FROM DEVELOPERS
) AS t
WHERE GRADE IS NOT NULL
ORDER BY GRADE ASC, ID ASC;
