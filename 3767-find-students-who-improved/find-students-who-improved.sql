# Write your MySQL query statement below
WITH DateBounds AS (
    -- Step 1: Find first and last dates for pairs with at least 2 exams
    SELECT 
        student_id, 
        subject, 
        MIN(exam_date) AS first_date, 
        MAX(exam_date) AS latest_date
    FROM Scores
    GROUP BY student_id, subject
    HAVING MIN(exam_date) < MAX(exam_date) -- Ensures at least two different dates
)
SELECT 
    db.student_id, 
    db.subject, 
    s1.score AS first_score, 
    s2.score AS latest_score
FROM DateBounds db
-- Step 2: Join once for the first score
JOIN Scores s1 ON db.student_id = s1.student_id 
               AND db.subject = s1.subject 
               AND db.first_date = s1.exam_date
-- Join again for the latest score
JOIN Scores s2 ON db.student_id = s2.student_id 
               AND db.subject = s2.subject 
               AND db.latest_date = s2.exam_date
-- Step 3: Filter for improvement
WHERE s2.score > s1.score
ORDER BY student_id, subject;


