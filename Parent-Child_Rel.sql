use Medium_Level;

create table people
(id int primary key not null,
name varchar(20),
gender char(2));

create table relations
(
c_id int,
p_id int,
FOREIGN KEY (c_id) REFERENCES people(id),
foreign key (p_id) references people(id)
);


insert into people (id, name, gender)
values
(107,'Days','F'),
(145,'Hawbaker','M'),
(155,'Hansel','F'),
(202,'Blackston','M'),
(227,'Criss','F'),
(278,'Keffer','M'),
(305,'Canty','M'),
(329,'Mozingo','M'),
(425,'Nolf','M'),
(534,'Waugh','M'),
(586,'Tong','M'),
(618,'Dimartino','M'),
(747,'Beane','M'),
(878,'Chatmon','F'),
(904,'Hansard','F');

insert into relations(c_id, p_id)
values
(145, 202),
(145, 107),
(278,305),
(278,155),
(329, 425),
(329,227),
(534,586),
(534,878),
(618,747),
(618,904);

with main as(
select p1.name as child, p2.name as parent,p2.gender
from relations r 
inner join people p1
on r.c_id=p1.id
inner join people p2
on r.p_id=p2.id

)
,fr as(
select child, parent as father
from main 
where gender="M"
)
,mr as(
select child, parent as mother
from main 
where gender="F"
)
select t1.*, t2.mother
from fr t1
inner join mr t2 
on t1.child=t2.child
order by 1

;



