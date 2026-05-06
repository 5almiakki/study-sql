SELECT
    request_at AS `Day`,
    ROUND(
        SUM(IF(status LIKE "cancelled%", 1, 0)) / COUNT(*),
        2
    ) AS `Cancellation Rate`
FROM Trips
JOIN Users AS Clients
    ON Trips.client_id = Clients.users_id
JOIN Users AS Drivers
    ON Trips.driver_id = Drivers.users_id
WHERE
    request_at BETWEEN "2013-10-01" AND "2013-10-03"
    AND Clients.banned = "No"
    AND Drivers.banned = "No"
GROUP BY request_at;
