# Write your MySQL query statement below
SELECT 
    v.customer_id, 
    COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t 
    ON v.visit_id = t.visit_id
-- This filter isolates visits that didn't result in a transaction
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;