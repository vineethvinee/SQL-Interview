use Medium_Level;

CREATE TABLE Emp_Salary
(
Emp_id INT NOT NULL,
Name Varchar(30) NOT NULL,
Salary Varchar(30),
Dept_Id INT
);

 Insert into Emp_salary
 (Emp_id,Name,Salary,Dept_Id)
 Values
 (1001,'Alexa','25000',501),
 (1002,'John','30000',502),
 (1003,'S S Das','30000',502),
 (1004,'Sidh','35000',503),
 (1005,'Prateek','40000',504),
 (1006,'Ashwini','35000',503),
 (1007,'Ashutosh','25000',501),
 (1008,'Sourav','28000',505),
 (1009,'Debasish','45000',506);
 
 select 
	emp_id
	,name
    ,salary
    ,dept_id 
 from(
	 select 
		*
		,count(dept_id) over(partition by dept_id,salary) as emp_cnt
	 from Emp_salary
) temp
where emp_cnt>=2
;