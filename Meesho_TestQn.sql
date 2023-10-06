use Medium_Level;

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);


with running_cost as(
select *,sum(cost) over(order by cost) as run_cost
from products
)
select cb.customer_id,cb.budget,count(1) as no_of_products,GROUP_CONCAT(product_id) as list_of_products
from customer_budget cb 
left join running_cost rc on rc.run_cost < cb.budget
group by 1,2
;
