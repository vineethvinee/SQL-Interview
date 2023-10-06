-- Write a Sql query to fetch student name & the subject which he/she got the highest marks.

create database students;
 
use students;

create table student( Name VARCHAR(100), Roll_No INT NOT NULL);
INSERT INTO student(Name, Roll_No) values('Rashmi', 124);

INSERT INTO student (Name, Roll_No) 
VALUES('Rahul', 468), ('Srijas',85), ('Dravin',35);

create table marks(Roll_Num int not null, subject varchar(100), marks int);
INSERT INTO marks (Roll_Num,subject, marks) 
VALUES(124,'Maths', '88'), (468, 'Maths',90), (85,'Maths',90),(35,'Maths',81),(124,'English',77),(468,'English',70),
(85,'English',55),(35,'English',68),
(124,'Hindi',93),(468,'Hindi',99),
(85,'Hindi',89),(35,'Hindi',80);

select * from marks;

select 
	s.name
	, subject
from(
	select *, dense_rank() over(partition by roll_num order by marks desc)as dr
	from marks
) A
join student s 
	on a.roll_num=s.roll_no
where dr=1;