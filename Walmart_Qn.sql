use Medium_Level;

Create Table Transactions_Walmart (
transaction_id int,
product_id int,
users_id int,
transaction_date date
);
Insert into Transactions_Walmart 
values 
(231574, 111, 234, '2022-03-01'),
(231574, 444, 234, '2022-03-01'),
(231574, 222, 234, '2022-03-01'),
(137124, 444, 125, '2022-03-05'),
(256234, 222, 311, '2022-03-07'),
(523152, 222, 746, '2022-03-06'),
(141415, 333, 235, '2022-03-02'),
(523152, 444, 746, '2022-03-06'),
(137124, 111, 125, '2022-03-05'),
(256234, 333, 311, '2022-03-07');

Create Table Products_Walmart(
product_id int,
product_name varchar(50)
)
;
Insert into Products_Walmart 
values 
(111,'apple'),
(222,'soya milk'),
(333,'instant oatmeal'),
(444,'banana'),
(555,'chia seed');

SELECT 
    tw.product_id,
    ts.product_id,
    concat(pw.product_name, ' - ',pt.product_name) AS pair_of_product,
    COUNT(3) AS total_pair
FROM
    Transactions_Walmart tw
        JOIN
    Transactions_Walmart ts ON tw.transaction_id = ts.transaction_id
        JOIN
    Products_Walmart pw ON pw.product_id = tw.product_id
        JOIN
    Products_Walmart pt ON pt.product_id = ts.product_id
WHERE
    tw.product_id <> ts.product_id
        AND tw.product_id > ts.product_id
GROUP BY tw.product_id , ts.product_id
;

