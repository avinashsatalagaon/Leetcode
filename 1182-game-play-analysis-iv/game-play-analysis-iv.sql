WITH LoginPatterns AS (
    SELECT 
        player_id, 
        event_date,
        -- Find the absolute first login for the player
        MIN(event_date) OVER(PARTITION BY player_id) AS first_login,
        -- Find the date of the very next login record
        LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS next_login
    FROM Activity
)
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN next_login = DATE_ADD(first_login, INTERVAL 1 DAY) 
                            THEN player_id END) 
        / COUNT(DISTINCT player_id), 
        2
    ) AS fraction
FROM LoginPatterns
WHERE event_date = first_login;