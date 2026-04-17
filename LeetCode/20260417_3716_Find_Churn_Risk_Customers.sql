WITH
    active_users AS (
        SELECT user_id, last_event_date AS event_date
        FROM (
            SELECT
                *,
                MAX(event_date) OVER w AS last_event_date,
                MAX(event_id) OVER w AS last_event_id
            FROM subscription_events
            WINDOW w AS (PARTITION BY user_id)
        ) AS t
        WHERE
            event_date = last_event_date
            AND event_id = last_event_id
            AND event_type != 'cancel'
        GROUP BY user_id, last_event_date
    ),
    downgraded_users AS (
        SELECT DISTINCT(user_id)
        FROM subscription_events
        WHERE event_type = 'downgrade'
    ),
    half_plan_revenue_users AS (
        SELECT user_id, max_historical_amount
        FROM (
            SELECT
                *,
                MAX(monthly_amount) OVER (PARTITION BY user_id) AS max_historical_amount
            FROM subscription_events
        ) AS t
        WHERE (monthly_amount << 1) < max_historical_amount
        GROUP BY user_id, max_historical_amount
    ),
    sixty_day_active_users AS (
        SELECT user_id, SUM(itvl) AS days_as_subscriber
        FROM (
            SELECT
                *,
                IF(
                    LAG(event_type) OVER (PARTITION BY user_id ORDER BY event_date ASC) = 'cancel',
                    0,
                    IFNULL(
                        DATEDIFF(
                            event_date,
                            LAG(event_date) OVER (PARTITION BY user_id ORDER BY event_date ASC)
                        ),
                        0
                    )
                ) AS itvl
            FROM subscription_events
        ) AS t
        GROUP BY user_id
        HAVING SUM(itvl) >= 60
    ),
    churn_risk_users AS (
        SELECT
            user_id,
            plan_name AS current_plan,
            monthly_amount AS current_monthly_amount,
            max_historical_amount, days_as_subscriber
        FROM subscription_events
        JOIN active_users USING (user_id, event_date)
        JOIN half_plan_revenue_users USING (user_id)
        JOIN sixty_day_active_users USING (user_id)
        WHERE
            user_id IN (SELECT * FROM downgraded_users)
    )
SELECT *
FROM churn_risk_users
ORDER BY days_as_subscriber DESC, user_id ASC;

SELECT
    user_id,
    MAX(CASE rn WHEN 1 THEN plan_name END) AS current_plan,
    MAX(CASE rn WHEN 1 THEN monthly_amount END) AS current_monthly_amount,
    MAX(monthly_amount) AS max_historical_amount,
    DATEDIFF(MAX(event_date), MIN(event_date)) AS days_as_subscriber
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY event_date DESC) AS rn
    FROM subscription_events
) AS t
GROUP BY user_id
HAVING
    MAX(CASE rn WHEN 1 THEN event_type END) != 'cancel'
    AND SUM(IF(event_type = 'downgrade', 1, 0)) >= 1
    AND MAX(CASE rn WHEN 1 THEN monthly_amount END) * 2 < MAX(monthly_amount)
    AND DATEDIFF(MAX(event_date), MIN(event_date)) >= 60
ORDER BY days_as_subscriber DESC, user_id ASC;
