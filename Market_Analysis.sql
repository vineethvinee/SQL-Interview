use Complex_Probs;

create table ma_users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table ma_orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table ma_items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into ma_users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into ma_items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into ma_orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
 
 with rank_orders as (
 select * 
 from(
	select *,rank() over(partition by seller_id order by order_date asc) as rn 
	from ma_orders) A
 )
 select u.user_id as seller_id
    ,case when i.item_brand = u.favorite_brand then 'Yes' else 'No' end as item_fav_brand
from ma_users u
left join rank_orders ro on ro.seller_id = u.user_id and ro.rn=2
left join ma_items i on i.item_id = ro.item_id
order by 1
 ;








