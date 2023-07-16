use Medium_Level;

create table contensts
(
c_id int,
start_date date,
end_date date
);

insert into contensts(c_id, start_date, end_date) 
values(1,'2015-02-01','2015-02-04'), (2,'2015-02-02','2015-02-05'), (3,'2015-02-03','2015-02-07'),
(4,'2015-02-04','2015-02-06'),(5,'2015-02-06','2015-02-09'),(6,'2015-02-08','2015-02-10'),(7,'2015-02-10','2015-02-11');

select *,end_date-lag(start_date) over(order by start_date)+1 as 'no_of_days' from contensts;

select *,end_date-lead(start_date) over(order by start_date)+1 as 'no_of_days' from contensts;