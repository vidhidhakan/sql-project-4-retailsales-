create database sqlproject1

use sqlproject1
select * from retailsales

select top(1000) *from retailsales
order by transactions_id asc


select count(*) from retailsales

select * from retailsales

---------------------------------------------DATA CLEANING 


select * from retailsales
where 
     transactions_id is null
	 or 
	 sale_date is null
	 or 
	 sale_time is null
	 or
	 gender is null
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 quantiy is null
	 or
	 price_per_unit is null
	 or 
	 cogs is null
	 or 
	 total_sale is null

----------------------------------------- DELETE MISSSING VALUES

delete from retailsales
where 
     transactions_id is null
	 or 
	 sale_date is null
	 or 
	 sale_time is null
	 or
	 gender is null
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 quantiy is null
	 or
	 price_per_unit is null
	 or 
	 cogs is null
	 or 
	 total_sale is null
    
select * from retailsales

select count(transactions_id) from retailsales


-------------------------------------------------- DATA EXPLORATION

---- HOW MANY SALES WE HAVE?

SELECT * FROM retailsales

SELECT COUNT(*) as totalsales from retailsales

--- HOW MANY CUSTOMER WE HAVE?

select * from retailsales

select count(customer_id) as totalcustomer from retailsales

---- HOW MANY UNIQUE CUSTOMER WE HAVE?

select count(distinct customer_id) as totalcustomer from retailsales


-- HOW MANY CATEGORY WE HAVE?

select count(distinct category) as totalcustomer from retailsales


------- BUSINESS KEY PROBLEMS AND ANSWERS

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM retailsales
WHERE sale_date = '2022-11-05';



--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retailsales
where category = 'Clothing'
and
datepart(year,sale_date) = 2022
and
DATEPART(month, sale_date) = 11
and
quantiy >= 4



-- 3. Write a SQL query to calculate the total sales (total_sale) for each category and also total orders



select * from retailsales

select sum(total_sale)as totalsales, category, count(*) as totalorders
from retailsales
group by category


--- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select * from retailsales


select avg(age) as avgage, category
from retailsales
where category = 'Beauty'
group by category


---- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from retailsales

select *
from retailsales
where total_sale > 1000


---- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select * from retailsales


select gender, category, count(transactions_id) as totaltran
from retailsales
group by gender, category



---- 7. *Write a SQL query to find the top 5 customers based on the highest total sales :

select * from retailsales

select top(5) customer_id, sum(total_sale) as totalsales
from retailsales
group by customer_id
order by totalsales desc

---- 8. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select * from retailsales

select year(sale_date)as year,
month(sale_date ) as month,
avg(total_sale) as avgsale,
rank() over (partition by year(sale_date) order by avg(total_sale)desc )
from retailsales
group by year(sale_date),month(sale_date)
order by avgsale desc


---- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:

select * from retailsales


select count(distinct customer_id) as uniquecustomer, category
from retailsales
group by category


--- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

select * from retailsales

with cte as
(
SELECT *,
    CASE 
        WHEN datepart(hour,sale_time) < 12 THEN 'Morning'
        WHEN datepart(hour,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retailsales)

select count(*) as totalorders, shift
from cte
group by shift

