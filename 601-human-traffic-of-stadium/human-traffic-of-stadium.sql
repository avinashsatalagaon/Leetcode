# Write your MySQL query statement below
WITH FilteredStadium AS (
    -- Step 1: Filter and calculate the group identifier
    SELECT 
        id, 
        visit_date, 
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),
GroupCounts AS (
    -- Step 2: Count how many records are in each group
    SELECT 
        *,
        COUNT(*) OVER (PARTITION BY grp) AS count_in_grp
    FROM FilteredStadium
)
-- Step 3: Return only rows belonging to groups of 3+
SELECT 
    id, 
    visit_date, 
    people
FROM GroupCounts
WHERE count_in_grp >= 3
ORDER BY visit_date;