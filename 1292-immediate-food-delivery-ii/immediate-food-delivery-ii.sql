# Write your MySQL query statement below
SELECT 
ROUND(
    100*SUM(order_date = customer_pref_delivery_date)/COUNT(*),2
) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN(
    SELECT customer_id, MIN(order_date)
    FROM DELIVERY
    GROUP BY customer_id
);

/*
with cte as(
select customer_id, min(order_date) as order_date, min(customer_pref_delivery_date) as customer_pref_delivery_date
from delivery
group by customer_id)
select round(sum(case when customer_pref_delivery_date = order_date then 1 else 0 end)*100 / count(1), 2) as immediate_percentage
from cte
*/
 