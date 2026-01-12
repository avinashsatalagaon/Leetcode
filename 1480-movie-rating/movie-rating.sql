# Write your MySQL query statement below
(select u.name as results
from users u
join movierating mr
on mr.user_id=u.user_id
group by u.user_id
order by count(u.user_id) desc, u.name asc
limit 1)

union all

(select m.title as results
from movies m
join movierating mr 
on mr.movie_id=m.movie_id
where created_at between '2020-02-1' and '2020-02-29'
group by m.title
order by avg(mr.rating) desc,m.title asc
limit 1)