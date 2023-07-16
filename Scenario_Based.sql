use Complex_Probs;

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
	('A','Bangalore','A1@gmail.com',1,'CPU'),	
    ('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
	('B','Bangalore','B@gmail.com',2,'DESKTOP'),	
    ('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
    ('B','Bangalore','B2@gmail.com',1,'MONITOR')
;    

with 
distinct_resources as( 
select distinct name,resources 
from entries
)
,agg_resources as (select 
	name,GROUP_CONCAT(resources) as resources_used 
from distinct_resources
group by 1)

,total_visit as (
select 
	name,
    count(1) as total_visit
from entries 
group by 1
)
,floor_visit as (
select 
	name, 
	floor, 
    count(1) as no_of_floor_visit,
    rank() over(partition by name order by count(1) desc) as rn 
from entries
group by 1,2
)
select 
	fv.name, 
    fv.floor as most_visited_floor, 
    tv.total_visit, 
    ar.resources_used
from floor_visit fv 
inner join total_visit tv on fv.name=tv.name
inner join agg_resources ar on fv.name=ar.name
where rn=1
;

/* Algorithm:
1. Create a temporary table called distinct_resources using a subquery:

Select distinct name and resources from the entries table.
Store the result in the distinct_resources table.

2. Create a temporary table called agg_resources using a subquery:

Select name and use the GROUP_CONCAT function to concatenate the resources for each name.
From the distinct_resources table.
Group the results by name.
Store the result in the agg_resources table.

3. Create a temporary table called total_visit using a subquery:

Select name, count the occurrences as total_visit, and use the GROUP_CONCAT function to concatenate the resources for each name.
From the entries table.
Group the results by name.
Store the result in the total_visit table.

4. Create a temporary table called floor_visit using a subquery:

Select name, floor, count the occurrences as no_of_floor_visit, and calculate the rank using the RANK function partitioned by name and ordered by the count in descending order.
From the entries table.
Group the results by name and floor.
Store the result in the floor_visit table.

5.Perform the main query:

Select fv.name, fv.floor as most_visited_floor, tv.total_visit, and ar.resources_used.
From the floor_visit table aliasing it as fv.
Join the total_visit table using the name column.
Join the agg_resources table using the name column.
Filter the results to include only rows where rn (rank) is equal to 1.

6.Return the result of the query.

This algorithm will retrieve the most visited floor, total visits, and aggregated resources used for each distinct name from the entries table, based on the number of visits to each floor.

*/