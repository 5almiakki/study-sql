WITH RECURSIVE
    t1(content_id, content_text, word, rest, idx) AS (
        SELECT
            *,
            SUBSTRING_INDEX(content_text, ' ', 1),
            SUBSTR(content_text, LENGTH(SUBSTRING_INDEX(content_text, ' ', 1)) + 2),
            1
        FROM user_content
        UNION ALL
        SELECT
            content_id, content_text,
            SUBSTRING_INDEX(rest, ' ', 1),
            SUBSTR(rest, LENGTH(SUBSTRING_INDEX(rest, ' ', 1)) + 2),
            idx + 1
        FROM t1
        WHERE rest != ''
    ),
    t2 AS (
        SELECT
            content_id, content_text, idx,
            IF(
                LENGTH(word) - LENGTH(REPLACE(word, '-', '')) = 1
                AND word NOT LIKE '-%',
                CONCAT(
                    UPPER(LEFT(SUBSTRING_INDEX(word, '-', 1), 1)),
                    LOWER(SUBSTRING(SUBSTRING_INDEX(word, '-', 1), 2)),
                    '-',
                    UPPER(LEFT(SUBSTRING_INDEX(word, '-', -1), 1)),
                    LOWER(SUBSTRING(SUBSTRING_INDEX(word, '-', -1), 2))
                ),
                CONCAT(UPPER(LEFT(word, 1)), LOWER(SUBSTRING(word, 2)))
            ) AS word
        FROM t1
    )
SELECT
    content_id,
    content_text AS original_text,
    GROUP_CONCAT(word ORDER BY idx SEPARATOR ' ') AS converted_text
FROM t2
GROUP BY content_id;
