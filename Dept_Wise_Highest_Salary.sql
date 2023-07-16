use Medium_Level;


create table Employee(
Id int primary key,
Emp_name varchar(255),
Salary int,
departmentId int 
);

insert into Employee values(1,'Joe',85000,1);
insert into Employee values(2,'Henry',80000,2);
insert into Employee values(3,'Sam',60000,2);
insert into Employee values(4,'Max',90000,1);
insert into Employee values(5,'Janet',69000,1);
insert into Employee values(6,'Randy',85000,1);
insert into Employee values(7,'Will',70000,1);

create table Department(
Id int primary key,
name varchar(255)
);

insert into department values(1,'IT');
insert into department values(2,'Sales'); 

select * from department;
-- A.emp_name,A.salary

select Department, Employee, Salary from(
select A.emp_name as Employee,A.salary as Salary,B.name as Department,dense_rank() over(partition by B.Id order by A.salary desc) dr from employee A inner join department B on A.departmentId=B.Id) as t
where t.dr<=3;


with tbl as
(select A.emp_name as Employee,A.salary as Salary,B.name as Department,dense_rank() over(partition by B.Id order by A.salary desc) dr from employee A inner join department B on A.departmentId=B.Id)
select Department,Employee, Salary from tbl
where dr=1;