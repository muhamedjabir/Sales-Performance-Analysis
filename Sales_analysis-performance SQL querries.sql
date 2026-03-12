CREATE DATABASE store;
USE store;

-- imported dataset by wizard --
SELECT * FROM super_store;

-- Total sales --

SELECT ROUND(SUM(Sales),2) AS Total_Sales
FROM super_store;

-- Total profit --

SELECT ROUND(SUM(Profit),2) AS Total_Profit
FROM super_store;

-- Total quantity sold --

SELECT SUM(Quantity) AS Total_Quantity
FROM super_store;

-- Total order sold --

SELECT COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM super_store;


-- Sales by category --

SELECT Category,
ROUND(SUM(Sales),2)AS Total_Sales
FROM super_store
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Profit by sub-category --

SELECT `Sub-Category`,
ROUND(SUM(Profit),2) AS Total_Profit
FROM super_store
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC;

-- Sales by region -- 

SELECT Region,
ROUND(SUM(Sales),2) AS Total_Sales
FROM super_store
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Top 10 cities by sales --

SELECT City,
ROUND(SUM(Sales),2) AS Total_Sales
FROM super_store
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top 10 product by sales --

SELECT `Product Name`,
ROUND(SUM(Sales),2) AS Total_Sales
FROM super_store
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Ship mode analysis --

SELECT `Ship Mode`,
COUNT(`Order ID`) AS Total_Orders
FROM super_store
GROUP BY `Ship Mode`
ORDER BY Total_Orders DESC;

-- profit margin --

SELECT Category,
ROUND((SUM(Profit) / SUM(Sales)) * 100,2) AS Profit_Margin
FROM super_store
GROUP BY Category
ORDER BY Profit_Margin DESC;

-- Rank cities by sales -- 

SELECT City,
ROUND(SUM(Sales),2) AS Total_Sales,
RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM super_store
GROUP BY City;

-- Running Total of Sales by Order Date--

SELECT `Order Date`,
ROUND(Daily_Sales,2) AS Daily_Sales,
ROUND(SUM(Daily_Sales) OVER (ORDER BY `Order Date`),2) AS Running_Total_Sales
FROM
(
    SELECT `Order Date`,
    SUM(Sales) AS Daily_Sales
    FROM super_store
    GROUP BY `Order Date`
) AS daily_sales
ORDER BY `Order Date`;

-- Top product in each category --

SELECT *
FROM (
SELECT `Category`,
`Product Name`,
SUM(Sales) AS Total_Sales,
ROW_NUMBER() OVER(
PARTITION BY `Category`
ORDER BY SUM(Sales) DESC
) AS Rank_In_Category
FROM super_store
GROUP BY `Category`, `Product Name`
) ranked_products
WHERE Rank_In_Category = 1;