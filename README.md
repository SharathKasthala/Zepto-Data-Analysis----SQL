# Zepto Data Analysis SQL Project

## Project Overview

**Project Title**: Zepto Data Analysis  
**Database**: `zepto`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a real-world database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values and converting paise to ₹.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset and stock.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the stock or inventory data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `zepto`.
- **Table Creation**: A table named `zepto` is created to store the sales data. The table structure includes columns for sku_id, category, name, mrp, discountPercent, availableQuantity, discountedSellingPrice, weightInGms, outOfStock, quantity


```sql
CREATE DATABASE zepto ;

drop table if exists zepto;

create table zepto (
	sku_id SERIAL PRIMARY KEY,
	category varchar(150),
	name varchar(250) not null,
	mrp numeric(8,2),
	discountPercent numeric(5,2),
	availableQuantity INTEGER,
	discountedSellingPrice numeric(8,2),
	weightInGms INTEGER,
	outOfStock Boolean,
	quantity INTEGER
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Product Count**: Find out how many products are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- View full dataset
SELECT * FROM zepto;

-- Count rows
SELECT COUNT(*) FROM zepto;

-- Find null values
SELECT * FROM zepto
WHERE category IS NULL
   OR name IS NULL OR mrp IS NULL OR discountPercent IS NULL OR availableQuantity IS NULL 
   OR discountedSellingPrice IS NULL OR weightInGms IS NULL OR outOfStock IS NULL OR quantity IS NULL;

-- Product categories
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

-- Products with invalid prices
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Remove invalid rows
DELETE FROM zepto 
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Convert prices from paise → ₹
UPDATE zepto 
SET mrp = mrp/100.00,
    discountedSellingPrice = discountedSellingPrice/100.00;

-- Verify
SELECT mrp, discountedSellingPrice 
FROM zepto;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:
```sql
-- Q1. Top 10 best-value products by discount %
SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. High-MRP products that are Out of Stock
SELECT DISTINCT name, mrp
FROM zepto 
WHERE outOfStock IS TRUE AND mrp >= 100
ORDER BY mrp DESC;

-- Q3. Estimated Revenue by category
SELECT category, SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4. Expensive products (MRP > ₹500, discount < 10%)
SELECT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Top 5 categories with highest avg discount
SELECT category, ROUND(AVG(discountPercent), 2) AS average_discount
FROM zepto
GROUP BY category
ORDER BY average_discount DESC
LIMIT 5;

-- Q6. Price per gram (for products >100g)
SELECT name, ROUND(discountedSellingPrice/weightInGms, 2) AS price_per_gram 
FROM zepto 
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;

-- Q7. Categorize products by weight
SELECT DISTINCT name, weightInGms,
  CASE 
    WHEN weightInGms < 1000 THEN 'Light'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
  END AS weight_category
FROM zepto
ORDER BY weightInGms DESC;

-- Q8. Total Inventory Weight per Category
SELECT category,
       SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight DESC;

-- Q9. Top 5 products by margin (MRP - discounted price)
SELECT DISTINCT name,
       mrp, discountedSellingPrice,
       ROUND(mrp - discountedSellingPrice, 2) AS margin
FROM zepto 
ORDER BY margin DESC
LIMIT 5;

-- Q10. Top 10 revenue-contributing products
SELECT name, SUM(discountedSellingPrice * availableQuantity) AS revenue
FROM zepto
GROUP BY name
ORDER BY revenue DESC
LIMIT 10;
```

## Findings

- Identified top discounted products and high-MRP items that were out of stock, showing missed revenue opportunities.
- Estimated category-wise revenue and revealed that a few categories drive the majority of sales.
- Found top revenue-contributing products and highest-margin items, highlighting areas of profitability.
- Segmented inventory by weight and value-for-money, useful for pricing, storage, and logistics strategy.





## Conclusion

This project demonstrates how SQL can transform messy, real-world e-commerce data into clear, actionable business insights. It highlights my skills in data cleaning, exploratory data analysis (EDA), and business analytics, directly applicable to Data Analyst roles.
- Beyond technical SQL queries, the project shows how data analysis can drive better pricing, stocking, and revenue decisions for an e-commerce business.
## How to Use
🛠️ How to Reproduce

Clone the repository:
```
git clone https://github.com/SharathKasthala/Zepto-Data-Analysis-SQL-Project.git
cd Zepto-Data-Analysis-SQL-Project

```
- Import dataset (zepto_v2.csv) into PostgreSQL (UTF-8 format)
- Run the SQL file step by step in pgAdmin or any SQL client

**👨‍💻 About Me**
- Hi, I’m Sharath Kasthala 👋 — an aspiring Data Analyst passionate about SQL, analytics, and solving business problems with data.
- This project demonstrates my ability to:
- Build & clean databases
- Perform SQL-based EDA
- Write business-focused analytical queries

**📌 Let’s connect:**
💼 LinkedIn: https://www.linkedin.com/in/sharathchandrakasthala/

📧 Email: sharathkasthala@gmail.com
