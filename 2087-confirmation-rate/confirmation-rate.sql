# Write your MySQL query statement below
select s.user_id,
round(ifnull(sum(c.action='confirmed')/count(c.action),0),2)as confirmation_rate
from signups s
left join Confirmations c
on c.user_id =s.user_id 
group by  s.user_id
