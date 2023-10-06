use Medium_level;

create table input (
id int,
formula varchar(10),
value int
);
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);

with temp as(
select *,left(formula,1) as id1,right(formula,1) as id2,substring(formula,2,1) as op
 from input
 ) 
 select 
	t.id
	,t.formula
	,t.value
    ,t.op
    ,ip1.value as d1_val
    ,ip2.value as d2_val
    ,case when t.op='+' then ip1.value+ip2.value else ip1.value-ip2.value end as new_val
 from temp t
 inner join input ip1 on t.id1=ip1.id
 inner join input ip2 on t.id2=ip2.id
 order by 1
 ;