-- Condition, If criteria1 and criteria2 both are Y and a minimum of 2 team memnbers should have Y then the output should be Y else N

use Medium_Level;

create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);
insert into Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');


with temp as(
select *, sum(q_cnt) over(partition by teamid) as q_number
from(
select 
	*
    ,case when criteria1="Y" and criteria2="Y" then 1 else 0 end as q_cnt
from Ameriprise_LLC
) A
)
select 
	teamid
	,memberid
    ,criteria1
    ,criteria2
    ,q_number
	,case when criteria1="Y" and criteria2="Y" and q_number >=2 then "Y" else "N" end as qlfd
from temp
;