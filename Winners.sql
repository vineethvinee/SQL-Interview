-- Write sql query to find the winner in each group.
-- The winner in each group is the player who scored the maximum total points within the group . Incase of a tie, the lowest player_id wins.
 
 

use Complex_Probs;

create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


with player_score as (
select first_player as player_id, first_score as score from matches
union all
select second_player as player_id, second_score as score from matches 
),
final as(
select p.group_id,ps.player_id, sum(ps.score) as score
from player_score ps
inner join players p on ps.player_id = p.player_id
group by 1,2
)
select group_id, player_id, score 
from(select *, dense_rank() over(partition by group_id order by score desc,player_id asc)  as rk from final) A
where A.rk=1
;

select second_player, sum(second_player) over(rows between 1 preceding and 0 preceding) as row_prev_sum  from matches;


select second_player, sum(second_player) over(rows between 1 preceding and 0 preceding) as row_prev_sum  from matches;

select * from matches;









