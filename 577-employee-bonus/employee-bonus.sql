# Write your MySQL query statement below
select name, Bonus
from Employee e
left join Bonus b
on e.empId=b.empId 
where Bonus<1000 or bonus is null