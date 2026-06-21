-- ============================================================
-- Retail Sales Analysis — SQL Project
-- Author: Adithyan Thirunavukkarasu
-- Dataset: Superstore Sales (Kaggle)
-- Tools: MySQL 9.7
-- ============================================================

-- Setup
CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis;

-- ============================================================
-- TABLE CREATION
-- ============================================================

CREATE TABLE IF NOT EXISTS sales (
    order_id VARCHAR(20),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(20),
    customer_id VARCHAR(20),
    customer_name VARCHAR(50),
    segment VARCHAR(20),
    country VARCHAR(30),
    city VARCHAR(30),
    state VARCHAR(30),
    region VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(20),
    sub_category VARCHAR(20),
    product_name VARCHAR(200),
    sales DECIMAL(10,2)
);

-- ============================================================
-- QUERY 1: Total Sales by Category
-- Aggregation — GROUP BY, SUM, COUNT
-- ============================================================

SELECT category, 
       ROUND(SUM(sales), 2) AS total_sales,
       COUNT(*) AS order_count
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- ============================================================
-- QUERY 2: Top 10 Customers by Revenue
-- Aggregation — GROUP BY, ORDER BY, LIMIT
-- ============================================================

SELECT customer_name,
       ROUND(SUM(sales), 2) AS total_sales,
       COUNT(*) AS orders
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- QUERY 3: Sales by Region with Average Order Value
-- Aggregation — SUM, AVG, GROUP BY
-- ============================================================

SELECT region,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(AVG(sales), 2) AS avg_order_value
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- ============================================================
-- QUERY 4: Sales by Customer Segment
-- Aggregation — COUNT DISTINCT
-- ============================================================

SELECT segment,
       ROUND(SUM(sales), 2) AS total_sales,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;

-- ============================================================
-- QUERY 5: Top 10 Products by Revenue
-- Aggregation — GROUP BY product
-- ============================================================

SELECT product_name,
       ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- QUERY 6: Running Total of Sales by Region
-- Window Function — SUM OVER PARTITION BY
-- ============================================================

SELECT region,
       order_id,
       sales,
       ROUND(SUM(sales) OVER (PARTITION BY region ORDER BY order_date), 2) AS running_total
FROM sales
LIMIT 100;

-- ============================================================
-- QUERY 7: Customer Sales Ranking
-- Window Function — RANK() OVER
-- ============================================================

SELECT customer_name,
       segment,
       ROUND(SUM(sales), 2) AS total_sales,
       RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM sales
GROUP BY customer_name, segment
ORDER BY sales_rank
LIMIT 10;

-- ============================================================
-- QUERY 8: Sub-Category Sales as % of Category Total
-- Window Function — Nested SUM OVER PARTITION BY
-- ============================================================

SELECT category,
       sub_category,
       ROUND(SUM(sales), 2) AS sub_cat_sales,
       ROUND(SUM(SUM(sales)) OVER (PARTITION BY category), 2) AS category_total,
       ROUND(SUM(sales) / SUM(SUM(sales)) OVER (PARTITION BY category) * 100, 2) AS pct_of_category
FROM sales
GROUP BY category, sub_category
ORDER BY category, sub_cat_sales DESC;

-- ============================================================
-- QUERY 9: High Value Orders Above Average (CTE)
-- CTE — WITH clause, subquery logic
-- ============================================================

WITH avg_sales AS (
    SELECT AVG(sales) AS avg_order_value
    FROM sales
),
high_value AS (
    SELECT order_id, customer_name, sales, region, category
    FROM sales, avg_sales
    WHERE sales > avg_order_value
)
SELECT category,
       COUNT(*) AS high_value_orders,
       ROUND(SUM(sales), 2) AS total_sales
FROM high_value
GROUP BY category
ORDER BY total_sales DESC;

-- ============================================================
-- QUERY 10: Monthly Sales Trend
-- Date functions — YEAR, MONTH, STR_TO_DATE, GROUP BY
-- ============================================================

SELECT 
    YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS year,
    MONTH(STR_TO_DATE(order_date, '%m/%d/%Y')) AS month,
    ROUND(SUM(sales), 2) AS monthly_total,
    COUNT(*) AS orders
FROM sales
GROUP BY year, month
ORDER BY year, month;
