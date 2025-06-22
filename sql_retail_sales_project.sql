-- SQL Retail Sales Analysis
CREATE DATABASE sql_project_p1;


--Create Table
 CREATE TABLE retail_sales
 			(
				transactions_id	INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,	
				customer_id	INT,
				gender VARCHAR(20),
				age	INT,
				category VARCHAR(20),	
				quantiy INT,
				price_per_unit FLOAT,	
				cogs FLOAT,
				total_sale FLOAT
			);
--Data cleaning

SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

--
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

--Data Exploration

--how many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales

--how many unique customers we have?
SELECT COUNT(DISTINCT customer_id)AS total_sales FROM retail_sales

SELECT DISTINCT category FROM retail_sales


--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

----------------------------------------------------------------------------------------------------------------
 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *FROM retail_sales WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND EXTRACT(MONTH FROM sale_date) = 11
  AND EXTRACT(YEAR FROM sale_date) = 2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) AS net_sale,count(*) AS total_orders from retail_sales GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category,Round(AVG(age),2) AS avg_age FROM retail_sales Group by category having category = 'Beauty';

/* or SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'; */

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *FROM retail_sales WHERE total_sale >1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	gender,
	category, 
	count(transactions_id) 
	AS num_of_transactions 
	from retail_sales GROUP BY gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_monthly_sale
FROM retail_sales
GROUP BY year, month
ORDER BY avg_monthly_sale DESC;

--or

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) AS total_customer_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_customer_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
  CASE 
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift;

-- END OF PROJECT  