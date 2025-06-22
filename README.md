# 🛍️ SQL Retail Sales Analysis Project

This project involves analyzing a retail sales dataset using **PostgreSQL** to uncover key business insights related to customer behavior, product performance, and time-based trends. The dataset was sourced from **Kaggle** and contains 2000 sales transaction records.

---

## 📁 Project Structure

- **Database Name:** `sql_project_p1`
- **Table Name:** `retail_sales`
- **Rows:** 2000
- **Columns:** 11  
  (`transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantity`, `price_per_unit`, `cogs`, `total_sale`)

---

## ⚙️ Tools & Technologies

- **Database:** PostgreSQL
- **GUI:** pgAdmin 4
- **Language:** SQL
- **Dataset Format:** CSV
- **Source:** Kaggle

---

## 🔍 Steps Performed

### 1. 📥 Data Collection & Setup
- Downloaded `SQL - Retail Sales Analysis.csv` from Kaggle.
- Created a new database `sql_project_p1` using pgAdmin 4.
- Created a table `retail_sales` with appropriate data types.
- Imported the dataset into the table.

### 2. 🧹 Data Cleaning
- Identified and deleted 3 rows containing `NULL` values using SQL queries.

### 3. 🔎 Data Exploration
- Found total number of sales.
- Identified number of unique customers.
- Listed all distinct product categories.

### 4. 📊 Data Analysis & Business Questions

| # | Business Question | SQL Operation |
|---|--------------------|----------------|
| 1 | Sales on a specific date (2022-11-05) | `WHERE sale_date = '2022-11-05'` |
| 2 | Clothing sales with quantity ≥ 4 in Nov-2022 | Filtered by category, quantity, and date |
| 3 | Total sales and order count per category | `GROUP BY category` |
| 4 | Avg. age of customers in 'Beauty' category | `AVG(age)` + `HAVING` |
| 5 | Transactions with total_sale > 1000 | `WHERE total_sale > 1000` |
| 6 | Number of transactions by gender and category | `GROUP BY gender, category` |
| 7 | Monthly average sales and best-selling month | `EXTRACT()` + `RANK()` |
| 8 | Top 5 customers by total sales | `GROUP BY` + `ORDER BY` + `LIMIT 5` |
| 9 | Unique customers per category | `COUNT(DISTINCT customer_id)` |
| 10 | Sales categorized by time shifts | `CASE WHEN` using `EXTRACT(HOUR)` |

# Insights Derived

1. Clothing is a frequently purchased category in bulk during November.

2. Majority of high-value transactions (above ₹1000) were recorded in Evening shifts.

3. The best-selling months vary by year, indicating seasonal trends.

4. A small group of customers contribute significantly to total revenue.

---

## 🧾 Sample Query Snippets

```sql
-- Total sales per category
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders 
FROM retail_sales 
GROUP BY category;

-- Top 5 customers
SELECT customer_id, SUM(total_sale) AS total_customer_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_customer_sale DESC
LIMIT 5; 

