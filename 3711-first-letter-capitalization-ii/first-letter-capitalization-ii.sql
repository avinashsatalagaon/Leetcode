# Write your MySQL query statement below
WITH RECURSIVE TitleCase AS (
    -- Base Case: Lowercase everything and capitalize the very first letter
    SELECT 
        content_id,
        content_text AS original_text,
        LOWER(content_text) AS processed_text,
        CONCAT(UPPER(LEFT(content_text, 1)), LOWER(SUBSTRING(content_text, 2))) AS converted_text,
        2 AS pos -- Start checking from the second character
    FROM user_content

    UNION ALL

    -- Recursive Step: Move through the string one character at a time
    SELECT 
        content_id,
        original_text,
        processed_text,
        CASE 
            -- If the character BEFORE current position is a space or hyphen, 
            -- uppercase the current character
            WHEN SUBSTRING(processed_text, pos - 1, 1) IN (' ', '-') 
            THEN CONCAT(
                LEFT(converted_text, pos - 1),
                UPPER(SUBSTRING(processed_text, pos, 1)),
                SUBSTRING(converted_text, pos + 1)
            )
            ELSE converted_text
        END,
        pos + 1
    FROM TitleCase
    WHERE pos <= CHAR_LENGTH(processed_text)
)
-- Select only the final transformed string for each content_id
SELECT content_id, original_text, converted_text
FROM (
    SELECT *, 
           RANK() OVER(PARTITION BY content_id ORDER BY pos DESC) as rnk
    FROM TitleCase
) tmp
WHERE rnk = 1;