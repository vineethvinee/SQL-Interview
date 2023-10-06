/* Where 0 - unoccupied & 1 - occupied
--> Seq of 4 seats un occupied seats
Con: 1. Belong to same row
	 2. Those 4 seats are consecutive
Output: A3 A6
*/

-- SUBSTR(string, start, length)

use Medium_Level;

create table cinema_tickets(seat_number varchar(100) not null, occupancy int);

insert into cinema_tickets(seat_number, occupancy) 
values('A1',1),('A2',1),('A3',0),('A4',0),('A5',0),('A6',0),
('A7',1),('A8',1),('A9',0),('A10',0),('B1',0),('B2',0),('B3',0),('B4',1),('B5',1),('B6',1),
('B7',1),('B8',0),('B9',0),('B10',0),('C1',0),('C2',1),('C3',0),('C4',1),('C5',1),('C6',0),
('C7',1),('C8',0),('C9',0),('C10',1);

with tab1 as (
select *,
	lead(occupancy,1) over(partition by substr(seat_number,1,1)) as s1,
    lead(occupancy,2) over(partition by substr(seat_number,1,1)) as s2,
    lead(occupancy,3) over(partition by substr(seat_number,1,1)) as s3
 from cinema_tickets
 ),
tab2 as (
 select *,
	occupancy+s1+s2+s3 as sm, 
	lead(seat_number,3) over(partition by substr(seat_number,1,1)) as end_seat
from tab1
 )
 select seat_number as start_seat, 
	end_seat 
from tab2
 where sm=0
 ;

/* Algorithm :
Certainly! Here's an algorithm that outlines the steps to achieve the result of the given SQL query:

1. Read the data from the "cinema_tickets" table.

2. Create a temporary table called "tab1" with the following columns:
   - All columns from the "cinema_tickets" table.
   - Additional columns: s1, s2, s3.
     - Calculate the lead occupancy for the next three seats (s1, s2, s3) for each seat number (partitioned by the first character of the seat_number).

3. Create a temporary table called "tab2" with the following columns:
   - All columns from "tab1".
   - Additional columns: sm, end_seat.
     - Calculate the sum of occupancy, s1, s2, and s3 for each row and store it in the "sm" column.
     - Calculate the seat number for the seat that is three positions ahead and store it in the "end_seat" column.

4. Execute the final query on "tab2" to retrieve the start_seat and end_seat columns where the sum of occupancy, s1, s2, and s3 is equal to 0.

5. Return the results of the query.

Note: The algorithm assumes that the necessary database connection and query execution mechanisms are in place.

*/

