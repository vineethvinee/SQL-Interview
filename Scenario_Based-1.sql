-- Query to fetch persons id, name, score, number_of_friends, whose score of friends is greater than 100 

use Complex_Probs;

create table friend(
	personID INT,
    friendID INT
);

INSERT INTO friend values(1,2);
INSERT INTO friend values(1,3);
INSERT INTO friend values(2,1);
INSERT INTO friend values(2,3);
INSERT INTO friend values(3,5);
INSERT INTO friend values(4,2);
INSERT INTO friend values(4,3);
INSERT INTO friend values(4,5);


create table person(
	personID INT,
    name varchar(20),
    Email varchar(50),
    score INT
);

INSERT INTO person values(1,'Alice','alice2018@hotmail.com',88);
INSERT INTO person values(2,'Bob','bob2018@hotmail.com',11);
INSERT INTO person values(3,'Davis','davis2018@hotmail.com',27);
INSERT INTO person values(4,'Tara','tara2018@hotmail.com',45);
INSERT INTO person values(5,'John','john2018@hotmail.com',63);

with main as (
select f.personID,count(1) as no_of_friends, sum(p.score) as total_friends_marks
from friend f
inner join person p on f.friendID = p.personID
group by 1
having sum(p.score) >= 100
)
select m.*, p.name
from person p
join main m on p.personID = m.personID
;