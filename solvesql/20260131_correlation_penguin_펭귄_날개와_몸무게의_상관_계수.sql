WITH t AS (
  SELECT
    species,
    flipper_length_mm,
    body_mass_g,
    AVG(flipper_length_mm) OVER (PARTITION BY species) AS flipper_length_avg,
    AVG(body_mass_g) OVER (PARTITION BY species) AS body_mass_avg
  FROM penguins
)
SELECT
  species,
  ROUND(
    SUM((flipper_length_mm - flipper_length_avg) * (body_mass_g - body_mass_avg))
      / SQRT(SUM(POW(flipper_length_mm - flipper_length_avg, 2)))
      / SQRT(SUM(POW(body_mass_g - body_mass_avg, 2))),
    3
  ) AS corr
FROM t
GROUP BY species;
