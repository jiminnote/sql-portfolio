WITH cte AS (
    SELECT
        s.*,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium s
    WHERE people >= 100
)
SELECT id, visit_date, people
FROM cte
WHERE grp IN (
    SELECT grp
    FROM cte
    GROUP BY grp
    HAVING COUNT(*) >= 3
)
ORDER BY visit_date;