use sql_project;
SELECT * FROM sql_project.`sql - retail sales analysis_utf`
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null
;
-- Number of Customers
SELECT Count(customer_id)
FROM `sql - retail sales analysis_utf`;

-- How Many Unique Customers we have
SELECT Count(distinct customer_id)
FROM `sql - retail sales analysis_utf`;

-- Total Sales
SELECT sum(total_sale)
FROM `sql - retail sales analysis_utf`;

-- How many Unique Categories
SELECT distinct category
FROM `sql - retail sales analysis_utf`;

-- Data Analysis and Business Key problems
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
FROM `sql - retail sales analysis_utf`
where sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM `sql - retail sales analysis_utf`
where category= 'Clothing'
and quantiy >= 4
and sale_date like '2022-11-%';

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
sum(total_sale) as net_sales,
count(customer_id) as number_of_customers
FROM `sql - retail sales analysis_utf`
group by category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT round(avg(age)) as average_age,
category
FROM `sql - retail sales analysis_utf`
where category= 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM `sql - retail sales analysis_utf`
where total_sale >= '1000';

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT count(transactions_id),
gender,
category
FROM `sql - retail sales analysis_utf`
group by gender, category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * From
(SELECT 
year(sale_date) as Year,
month(sale_date) as Month,
avg(total_sale) as Avg_sale,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranking
FROM `sql - retail sales analysis_utf`
group by Year, Month) as t1
where ranking = 1
;
-- 8. Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT Sum(total_sale) as total_sale,
customer_id
FROM `sql - retail sales analysis_utf`
group by customer_id
order by total_sale desc
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category,
count(distinct(customer_id))
FROM `sql - retail sales analysis_utf`
group by category
;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sale as 
(
SELECT *,
case
	when hour(sale_time) < 12 then 'Morning Shift'
    when hour(sale_time) between 12 and 17 then 'Afternoon shift'
    else 'evening'
end as shift
FROM `sql - retail sales analysis_utf`
)
select 
count(*) as total_orders,
shift
from hourly_sale
group by shift
;

-- End of Project