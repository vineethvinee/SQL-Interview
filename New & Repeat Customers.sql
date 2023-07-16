show tables;

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

with first_visit as (
select customer_id
	, min(order_date) as first_visit_date
from customer_orders
group by 1
)
select co.order_date
	,sum(case when co.order_date=fv.first_visit_date then 1 else 0 end) as first_visit_flag
	,sum(case when co.order_date!=fv.first_visit_date then 1 else 0 end) as repeat_visit_flag
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
group by co.order_date
;

with first_visit as (
select customer_id
	, min(order_date) as first_visit_date
from customer_orders
group by 1
)
select co.order_date
	,sum(case when co.order_date=fv.first_visit_date then 1 else 0 end) as first_visit_flag
	,sum(case when co.order_date!=fv.first_visit_date then 1 else 0 end) as repeat_visit_flag
from customer_orders co
inner join first_visit fv 
on co.customer_id = fv.customer_id
group by co.order_date
;


/* Algorithm:
1. Create a temporary table called first_visit using a subquery.

Select customer_id and the minimum order_date as first_visit_date from the customer_orders table.
Group the results by customer_id.
Store the result in the first_visit table.

2. Perform the main query:

Select co.order_date,
Sum the first_visit_flag column based on the condition:
If co.order_date is equal to fv.first_visit_date, set the flag to 1; otherwise, set it to 0.
Sum the repeat_visit_flag column based on the condition:
If co.order_date is not equal to fv.first_visit_date, set the flag to 1; otherwise, set it to 0.
From the customer_orders table, alias it as co.
Join the first_visit table using the customer_id column.
Group the results by co.order_date.

3. Return the result of the query.

This algorithm will calculate the first_visit_flag and repeat_visit_flag for each order_date in the customer_orders table, based on the earliest visit date for each customer.

*/



