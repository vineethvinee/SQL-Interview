-- Derive points table for a typical tournament 

create database Complex_Probs;
use Complex_Probs;

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


SELECT 
    team_name AS team,
    COUNT(team_name) AS mat_played,
    SUM(win_flag) AS wins,
    COUNT(team_name) - SUM(win_flag) AS losses
FROM
    (SELECT 
        team_1 AS team_name,
            CASE
                WHEN team_1 = winner THEN 1
                ELSE 0
            END AS win_flag
    FROM
        icc_world_cup UNION ALL SELECT 
        team_2 AS team_name,
            CASE
                WHEN team_2 = winner THEN 1
                ELSE 0
            END AS win_flag
    FROM
        icc_world_cup) A
GROUP BY team_name
ORDER BY wins DESC
;

/* Algorithm:
1. Perform a subquery using the UNION ALL operator to combine two separate queries. Each subquery selects the team name and calculates a win flag based on whether the team is the winner or not in the icc_world_cup table.

In the first subquery, select team_1 as team_name.
If team_1 is equal to the winner, set the win_flag to 1; otherwise, set it to 0.
From the icc_world_cup table.
Union it with the second subquery.
In the second subquery, select team_2 as team_name.
If team_2 is equal to the winner, set the win_flag to 1; otherwise, set it to 0.
From the icc_world_cup table.

2. Perform the main query:

Select team_name as team.
Count the occurrences of team_name as mat_played.
Sum the win_flag column as wins.
Calculate the losses by subtracting the sum of win_flag from the count of team_name.
From the subquery result, alias it as A.
Group the results by team_name.
Order the results by wins in descending order.

3. Return the result of the query.

This algorithm will calculate the number of matches played, wins, and losses for each team based on the icc_world_cup table, and return the results in descending order of wins.
*/