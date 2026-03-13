SELECT
    user_id AS buyer_id,
    join_date,
    IFNULL(cnt, 0) AS orders_in_2019
FROM Users
LEFT JOIN (
    SELECT buyer_id, COUNT(*) AS cnt
    FROM Orders
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id
) AS o
    ON user_id = buyer_id;
