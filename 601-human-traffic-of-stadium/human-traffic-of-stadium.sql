# Write your MySQL query statement below
WITH FilteredStadium AS (
    SELECT id, visit_date,  people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),
GroupCounts AS (
    SELECT 
        *, COUNT(*) OVER (PARTITION BY grp) AS count_in_grp
    FROM FilteredStadium
)
-- Return only rows belonging to groups of 3+
SELECT id, visit_date, people
FROM GroupCounts
WHERE count_in_grp >= 3
ORDER BY visit_date;