/*1)	You are required to create tables for supplier,customer,category,product,supplier_pricing,order,rating to store the data for the E-commerce with the schema definition given */

create database ecommerce;                /* created ecommerce database*/
use ecommerce;

--------------------------------------------------------------------------------------------------
/* creating Insert the  data in the customer table.*/
create table customer(cus_id int primary key,cus_name varchar(20),cus_phone varchar(10),cus_city varchar(30),cus_gender char);

insert into customer values(1,		"Aakash","999999999	","DELHI","M");
insert into customer values(2	,	"AMAN	","978546321",	"NOIDA	","M");
insert into customer values(3,		"NEHA",	"999999999",   "MUMBAI", "F");
insert into customer values(4	,"	MEGHA","999456239", "KOLKATA	","F");
insert into customer values(5,"		PULKIT	", "789599999",  "LUCKNOW	","M");
select * from customer;
-----------------------------------------------------------------------------------------------------------------------------
/* Supplier table*/
create table supplier(supp_id int primary key,supp_name varchar(50),supp_city varchar(50),supp_phone varchar(50));
/* inserting into Supplier table */
insert into supplier values(1,		"Rajesh Retails	","Delhi",	"1234567890");
insert into supplier values(2	,"	Appario Ltd.	","	Mumbai","2589631470");
insert into supplier values(3	,"	Knome products","	Banglore","	9785462315");
insert into supplier values(4	,"	Bansal Retails","		Kochi	","	8975463285");
insert into supplier values(5	,"	Mittal Ltd.	","	Lucknow	","7898456532");
select * from supplier;
---------------------------------------------------------------------------------------------------------------------------------------------
/* category table*/
create table category(cat_id int primary key,cat_name varchar(20));
/*inserting into category table*/
insert into category values(1,"BOOKS");
insert into category values(2	,"	GAMES");
insert into category values(3	,"	GROCERIES");
insert into category values(4,"ELECTRONICS");
insert into category values(5,"CLOTHES");
select * from category;
----------------------------------------------------------------------------------------------------------------------------------------------
/* Product table*/
create table product(pro_id int primary key,pro_name varchar(20) default "Dummy",pro_Desc varchar(60),cat_id int ,foreign key(cat_id) references category(cat_id));
/*insert into Product table*/
insert into product values(1,"	GTA V	","Windows 7 and above with i5 processor and 8GB RAM",		2);
insert into product values(2,"	TSHIRT	","	SIZE-L with Black, Blue and White variations",			5);
insert into product values(3,"	ROG LAPTOP","		Windows 10 with 15inch screen, i7 processor, 1TB SSD	",	4);
insert into product values(4,"		OATS",			"Highly Nutritious from Nestle",	3);
insert into product values(5,		"HARRY POTTER",	"Best Collection of all time by J.K Rowling",	1);
insert into product values(6	,	"MILK	","		1L Toned MIlk		",	3);
insert into product values(7,"	Boat Earphones",	"1.5Meter long Dolby Atmos"	,4);
insert into product values(8,		"Jeans","			Stretchable Denim Jeans with various sizes and color	",	5);
insert into product values(9,		"Project IGI	","	compatible with windows 7 and above		",		2);
insert into product values(10,		"Hoodie	",		"Black GUCCI for 13 yrs and above	",				5);
insert into product values(11	,"Rich Dad Poor Dad",	"Written by RObert Kiyosaki	",	1);
insert into product values(12	,"	Train Your Brain",	"By Shireen Stephen",	1);
select * from product;
-----------------------------------------------------------------------------------------------------------------------------------------------------
/* Creating and inserting into Supplierpricing table*/
create table Supplierpricing (pricing_id int primary key,pro_id  int, foreign key(pro_id) references product(pro_id),supp_id int ,foreign key(supp_id) references supplier(supp_id),supp_price int default 0);
insert into supplierpricing values(1,	1	,2,	1500);
insert into supplierpricing values(2,		3	,		5,	30000);
insert into supplierpricing values(3,		5	,		1	,3000);
insert into supplierpricing values(4,		2	,		3,	2500);
insert into supplierpricing values(5,		4	,		1,	1000);
select * from supplierpricing;
--------------------------------------------------------------------------------------------------------------------------------------------------------
use ecommerce;
/* creating and inserting into rating table*/
create table rating (rat_id int primary key,ord_id int ,foreign key(ord_id) references orders(ord_id),rat_starts int);
insert into rating values(1	,	101		,4);
insert into rating values(2	,	102,		3);
insert into rating values(3	,	103	,	1);
insert into rating values(4	,	104	,	2);
insert into rating values(5	,	105	,	4);
insert into rating values(6	,	106	,	3);
insert into rating values(7		,107		,4);
insert into rating values(8		,108		,4);
insert into rating values(9	,	109	,	3);
insert into rating values(10	,	110	,	5);
insert into rating values(11	,	111	,	3);
insert into rating values(12,		112	,	4);
select * from rating;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* creating and inserting into Orders table*/
create table Orders (ord_id int primary key,
ord_amount int,ord_date date,cus_id int , foreign key (cus_id) references customer(cus_id),pricing_id int ,
foreign key(pricing_id) references Supplierpricing(pricing_id));
insert into Orders values (101,	1500	,"	2021-10-06",	2	,	1);
insert into Orders values (102,			1000	,	"2021-10-12",	3,		5);
insert into Orders values (103,			30000,"		2021-09-16",	5	,	2);
insert into Orders values (104,			1500,		"2021-10-05",	1	,	1);
insert into Orders values (109,			3000,		"2021-00-10"	,5	,	3);
insert into Orders values (110,			2500	,	"2021-09-10",	2,		4);
insert into Orders values (111,			1000	,	"2021-09-15",	4,		5);
insert into Orders values (114,			1000	,	"2021-09-16",	3	,	5);
insert into Orders values (115,			3000	,	"2021-09-16",	5,		3);
insert into Orders values (116,			99	,	"2021-09-17",	2,		4);
select * from Orders;
------------------------------------------------------------------------------------------------------------------------------------
/*3)	Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.*/
select count(customer.cus_gender)  as Total_no_of_customers from customer inner join Orders on customer.cus_id=Orders.cus_id  
where (Orders.ord_amount)>=3000 group by customer.cus_gender;
--------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------
/*5)	Display the Supplier details who can supply more than one product.*/
select supplier.supp_id,Supplier.supp_name from Supplier inner join Product on Supplier.supp_id=Product.pro_id having count(Supplier.supp_id)>1;
-------------------------------------------------------------------------------------------------------------------------------------------
/*6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product*/
  select category.cat_id,category.cat_name,Product.pro_name,min(Supplierpricing.supp_price) as Priceofproduct
   from category
   inner join
   Product on category.cat_id=Product.cat_id
   inner join Supplierpricing
   on Product.pro_id=Supplierpricing.pro_id
   group by category.cat_id;
   ------------------------------------------------------------------------------------------------------------------------------------------
   /*7)	Display the Id and Name of the Product ordered after “2021-10-05"*/
select pro_id, pro_name from Product where pro_id in 
(select pro_id from supplierpricing where pricing_id in 
(select pricing_id from Orders where ord_date > "2021-10-05"));
------------------------------------------------------------------------------------------------------------------------------------------------
/*8)	Display customer name and gender whose names start or end with character 'A'.*/
select cus_id,cus_name from customer where cus_name like "A%" or cus_name like"%A";
----------------------------------------------------------------------------------------------------------------------------------------------------
/*9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.*/
DELIMITER &&  
CREATE PROCEDURE ec()
BEGIN  
 select distinct supp_id,supp_name,rat_starts ,
 case when rat_starts=5 then "Excellent service"
 when rat_starts>4 then "Good service"
 when rat_starts>2 then "Average service"
 else "Poor service"
 end as Type_of_service
 from Supplier,rating
 group by Supplier.supp_id;
END &&  
DELIMITER ;  
call ec();
-------------------------------------------------------------------------------------------------------------------------------------
/*4)	Display all the orders along with product name ordered by a customer having Customer_Id=2*/
select Orders.ord_id ,Product.pro_name from Orders,Product where Orders.cus_id=2 group by orders.ord_id;

--------------------------------------------------------------------------------------------------------------------------------------
