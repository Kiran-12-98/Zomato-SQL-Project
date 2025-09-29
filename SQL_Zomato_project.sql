use Netflix


create table Zomato
(orderId int, RestaurantName varchar(255), RestaurantType varchar(255), Rating float, No_of_Rating int, 
AverageCost int,OnlineOrder varchar(255), TableBooking varchar(255), CuisinesType varchar(255), Area varchar(255), 
LocalAddress varchar(255), DeliveryTime int)

select * from Zomato
bulk insert dbo.zomato
from 'C:\Users\DELL\Desktop\Zomato.csv'
with
(
format ='CSV',
firstrow = 2
)

select * from Zomato

/*1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
 Chicken Bites.*/

create function insertstuff
(
)
returns varchar(255)
as begin 
return stuff('Quick Bites', 7, 0,' Chicken ')
end
select dbo.insertstuff() as result

--*This demonstrates the use of the Stuff() function and user defined function in SQL.

select * from Zomato


/*2. Use the function to display the restaurant name and cuisine type which has the
 maximum number of rating*/

select top(1) RestaurantName, CuisinesType,No_of_Rating from Zomato order by No_of_Rating desc

--*insight-Byg Brewski Brewing Company restaurant which has the maximum number of rating.




/*3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
 star rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
 and below 3.5 and ‘Bad’ if it is below 3 star rating.*/

select *, IIF(Rating>4 ,'Excellent' ,iif(rating >= 3.5 ,'Good', iif(rating >=3,'Average','Bad')))
as Rating_status from Zomato

/*Insight*- This query demonstrates the use of the if() function(nested) to classify ratings into
categories,which makes it easier to analyze restaurant performance*/


/*4. Find the Ceil, floor and absolute values of the rating column and display the current date
 and separately display the year, month_name and day*/

 select RestaurantName, Rating, CEILING(rating) as CeilValue, FLOOR(Rating) as FloorValue, ABS(Rating) as
 AbsoluteValue,GETDATE() as CurrentDate, YEAR(getdate()) as YearValue, Datename(month,getdate())
 as Month_Name, day(getdate()) as DayValue from Zomato

 /**Insight- This query demonstrates the functions CEILING(),FLOOR(),ABS() to manipulate data and date function to 
 extract usefuldate components,aiding in analysis and reporting.*/


 /*5. Display the restaurant type and total average cost using rollup*/

 select RestaurantType, SUM(averagecost) as Average_Cost From Zomato Group by rollup(RestaurantType)

 --**Insight- It shows how to use ROLLUP to get subtotal and grandtotal for average cost by restaurant type.




