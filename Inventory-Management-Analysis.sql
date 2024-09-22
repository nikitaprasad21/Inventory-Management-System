-- Use the created database
USE Posh_Palette;

-- 1. Inventory Management
-- Write a query to identify products that are below their minimum required inventory level. 
SELECT ItemSubCategory, ItemCategory, StartingInventory, MinimumRequired
FROM products
WHERE StartingInventory < MinimumRequired;

-- How do you retrieve the total number of items in stock for each product?
SELECT p.ProductID, p.ItemSubCategory, p.StartingInventory,
	p.StartingInventory - ifnull(SUM(o.NumberShipped), 0) AS ItemInStocks
FROM products p
JOIN orders o
	ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ItemSubCategory;

-- How can you list the products that need to be reordered by joining Products with Orders and checking 
-- if Item Numbers are below Minimum Required?
SELECT p.ProductID, p.ItemSubCategory,
	p.StartingInventory - ifnull(SUM(o.NumberShipped), 0) AS ItemInStocks, p.MinimumRequired
from products p
LEFT JOIN orders o
	ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ItemSubCategory, p.StartingInventory, p.MinimumRequired
HAVING (p.StartingInventory - ifnull(SUM(o.NumberShipped), 0)) < p.MinimumRequired; 

-- How do you get a list of all products that have never been ordered?
SELECT p.ProductID, p.ItemSubCategory
FROM products p
LEFT JOIN orders o
	ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

-- How can you find the reorder point for each product based on average sales and lead time, which helps
-- in determining when to place new orders to avoid stockouts?
-- Step 1: Calculate average daily sales for each product
WITH AverageDailySales AS (
    SELECT o.ProductID, AVG(o.NumberShipped) AS AvgDailySales
    FROM Orders o
    GROUP BY o.ProductID
),

-- Step 2: Retrieve the lead time for each product
LeadTimePerProduct AS (
    SELECT p.ProductID, AVG(o.LeadTime) AS AvgLeadTime
    FROM Orders o
    JOIN Products p ON o.ProductID = p.ProductID
    GROUP BY p.ProductID
)

-- Step 3: Calculate the reorder point for each product
SELECT a.ProductID, p.ItemSubCategory, a.AvgDailySales, l.AvgLeadTime, (a.AvgDailySales * l.AvgLeadTime) AS ReorderPoint
FROM AverageDailySales a
JOIN LeadTimePerProduct l ON a.ProductID = l.ProductID
JOIN Products p ON a.ProductID = p.ProductID
ORDER BY a.ProductID;



-- 2. Sales Revenue Calculation
-- Calculate the total revenue generated from all orders. For each product, display the ItemName, TotalQuantitySold, and TotalRevenue. 
-- Assume that the PricePerItem in the Products table is the current price for all orders.
SELECT p.ItemSubCategory, p.ItemCategory, SUM(o.NumberShipped) AS TotalQuantitySold,
SUM(o.NumberShipped * p.PricePerItem) AS TotalRevenue
FROM products p
JOIN orders o 
ON p.ProductID = o.ProductID
GROUP BY p.ItemSubCategory, p.ItemCategory
ORDER BY TotalRevenue;

-- Calculate the total sales for each product and then find products with sales greater than a specified amount?
with total_sales AS(
	select p.ProductID, p.ItemSubCategory, sum(o.NumberShipped * p.PricePerItem) as Total_price
    from products p 
    join orders o 
		on p.ProductID = o.ProductID
	group by p.ProductID, p.ItemSubCategory
)

SELECT * from total_sales
ORDER BY Total_price desc;

-- How do you calculate the running total of sales for each product?
with data_table as (SELECT p.ProductID, p.ItemSubCategory, o.OrderDate, p.PricePerItem, o.NumberShipped, 
	(o.NumberShipped * p.PricePerItem) AS DailySales
from products p 
join orders o 
	on p.ProductID = o.ProductID
ORDER BY 
    p.ProductID, o.OrderDate)
    
