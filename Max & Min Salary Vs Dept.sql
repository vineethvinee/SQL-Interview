-- Write a query to print highest and lowest salary emp in each department

use Medium_Level;

create table employee2
(
emp_name varchar(10),
dep_id int,
salary int
);

insert into employee2 values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);

select * from employee2;

-- Method-1-- case when, aggregation, and join

with cte as(
select dep_id,
	min(salary) as min_sal,
	max(salary) as max_sal
from employee2
group by 1
)
select e.dep_id,
	max(case when salary=max_sal then emp_name else null end) as max_sal_emp,
	min(case when salary=min_sal then emp_name else null end) as min_sal_emp
from employee2 e 
inner join cte on e.dep_id=cte.dep_id
group by e.dep_id
; 

-- Method-2-- rank,aggregation, case when

select dep_id,
	max(case when sal_dsc=1 then emp_name else null end) as max_sal,
	min(case when sal_asc=1 then emp_name else null end) as min_sal
from(
select *, 
	dense_rank() over(partition by dep_id order by salary desc) as sal_dsc,
    dense_rank() over(partition by dep_id order by salary ) as sal_asc
from employee2) A
group by dep_id;

