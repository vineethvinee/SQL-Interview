/* Write sql query to get start time and end time of each call from below 2 tables. Also create a column of call duration in minutes. 
Please do take into account that there will multiple calls from one phone number and each entry in start table has a corresponding entry in 
end table
*/

create database call_logs;
use call_logs;
use Medium_Level;

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00');

create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;

/*
datediff(minute,start_time,end_time) as duration
extract(minute from (select A.phone_number,B.end_time-A.start_time from call_start_logs A inner join call_end_logs B on A.phone_number=B.phone_number)) as duration
timediff(B.end_time,A.start_time)
With Inner Join
Data & Time Link: https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date
*/

-- Important Approach
-- With Inner Join
select A.phone_number, A.start_time, B.end_time,timestampdiff(minute,A.start_time,B.end_time) as duration
from
(select *, row_number() over(partition by phone_number order by start_time) as dr from call_start_logs) A
inner join
(select *, row_number() over(partition by phone_number order by end_time) as dr from call_end_logs) B
on A.phone_number=B.phone_number and A.dr=B.dr;

-- WIth Union

select phone_number,start_time
from
(select *, row_number() over(partition by phone_number order by start_time) as dr from call_start_logs
union all
select *, row_number() over(partition by phone_number order by end_time) as dr from call_end_logs)
group by phone_number, rn ;

select A.phone_number, A.start_time, B.end_time,timediff(B.end_time-A.start_time) as duration from (select *, row_number() over(partition by phone_number order by start_time) as dr from call_start_logs) A inner join (select *, row_number() over(partition by phone_number order by end_time) as dr from call_end_logs) B on A.phone_number=B.phone_number and A.dr=B.dr