SELECT *,  Sum(DailySales) OVER (PARTITION BY p.ProductID ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalSales
from data_table ;



-- 3. Supplier Performance
-- Write a query to find the total quantity of products supplied by each supplier. Display the SupplierName and TotalQuantitySupplied.
SELECT s.SupplierName, SUM(p.NumberReceived) AS TotalQuantitySupplied, SUM(o.NumberShipped) AS TotalQuantitySold
FROM suppliers s
JOIN procurement p
    ON s.SupplierID = p.SupplierID
JOIN orders o
    ON p.ProductID = o.ProductID
GROUP BY s.SupplierName
ORDER BY TotalQuantitySupplied DESC;

-- How can you find the names of products along with their supplier names?
SELECT pd.ProductID, pd.ItemSubCategory, s.SupplierName
FROM products pd
JOIN procurement p
	ON p.ProductID = pd.ProductID
JOIN suppliers s
	On p.SupplierID = s.SupplierID
ORDER BY pd.ProductID;



-- 4. Price History Analysis
-- For each product, display the ItemName, EffectiveDate, and the difference between the current price and the price on that EffectiveDate.
--  The current price is the most recent price in the HistoricalPricing table.
WITH current_price AS (
SELECT ProductID, Price AS CurrentPrice FROM historicalpricing
WHERE EffectiveDate = ( SELECT MAX(EffectiveDate) FROM HistoricalPricing hp 
            WHERE hp.ProductID = HistoricalPricing.ProductID)
)

SELECT p.ItemSubCategory, hp.EffectiveDate, cp.CurrentPrice, hp.Price, (cp.CurrentPrice - hp.Price)AS PriceDifference
FROM products p
JOIN historicalpricing hp 
ON p.ProductID = hp.ProductID
JOIN current_price cp
ON hp.ProductID = cp.ProductID
ORDER BY p.ItemSubCategory, hp.EffectiveDate;

-- How do you find the product with the highest price?
SELECT ItemSubCategory, PricePerItem  from products
order by PricePerItem desc
limit 5;

-- Find the average price of products in each category?
with average_price AS(
	select ItemCategory, AVG(PricePerItem) as AveragePrice
    from products
    group by ItemCategory
    ORDER BY AveragePrice desc
)

SELECT * from average_price;



-- 5. Lead Time Analysis
-- Calculate the average lead time for orders by ItemCategory. Display the ItemCategory and AverageLeadTime.
SELECT p.ItemSubCategory,  AVG(o.LeadTime) AS AverageLeadTime
FROM  products p
JOIN orders o 
ON p.ProductID = o.ProductID
GROUP BY p.ItemSubCategory;


-- 6. Order Volume by Month
-- Write a query to find the total number of orders placed each month for the last year. Display the Month, Year, and TotalOrders.
SELECT MONTH(o.OrderDate) AS order_month, YEAR(o.OrderDate) AS order_year, SUM(o.OrderID) AS TotalOrders
FROM orders o
GROUP BY MONTH(o.OrderDate), YEAR(o.OrderDate)
ORDER BY TotalOrders;



-- 7. Procurement Cost Analysis
-- Calculate the total amount spent on procuring each product. Display the ItemName, TotalQuantityReceived, and
-- TotalAmountSpent (which is the sum of NumberReceived * PricePerUnit).
SELECT p.ItemSubCategory AS ItemName, proc.NumberReceived AS TotalQuantityReceived,
  SUM(proc.NumberReceived * p.PricePerItem) AS TotalAmountSpent
FROM products p
JOIN procurement proc
ON p.ProductId = proc.ProductID
GROUP BY p.ItemSubCategory, proc.NumberReceived
ORDER BY TotalAmountSpent;



-- 8. Supplier Contact Information
-- Write a query to identify suppliers that have missing or incomplete contact information
-- (e.g., SupplierEmail or SupplierPhone is null or has an invalid length). Display the SupplierName, SupplierEmail, and SupplierPhone.
SELECT SupplierName, SupplierEmail, SupplierPhone
FROM Suppliers
WHERE SupplierEmail IS NULL OR SupplierEmail NOT REGEXP '^[a-zA-Z0-9._%+-]+@gmail\\.com$' OR SupplierPhone IS NULL OR LENGTH(SupplierPhone) < 10;



-- 9. Sales Performance:
-- How can you find the rank of each product based on sales volume?
with total_sales AS(
	SELECT p.ProductID, p.ItemSubCategory, sum(o.NumberShipped * p.PricePerItem) AS Total_price
    from products p 
    join orders o 
		on p.ProductID = o.ProductID
	group by p.ProductID, p.ItemSubCategory
)

SELECT *, rank() over (ORDER BY Total_price  DESC) AS sales_rank, dense_rank() over (ORDER BY Total_price  DESC) AS sales_dense_rank
FROM total_sales
ORDER BY Total_price DESC;

-- How can you calculate the difference in sales between each product and the product with the next highest sales?
WITH product_sales AS (
    SELECT p.ProductID, SUM(o.NumberShipped * p.PricePerItem) AS TotalSales
    FROM products p
    JOIN orders o 
		ON p.ProductID = o.ProductID
    GROUP BY p.ProductID),
next_highest_sales AS (
    SELECT ProductID, TotalSales,
        LEAD(TotalSales) OVER (ORDER BY TotalSales) AS NextHighestSales
    FROM product_sales
)
SELECT p.ProductID, p.ItemSubCategory, ps.TotalSales, nhs.NextHighestSales,
    nhs.NextHighestSales - ps.TotalSales AS SalesDifference
FROM products p
JOIN product_sales ps 
	ON p.ProductID = ps.ProductID
JOIN next_highest_sales nhs 
	ON ps.ProductID = nhs.ProductID
ORDER BY SalesDifference;



-- 10. Order Fulfillment Efficiency
-- Write a query to determine which products have been shipped in less than the average lead time across all orders.
WITH AvgLeadTime AS (
    SELECT AVG(o.LeadTime) AS OverallAverageLeadTime
    FROM Orders o
)
SELECT p.ItemSubCategory AS ItemName, o.OrderID, o.LeadTime
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
JOIN AvgLeadTime alt ON o.LeadTime < alt.OverallAverageLeadTime;

-- How do you calculate the time difference between each order date and the corresponding delivery date?
SELECT o.OrderID, p.ProductID, p.ItemSubCategory, o.OrderDate,
    DATE_ADD(o.OrderDate, INTERVAL o.LeadTime DAY) AS DeliveryDate,
    o.LeadTime AS DaysDifference
FROM orders o
JOIN products p ON o.ProductID = p.ProductID
ORDER BY o.OrderDate
LIMIT 1000;



-- 11. Price History Analysis:
-- How can you track the price changes of a specific product over the last year using historical pricing data?
-- (OR)
-- How can you identify seasonal trends in product sales using historical sales data?
SELECT hp2024.ProductID, p.ItemSubCategory, hp2024.Price AS Price2024, hp2023.Price AS Price2023, hp2022.Price AS Price2022, 
    ROUND(((hp2023.Price - hp2022.Price) / hp2022.Price) * 100, 2) AS PercentageIncrease2022To2023,
    ROUND(((hp2024.Price - hp2023.Price) / hp2023.Price) * 100, 2) AS PercentageIncrease2023To2024
FROM Products p
JOIN HistoricalPricing hp2024 
	ON p.ProductID = hp2024.ProductID AND YEAR(hp2024.EffectiveDate) = 2024
LEFT JOIN HistoricalPricing hp2023 
	ON p.ProductID = hp2023.ProductID AND YEAR(hp2023.EffectiveDate) = 2023
LEFT JOIN HistoricalPricing hp2022 
	ON p.ProductID = hp2022.ProductID AND YEAR(hp2022.EffectiveDate) = 2022
WHERE hp2024.EffectiveDate IS NOT NULL
ORDER BY hp2024.ProductID;



-- 12. Sales Forecasting:
-- How do you generate a sales forecast for the next quarter based on historical sales trends?
WITH QuarterlySales AS (
    SELECT p.ItemCategory, SUM(o.NumberShipped * p.PricePerItem) AS TotalSales
    FROM Orders o
    JOIN Products p ON o.ProductID = p.ProductID
    GROUP BY p.ItemCategory
),
AverageQuarterlySales AS (
    SELECT ItemCategory, TotalSales, AVG(TotalSales) AS AvgQuarterlySales
    FROM QuarterlySales
    GROUP BY ItemCategory
)
SELECT a.ItemCategory, a.TotalSales, a.AvgQuarterlySales AS ForecastedSalesNextQuarter
FROM AverageQuarterlySales a
ORDER BY a.AvgQuarterlySales desc;



-- 13. Price Comparison:
-- How do you compare the average price of products across different categories and find the highest-priced category?
SELECT p.ItemCategory, round(avg(o.NumberShipped * p.PricePerItem),2) AS AvgPrice
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ItemCategory
ORDER BY p.ItemCategory;
