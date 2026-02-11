WITH
  t1 AS (
    SELECT
      author, `year`,
      LAG(`year`) OVER (PARTITION BY author ORDER BY `year`) AS lag_year
    FROM books
    WHERE genre = 'Fiction'
    GROUP BY author, `year`
  ),
  t2 AS (
    SELECT
      *,
      IF(lag_year IS NOT NULL AND `year` - lag_year <= 1, 0, 1) AS seq_base
    FROM t1
  ),
  t3 AS (
    SELECT
      *,
      SUM(seq_base) OVER (ORDER BY author, `year`, lag_year) AS seq_group
    FROM t2
  )
SELECT
  ANY_VALUE(author) AS author,
  MAX(`year`) AS `year`,
  COUNT(`year`) AS depth
FROM t3
GROUP BY seq_group
HAVING COUNT(`year`) >= 5
