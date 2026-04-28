WITH
    t1 AS (
        SELECT user_id
        FROM (
            SELECT user_id
            FROM reactions
            GROUP BY user_id, content_id
        ) AS t
        GROUP BY user_id
        HAVING COUNT(*) >= 5
    ),
    t2 AS (
        SELECT
            user_id, reaction,
            COUNT(*) AS reaction_cnt,
            SUM(COUNT(*)) OVER(PARTITION BY user_id) AS total_cnt,
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY COUNT(*) DESC) AS rn
        FROM reactions
        GROUP BY user_id, reaction
    ),
    t3 AS (
        SELECT user_id, reaction, reaction_cnt, total_cnt
        FROM t2
        WHERE rn = 1
    ),
    t4 AS (
        SELECT user_id
        FROM t2
        WHERE 5 * reaction_cnt >= 3 * total_cnt
    )
SELECT
    user_id,
    reaction AS dominant_reaction,
    ROUND(reaction_cnt / total_cnt, 2) AS reaction_ratio
FROM t1
JOIN t4 USING (user_id)
JOIN t3 USING (user_id)
ORDER BY reaction_ratio DESC, user_id ASC;
