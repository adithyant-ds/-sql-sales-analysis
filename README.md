# Retail Sales Analysis — SQL Project

End-to-end SQL analysis of 1,000+ retail transactions using MySQL, covering aggregations, joins, window functions, and CTEs.

## Project Overview

This project demonstrates core SQL skills required for Data Analyst roles — from basic aggregations to advanced window functions and CTEs — applied to a real-world retail sales dataset.

## Dataset

**Source:** Kaggle — Superstore Sales Dataset  
**Size:** 1,000+ transactions  
**Period:** 2015–2018  

| Column | Description |
|--------|-------------|
| order_id | Unique order identifier |
| order_date | Date of purchase |
| ship_mode | Shipping class |
| customer_name | Customer name |
| segment | Customer segment |
| region | US sales region |
| category | Product category |
| sub_category | Product sub-category |
| product_name | Product name |
| sales | Revenue per transaction |

## Tools

- MySQL 9.7
- MySQL Workbench

## SQL Skills Demonstrated

| Skill | Queries |
|-------|---------|
| Aggregations (SUM, COUNT, AVG) | Q1, Q2, Q3, Q4, Q5 |
| GROUP BY / ORDER BY / LIMIT | Q1–Q5 |
| COUNT DISTINCT | Q4 |
| Window Functions (SUM OVER, RANK) | Q6, Q7, Q8 |
| PARTITION BY | Q6, Q8 |
| CTEs (WITH clause) | Q9 |
| Date Functions (STR_TO_DATE, YEAR, MONTH) | Q10 |

## Queries & Key Insights

### Q1 — Sales by Category
Technology leads with highest revenue despite fewer orders than Office Supplies.

### Q2 — Top 10 Customers
Identified highest-value customers for targeted retention strategy.

### Q3 — Sales by Region
West region leads in total sales; South has lowest average order value.

### Q4 — Sales by Segment
Consumer segment drives most revenue; Corporate has highest avg order value.

### Q5 — Top 10 Products
Phones and Chairs are the top revenue-generating products.

### Q6 — Running Total by Region (Window Function)
Tracks cumulative sales growth within each region over time.

### Q7 — Customer Sales Ranking (Window Function)
Ranks all customers by total revenue using RANK() window function.

### Q8 — Sub-Category % of Category (Window Function)
Shows each sub-category's contribution to its parent category total.

### Q9 — High Value Orders (CTE)
Uses CTE to identify orders above average value; Technology dominates high-value orders.

### Q10 — Monthly Sales Trend
Revenue grows consistently year-on-year from 2015 to 2018.

## How to Run

1. Install MySQL Community Server
2. Open MySQL Workbench
3. Run `sales_analysis.sql`
4. Import `train.csv` using LOAD DATA INFILE

## Project Structure

```
sql-sales-analysis/
│
├── sales_analysis.sql    # All 10 queries
├── train.csv             # Raw dataset
└── README.md
```

## Author

**Adithyan Thirunavukkarasu**  
MSc Advanced Data Science & AI — University of Liverpool  
[LinkedIn](https://linkedin.com/in/adithyan-thirunavukkarasu) | [GitHub](https://github.com/adithyant-ds)
