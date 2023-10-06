use Complex_Probs;

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');


with all_date as(
select *
	,row_number() over(partition by state order by date_value) as rn
    ,dateadd(day,-1*row_number() over(partition by state order by date_value), date_value) as group_date
from tasks
)
select min(date_value) as start_date, max(date_value) as end_date, state
from all_dates
group by state
order by start_date
;




