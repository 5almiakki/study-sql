SELECT
  name AS genre,
  ROUND(SUM(CASE `year` WHEN 2011 THEN score_sum / cnt ELSE 0 END), 2) AS score_2011,
  ROUND(SUM(CASE `year` WHEN 2012 THEN score_sum / cnt ELSE 0 END), 2) AS score_2012,
  ROUND(SUM(CASE `year` WHEN 2013 THEN score_sum / cnt ELSE 0 END), 2) AS score_2013,
  ROUND(SUM(CASE `year` WHEN 2014 THEN score_sum / cnt ELSE 0 END), 2) AS score_2014,
  ROUND(SUM(CASE `year` WHEN 2015 THEN score_sum / cnt ELSE 0 END), 2) AS score_2015
FROM (
  SELECT
    genres.*,
    COUNT(*) AS cnt,
    SUM(critic_score) AS score_sum,
    `year`
  FROM games
  JOIN genres USING(genre_id)
  WHERE
    critic_score IS NOT NULL
    AND `year` BETWEEN 2011 AND 2015
  GROUP BY genre_id, `year`
) AS g
GROUP BY genre_id;
