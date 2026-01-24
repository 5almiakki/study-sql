SELECT artist_id, name
FROM artists AS a
WHERE
  death_year IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM artworks_artists AS aa
    WHERE a.artist_id = aa.artist_id
  );
