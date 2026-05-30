/*
==========================================================
  PROJECT  : Zepto Product & Inventory Analysis
  TOOL     : PostgreSQL
  AUTHOR   : Mehwish Nisha Khan
  
  DESCRIPTION:
  This project analyzes Zepto's product catalog to uncover
  pricing trends, stock availability issues, discount patterns,
  and customer savings using SQL.
  
  SECTIONS:
  1. Data Exploration
  2. Data Cleaning
  3. Business Analysis (10 Queries)
==========================================================
*/


-- ==========================================================
-- SECTION 1: DATA EXPLORATION
-- ==========================================================

-- View a sample of the dataset to understand its structure
SELECT * FROM zepto LIMIT 10;

-- Count total number of product records in the dataset
SELECT COUNT(*) FROM zepto;

-- View all unique product categories available
SELECT DISTINCT category 
FROM zepto 
ORDER BY category;

-- Check how many products are in stock vs out of stock
SELECT outOfStock, COUNT(id) AS product_count
FROM zepto
GROUP BY outOfStock;


-- ==========================================================
-- SECTION 2: DATA CLEANING
-- ==========================================================

-- Check for any NULL values across all important columns
SELECT COUNT(*) AS null_count
FROM zepto
WHERE 
    name IS NULL OR 
    category IS NULL OR
    mrp IS NULL OR
    discountpercent IS NULL OR
    availablequantity IS NULL OR
    discountedsellingprice IS NULL OR
    weightingms IS NULL OR
    outOfStock IS NULL OR
    quantity IS NULL;

-- Check for duplicate product names
SELECT name, COUNT(*) 
FROM zepto
GROUP BY name 
HAVING COUNT(*) > 1;

-- Preview products with unrealistic or invalid data
-- (zero/negative prices or suspiciously high discounts)
SELECT name 
FROM zepto 
WHERE mrp <= 0 
   OR discountedsellingprice <= 0 
   OR discountpercent > 90;

-- Delete records with unrealistic/invalid data
DELETE FROM zepto 
WHERE mrp <= 0 
   OR discountedsellingprice <= 0 
   OR discountpercent > 90;

-- Preview prices before converting from paisa to rupees
SELECT name, mrp, discountedsellingprice 
FROM zepto 
ORDER BY name 
LIMIT 10;

-- Convert prices from paisa to rupees (divide by 100)
UPDATE zepto 
SET discountedsellingprice = discountedsellingprice / 100.0,
    mrp = mrp / 100.0;

-- Verify the conversion was applied correctly
SELECT * FROM zepto LIMIT 10;

-- Count products available per category after cleaning
SELECT category, COUNT(name) AS products 
FROM zepto
GROUP BY category 
ORDER BY products DESC;

-- Count total out of stock products
SELECT COUNT(id) 
FROM zepto
WHERE outOfStock = 'true';


-- ==========================================================
-- SECTION 3: BUSINESS ANALYSIS
-- ==========================================================

-- Q1: Which products are giving customers the best deals?
-- (Products with 50% or more discount)
SELECT name, discountpercent
FROM zepto 
WHERE discountpercent >= 50
ORDER BY discountpercent DESC;


-- Q2: Which products are currently unavailable to buy?
-- (Products marked as out of stock)
SELECT name
FROM zepto
WHERE outOfStock = 'True';


-- Q3: Which category has the most products overall?
SELECT category, COUNT(*) AS total_products
FROM zepto
GROUP BY category  
ORDER BY total_products DESC
LIMIT 1;


-- Q4: What is the typical price range in each category?
-- (Shows minimum, maximum and average discounted price)
SELECT 
    category,
    ROUND(MIN(discountedsellingprice)::numeric, 2) AS minimum_price,
    ROUND(MAX(discountedsellingprice)::numeric, 2) AS maximum_price,
    ROUND(AVG(discountedsellingprice)::numeric, 2) AS average_price
FROM zepto
GROUP BY category;


-- Q5: How much money are customers saving on each product?
-- (Difference between original MRP and discounted price)
SELECT DISTINCT 
    name,
    ROUND((mrp - discountedsellingprice)::numeric, 2) AS savings,
    ROUND(((mrp - discountedsellingprice) / NULLIF(mrp, 0) * 100)::numeric, 2) AS savings_percentage
FROM zepto
ORDER BY savings DESC;


-- Q6: Which category has the worst stock availability problem?
-- (Category with the highest number of out of stock products)
SELECT category, COUNT(*) AS out_of_stock_count
FROM zepto
WHERE outOfStock = 'True'
GROUP BY category
ORDER BY out_of_stock_count DESC
LIMIT 1;


-- Q7: Show all mid-range discounted products
-- (Discount between 20% and 50% - not too low, not too high)
SELECT name, discountpercent
FROM zepto
WHERE discountpercent BETWEEN 20 AND 50
ORDER BY discountpercent DESC;


-- Q8: Which category holds the most total value in inventory?
-- (Using RANK to handle categories with equal total value)
WITH ranked AS (
    SELECT 
        category,
        ROUND(SUM(mrp)::numeric, 2) AS total_inventory_value,
        RANK() OVER (ORDER BY SUM(mrp) DESC) AS rnk
    FROM zepto
    GROUP BY category
)
SELECT category, total_inventory_value
FROM ranked
WHERE rnk = 1;


-- Q9: Which categories are critically understocked?
-- (More than half of their products are out of stock)
SELECT 
    category,
    COUNT(*) AS total_products,
    SUM(CASE WHEN outofstock = 'true' THEN 1 ELSE 0 END) AS out_of_stock_count,
    ROUND((SUM(CASE WHEN outofstock = 'true' THEN 1 ELSE 0 END) * 100.0 / COUNT(*))::numeric, 2) AS out_of_stock_percentage
FROM zepto
GROUP BY category
ORDER BY out_of_stock_percentage DESC;


-- Q10: Top discounted products within each category
-- (Using DENSE_RANK to rank products by discount within their category)
WITH ranked AS (
    SELECT 
        category, 
        name, 
        discountpercent,
        DENSE_RANK() OVER(PARTITION BY category ORDER BY discountpercent DESC) AS rank
    FROM zepto
)
SELECT * 
FROM ranked
WHERE rank = 1;


-- ==========================================================
-- END OF PROJECT
-- ==========================================================
