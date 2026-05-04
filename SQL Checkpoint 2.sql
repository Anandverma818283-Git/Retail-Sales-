USE retail_sales;

-- 1. Basic Data Exploration

-- Retrieve all records
SELECT * FROM product;

-- Products costing more than 50
SELECT productName, unitPrice 
FROM product 
WHERE unitPrice > 50;

-- Customers in Germany
SELECT * 
FROM customer 
WHERE location = 'Germany';


-- 2. Aggregations

-- Total orders
SELECT COUNT(*) AS total_orders 
FROM salesorder;

-- Average product price
SELECT AVG(unitPrice) AS avg_price 
FROM product;

-- Total revenue
SELECT SUM(unitPrice * quantity * (1 - discount)) AS total_revenue
FROM orderdetail;


-- 3. Joins

-- Product with category
SELECT p.productName, c.categoryName, p.unitPrice
FROM product p
JOIN category c ON p.categoryId = c.categoryId;

-- Customer orders
SELECT c.companyName, s.orderId, s.orderDate
FROM customer c
JOIN salesorder s ON c.custId = s.custId;

-- Employee performance
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employee_name,
       s.orderId,
       c.contactName
FROM employee e
JOIN salesorder s ON e.employeeId = s.employeeId
JOIN customer c ON s.custId = c.custId;


-- 4. Subqueries

-- Products above average price
SELECT productName
FROM product
WHERE unitPrice > (SELECT AVG(unitPrice) FROM product);

-- Customers with more than 5 orders
SELECT contactName
FROM customer
WHERE custId IN (
    SELECT custId
    FROM salesorder
    GROUP BY custId
    HAVING COUNT(orderId) > 5
);

-- Products never ordered 
SELECT p.productName
FROM product p
LEFT JOIN orderdetail o ON p.productId = o.productId
WHERE o.productId IS NULL;


-- 5. Window Functions

-- Rank products by price
SELECT productName, categoryId, unitPrice,
       RANK() OVER (PARTITION BY categoryId ORDER BY unitPrice DESC) AS price_rank
FROM product;

-- Running revenue 
WITH daily_revenue AS (
    SELECT s.orderDate,
           SUM(o.unitPrice * o.quantity * (1 - o.discount)) AS revenue
    FROM salesorder s
    JOIN orderdetail o ON s.orderId = o.orderId
    GROUP BY s.orderDate
)
SELECT orderDate,
       revenue,
       SUM(revenue) OVER (ORDER BY orderDate) AS running_total
FROM daily_revenue;


-- Top customers by revenue
SELECT c.contactName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue,
       RANK() OVER (ORDER BY SUM(od.unitPrice * od.quantity * (1 - od.discount)) DESC) AS customer_rank
FROM customer c
JOIN salesorder s ON c.custId = s.custId
JOIN orderdetail od ON s.orderId = od.orderId
GROUP BY c.custId, c.contactName;


-- 6. Advanced Queries

-- Highest revenue category
SELECT c.categoryName,
       SUM(o.unitPrice * o.quantity * (1 - o.discount)) AS total_revenue
FROM category c
JOIN product p ON c.categoryId = p.categoryId
JOIN orderdetail o ON p.productId = o.productId
GROUP BY c.categoryName
ORDER BY total_revenue DESC
LIMIT 1;

-- Customer with most orders 
SELECT c.contactName,
       COUNT(s.orderId) AS total_orders
FROM customer c
JOIN salesorder s ON c.custId = s.custId
GROUP BY c.contactName
ORDER BY total_orders DESC
LIMIT 1;

-- Employee with most orders
SELECT CONCAT(e.firstName, ' ', e.lastName) AS emp_name,
       COUNT(s.orderId) AS total_orders
FROM employee e
JOIN salesorder s ON e.employeeId = s.employeeId
GROUP BY e.employeeId, e.firstName, e.lastName
ORDER BY total_orders DESC
LIMIT 1;