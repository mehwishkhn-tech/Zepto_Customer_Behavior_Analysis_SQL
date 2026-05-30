# Zepto_Customer_Behavior_Analysis_SQL
# zepto_inventory_SQL_Analysis
SQL-based analysis of Zepto's product catalog covering pricing, stock availability, discounts and customer savings using PostgreSQL
# 🛒 Zepto Product & Inventory Analysis


## 📌 Project Overview
This project performs an end-to-end SQL analysis of Zepto's product catalog.
It covers data exploration, data cleaning, and answers 10 key business questions
related to pricing, stock availability, discounts, and customer savings.

---

## 🛠️ Tools Used
- PostgreSQL
- Excel (for raw dataset)

---

## 📁 Dataset
| Column | Description |
|---|---|
| category | Product category/department |
| name | Product name |
| mrp | Original price (in rupees) |
| discountpercent | Discount percentage |
| discountedsellingprice | Final price after discount |
| outOfStock | Whether product is available |
| availablequantity | Quantity available |
| weightingms | Product weight |
| quantity | Quantity details |

---

## 📂 Project Structure
```
zepto-sql-analysis/
│
├── zepto_analysis.sql    -- All SQL queries (exploration, cleaning, analysis)
├── README.md             -- Project documentation
└── dataset/
    └── zepto_data.xlsx   -- Raw dataset
```

---

## 🔍 Project Sections

### 1. Data Exploration
- Viewing sample data
- Counting total records
- Checking categories
- Stock vs out of stock count

### 2. Data Cleaning
- Null value check
- Duplicate detection
- Removing invalid/unrealistic data
- Converting prices from paisa to rupees

### 3. Business Analysis (10 Questions)

| # | Question |
|---|---|
| Q1 | Which products give customers the best deals? |
| Q2 | Which products are currently unavailable? |
| Q3 | Which category has the most products? |
| Q4 | What is the price range in each category? |
| Q5 | How much are customers saving per product? |
| Q6 | Which category has the worst stock problem? |
| Q7 | Which products have mid-range discounts? |
| Q8 | Which category holds the most inventory value? |
| Q9 | Which categories are critically understocked? |
| Q10 | Top discounted products within each category? |

---

## 📊 Key Findings & Insights

| # | Business Question | Finding |
|---|---|---|
| Q1 | Best deals for customers | 58 products offer 50%+ discount — great value for customers |
| Q2 | Unavailable products | 453 products are currently out of stock |
| Q3 | Largest category | Cooking Essentials dominates with 514 products |
| Q4 | Price range per category | 14 categories identified; average discounted price is around ₹1–₹2 |
| Q5 | Customer savings | Across 1,777 products, customers save between ₹1–₹212 with savings % ranging from 9% to 30% |
| Q6 | Worst stock availability | Cooking Essentials has the highest out of stock count with 64 unavailable products |
| Q7 | Mid-range discounts | 343 products fall in the mid-range discount bracket (20%–50%) |
| Q8 | Highest inventory value | Cooking Essentials and Munchies are tied for the highest total inventory value |
| Q9 | Critically understocked | No category has more than 50% out of stock — overall stock health is positive! ✅ |
| Q10 | Top discounts per category | Most top-ranked products across categories like Beverages and Biscuits offer 50%+ discounts |

### 🔑 Overall Insights:
- **Cooking Essentials** is the most dominant category — largest product range, highest inventory value, but also the most stock availability issues
- **Stock health is overall positive** — no single category is critically understocked
- **Customers get the best value** in categories offering 50%+ discounts like Beverages and Biscuits
- **Mid-range discounts (20–50%)** cover 343 products giving customers a wide variety of deals

---

## 💡 Key SQL Concepts Used
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- Filtering: `WHERE`, `HAVING`
- Grouping: `GROUP BY`
- Window functions: `DENSE_RANK()`, `RANK()`, `PARTITION BY`
- CTEs: `WITH ... AS`
- Data manipulation: `UPDATE`, `DELETE`
- Null safety: `NULLIF()`
- Type casting: `::numeric`

---


## 👤 Author
Mehwish Nisha Khan  
www.linkedin.com/in/mehwish-nisha-khan-056509279 | [GitHub](https://github.com/mehwishkhn-tech)
