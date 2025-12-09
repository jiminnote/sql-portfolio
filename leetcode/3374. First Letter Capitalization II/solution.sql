WITH RECURSIVE char_table AS (
  SELECT 
      content_id AS id,
      content_text AS text,
      1 AS pos,
      SUBSTRING(content_text, 1, 1) AS c
  FROM user_content
  
  UNION ALL
  
  SELECT 
      id,
      text,
      pos + 1,
      SUBSTRING(text, pos + 1, 1)
  FROM char_table
  WHERE pos + 1 <= LENGTH(text)
)
, labeled AS (
  SELECT
      id,
      pos,
      text,
      c,
      LAG(c, 1) OVER (PARTITION BY id ORDER BY pos) AS prev_c
  FROM char_table
)
, converted AS (
  SELECT
      id, pos, text,
      CASE
          WHEN prev_c IS NULL THEN UPPER(c)
          WHEN prev_c = ' ' THEN UPPER(c)
          WHEN prev_c = '-' AND c REGEXP '[a-z]' THEN UPPER(c)
          WHEN prev_c REGEXP '[A-Z]' AND c REGEXP '[A-Z]' THEN LOWER(c)
          ELSE c
      END AS out_char
  FROM labeled
)
SELECT
    id AS content_id,
    text AS original_text,
    GROUP_CONCAT(out_char ORDER BY pos SEPARATOR '') AS converted_text
FROM converted
GROUP BY id;