WITH
  m_season AS (
    SELECT
      *,
      CASE
        WHEN MONTH(measured_at) BETWEEN 3 AND 5 THEN 'spring'
        WHEN MONTH(measured_at) BETWEEN 6 AND 8 THEN 'summer'
        WHEN MONTH(measured_at) BETWEEN 9 AND 11 THEN 'autumn'
        ELSE 'winter'
      END AS season
    FROM measurements
  ),
  m_rn AS (
    SELECT
      season, pm10,
      ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10) AS rn1,
      COUNT(*) OVER (PARTITION BY season) - ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10) + 1 AS rn2
    FROM m_season
  ),
  m_median AS (
    SELECT
      season,
      AVG(pm10) AS pm10_median
    FROM m_rn
    WHERE rn1 BETWEEN rn2 - 1 AND rn2 + 1
    GROUP BY season
  ),
  m_average AS (
    SELECT
      season,
      ROUND(AVG(pm10), 2) AS pm10_average
    FROM m_season
    GROUP BY season
  )
SELECT
  m_average.season AS season,
  pm10_median,
  pm10_average
FROM m_average
JOIN m_median
ON m_average.season = m_median.season;
