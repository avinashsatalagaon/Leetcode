# Write your MySQL query statement below
WITH DailySales AS (
    -- Step 1: Sum amounts per day
    SELECT visited_on, SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
)
SELECT 
    visited_on, 
    amount, 
    average_amount
FROM (
    -- Step 2: Calculate sliding sum and average
    SELECT 
        visited_on,
        SUM(daily_amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(SUM(daily_amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) / 7, 2) AS average_amount,
        -- Identify the row number to filter out the first 6 days
        ROW_NUMBER() OVER (ORDER BY visited_on) as rn
    FROM DailySales
) t
-- Step 3: Only return records starting from the 7th day
WHERE rn >= 7
ORDER BY visited_on;