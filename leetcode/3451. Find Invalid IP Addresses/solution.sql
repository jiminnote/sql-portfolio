SELECT ip, COUNT(*) AS invalid_count 
FROM (
    SELECT ip
    FROM logs 
    WHERE 
        (LENGTH(ip) - LENGTH(REPLACE(ip, '.', ''))) <> 3
        OR CAST(SUBSTRING_INDEX(ip, '.', 1) AS UNSIGNED) > 255
        OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS UNSIGNED) > 255
        OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS UNSIGNED) > 255
        OR CAST(SUBSTRING_INDEX(ip, '.', -1) AS UNSIGNED) > 255
        OR (SUBSTRING_INDEX(ip, '.', 1) LIKE '0%' AND SUBSTRING_INDEX(ip, '.', 1) <> '0')
        OR (SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) LIKE '0%' AND SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) <> '0')
        OR (SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) LIKE '0%' AND SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) <> '0')
        OR (SUBSTRING_INDEX(ip, '.', -1) LIKE '0%' AND SUBSTRING_INDEX(ip, '.', -1) <> '0')
) t
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;