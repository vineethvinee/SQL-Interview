-- Calculating the Cummulative sum of the customers

use Medium_Level;

create table customer_txn(
   cust_id int NOT NULL,
   txn_date Date NOT NULL,
   txn_amt INT NOT NULL
   
);

INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (101,STR_TO_DATE('01-3-2022', '%d-%m-%Y'),500); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (101,STR_TO_DATE('02-3-2022', '%d-%m-%Y'),400); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (101,STR_TO_DATE('03-3-2022', '%d-%m-%Y'),900); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (101,STR_TO_DATE('04-3-2022', '%d-%m-%Y'),800); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (102,STR_TO_DATE('01-3-2022', '%d-%m-%Y'),1600);
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (101,STR_TO_DATE('02-3-2022', '%d-%m-%Y'),2200); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (103,STR_TO_DATE('04-3-2022', '%d-%m-%Y'),200); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (103,STR_TO_DATE('05-3-2022', '%d-%m-%Y'),2200); 
INSERT INTO customer_txn (cust_id, txn_date, txn_amt) VALUES (103,STR_TO_DATE('08-3-2022', '%d-%m-%Y'),100); 


-- with tab1 as (
-- select * 
-- from customer_txn 
-- order by txn_date
-- 
with tab1 as (
select *, 
	sum(txn_amt) over(partition by cust_id order by txn_date) as cum_txn 
from customer_txn
order by cust_id, txn_date
),
tab2 as (
select *, 
	row_number() over(partition by cust_id order by cum_txn) as rn
from tab1
where cum_txn >= 2000 
)
select cust_id,
	txn_date,
	cum_txn
from tab2
where rn=1
;


-- RUNNING/CUMMULATIVE SUM WITHOUT WINDOW FUNCTION

select t1.txn_amt,
	sum(t2.txn_amt) as run_sum 
from 
	customer_txn as t1
inner join customer_txn t2 
	on t1.txn_amt >= t2.txn_amt
group by 1
order by 1;

-- RUNNING/CUMMULATIVE SUM WITH WINDOW FUNCTION

select txn_amt,
	sum(txn_amt) over(order by txn_amt) as run_sum
from customer_txn;