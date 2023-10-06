use Medium_Level;

drop table Stocks;

create table Stocks(
stock_name varchar(255),
operation enum('Buy','Sell'),
operation_day int,
price int
);

insert into Stocks values ('Leetcode','Buy',1,1000);
insert into Stocks values ('Corona Masks','Buy',2,10);
insert into Stocks values ('Leetcode','Sell',5,9000);
insert into Stocks values ('Handbags','Buy',17,30000);
insert into Stocks values ('Corona Masks','Sell',3,1010);
insert into Stocks values ('Corona Masks','Buy',4,1000);
insert into Stocks values ('Corona Masks','Sell',5,500);
insert into Stocks values ('Corona Masks','Buy',6,1000);
insert into Stocks values ('Handbags','Sell',29,7000);
insert into Stocks values ('Corona Masks','Sell',10,10000);


with tbl as(
select *, dense_rank() over(partition by stock_name,operation order by operation_day) as dr from Stocks
)
select stock_name, -
group by 1
;
