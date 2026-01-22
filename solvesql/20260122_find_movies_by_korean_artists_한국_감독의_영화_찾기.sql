SELECT
  a.name AS artist,
  w.title AS title
FROM artists AS a
JOIN artworks_artists AS aa
  ON a.nationality = 'Korean' AND a.artist_id = aa.artist_id
JOIN artworks AS w
  ON aa.artwork_id = w.artwork_id AND w.classification LIKE 'Film%';
