# Write your MySQL query statement below
select Department,Employee,Salary from(select d.name as Department,e.name as Employee,e.salary as Salary,
rank() over (partition by e.departmentid order by e.salary desc) as dept_rank
from employee e
join department d
on e.departmentid=d.id) T
where dept_rank=1



