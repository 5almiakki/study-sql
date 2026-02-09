SELECT
    id,
    SUM(CASE `month` WHEN 'Jan' THEN r ELSE NULL END) AS Jan_Revenue,
    SUM(CASE `month` WHEN 'Feb' THEN r ELSE NULL END) AS Feb_Revenue,
    SUM(CASE `month` WHEN 'Mar' THEN r ELSE NULL END) AS Mar_Revenue,
    SUM(CASE `month` WHEN 'Apr' THEN r ELSE NULL END) AS Apr_Revenue,
    SUM(CASE `month` WHEN 'May' THEN r ELSE NULL END) AS May_Revenue,
    SUM(CASE `month` WHEN 'Jun' THEN r ELSE NULL END) AS Jun_Revenue,
    SUM(CASE `month` WHEN 'Jul' THEN r ELSE NULL END) AS Jul_Revenue,
    SUM(CASE `month` WHEN 'Aug' THEN r ELSE NULL END) AS Aug_Revenue,
    SUM(CASE `month` WHEN 'Sep' THEN r ELSE NULL END) AS Sep_Revenue,
    SUM(CASE `month` WHEN 'Oct' THEN r ELSE NULL END) AS Oct_Revenue,
    SUM(CASE `month` WHEN 'Nov' THEN r ELSE NULL END) AS Nov_Revenue,
    SUM(CASE `month` WHEN 'Dec' THEN r ELSE NULL END) AS Dec_Revenue
FROM (
    SELECT id, `month`, SUM(revenue) AS r
    FROM Department
    GROUP BY id, `month`
) AS t
GROUP BY id;
