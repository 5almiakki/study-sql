SELECT
    user_id,
    SUM(IF(activity_type = 'free_trial', avg_duration, 0)) AS trial_avg_duration,
    SUM(IF(activity_type = 'paid', avg_duration, 0)) AS paid_avg_duration
FROM (
    SELECT
        user_id, activity_type,
        ROUND(AVG(activity_duration), 2) AS avg_duration
    FROM UserActivity u
    WHERE
        EXISTS (
            SELECT 1
            FROM UserActivity t
            WHERE
                u.user_id = t.user_id
                AND t.activity_type = 'free_trial'
        )
        AND EXISTS (
            SELECT 1
            FROM UserActivity t
            WHERE
                u.user_id = t.user_id
                AND t.activity_type = 'paid'
        )
        AND activity_type != 'cancelled'
    GROUP BY user_id, activity_type
) AS t
GROUP BY user_id;

SELECT
    user_id,
    ROUND(AVG(IF(activity_type = 'free_trial', activity_duration, null)), 2) AS trial_avg_duration,
    ROUND(AVG(IF(activity_type = 'paid', activity_duration, null)), 2) AS paid_avg_duration
FROM UserActivity
GROUP BY user_id
HAVING paid_avg_duration IS NOT NULL;
