WITH p AS (
    SELECT
        *,
        AVG(tokens) OVER (PARTITION BY user_id) AS avg_tokens,
        COUNT(*) OVER (PARTITION BY user_id) AS prompt_count
    FROM prompts
)
SELECT
    user_id,
    prompt_count,
    ROUND(avg_tokens, 2) AS avg_tokens
FROM (
    SELECT DISTINCT(user_id) AS user_id
    FROM p
    WHERE tokens > avg_tokens AND prompt_count >= 3
) AS t
JOIN p USING (user_id)
GROUP BY user_id, prompt_count, avg_tokens
ORDER BY avg_tokens DESC, user_id ASC;
