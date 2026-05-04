📊 Sales Performance Analysis using SQL
🚀 Project Overview
This project focuses on analyzing sales performance, customer behavior, and product insights using a Retail_Sales database.
The goal is to demonstrate strong SQL skills by solving real-world business problems using:


Joins


Aggregations


Subqueries


Window Functions



🎯 Objective


Explore relational datasets


Perform data analysis using SQL


Generate actionable business insights


Build a structured analytical report



🗂️ Dataset Description
The project uses a Retail Sales Database with the following tables:
Table NameDescriptionCustomerCustomer detailsEmployeeEmployee informationProductProduct detailsCategoryProduct categoriesSupplierSupplier detailsSalesOrderCustomer ordersOrderDetailOrder itemsShipperShipping details

🛠️ Skills & Concepts Used


SQL SELECT statements


Filtering (WHERE)


Aggregations (SUM, AVG, COUNT)


GROUP BY & HAVING


INNER JOIN / LEFT JOIN


Subqueries


Window Functions (RANK, RUNNING TOTAL)



📈 Key Analysis Performed
🔹 1. Basic Data Exploration


Retrieved all products


Filtered high-value products (> $50)


Identified customers from specific regions



🔹 2. Aggregations & Metrics


Total number of orders


Average product price


Total revenue calculation:


Revenue = UnitPrice × Quantity × (1 - Discount)

🔹 3. Join-Based Analysis


Product + Category insights


Customer order history


Employee sales performance



🔹 4. Subqueries


Products priced above average


High-frequency customers (>5 orders)


Products never ordered



🔹 5. Window Functions


📊 Product ranking within categories


📈 Running total of sales over time


🏆 Top customers by revenue



🔹 6. Advanced Business Insights


Highest revenue-generating category


Most active customer


Top-performing employee



📌 Sample Query (Running Total)
WITH daily_revenue AS (    SELECT         s.OrderDate,        SUM(o.UnitPrice * o.Quantity * (1 - o.Discount)) AS revenue    FROM SalesOrder s    JOIN OrderDetail o ON s.OrderID = o.OrderID    GROUP BY s.OrderDate)SELECT     OrderDate,    revenue,    SUM(revenue) OVER (ORDER BY OrderDate) AS running_totalFROM daily_revenue;

📷 Project Screenshots
Add your screenshots here
Example:


Query results


SQL Workbench output


Charts (if created in Excel/Power BI)



🧪 How to Run the Project


Open MySQL Workbench


Import the Retail_Sales database


Run the .sql script file


View results in output panel



📁 Project Structure
📦 Sales-Analysis-SQL ┣ 📜 queries.sql ┣ 📊 screenshots/ ┣ 📄 README.md

💡 Key Insights


Revenue trends vary by time and product category


A small group of customers contributes most revenue


Certain employees handle a higher share of orders



📌 Tools Used


MySQL / MySQL Workbench






Just tell me 👍
