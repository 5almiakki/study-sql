SELECT
  REGEXP_SUBSTR(address, '^[가-힣]+') AS sido,
  REGEXP_SUBSTR(REGEXP_REPLACE(address, '^[가-힣]+ ', ''), '^[가-힣]+') AS sigungu,
  COUNT(*) AS cnt
FROM cafes
GROUP BY
  REGEXP_SUBSTR(address, '^[가-힣]+'),
  REGEXP_SUBSTR(REGEXP_REPLACE(address, '^[가-힣]+ ', ''), '^[가-힣]+')
ORDER BY cnt DESC;
