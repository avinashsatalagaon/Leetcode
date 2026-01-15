# Write your MySQL query statement below
-- Part 1: Get the latest price for products with changes before or on 2019-08-16
SELECT product_id, new_price AS price
FROM Products
WHERE (product_id, change_date) IN (
    SELECT product_id, MAX(change_date)
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)

UNION

-- Part 2: Get products that only have changes AFTER 2019-08-16
SELECT DISTINCT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';