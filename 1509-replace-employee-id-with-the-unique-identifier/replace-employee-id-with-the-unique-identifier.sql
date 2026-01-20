# Write your MySQL query statement below
select unique_id, name
from employees e
left join employeeuni un
on e.id=un.id
