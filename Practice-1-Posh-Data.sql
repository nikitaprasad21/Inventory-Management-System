-- Use the created database
USE Posh_Palette;

-- 1. Inventory Management
-- Write a query to identify products that are below their minimum required inventory level. 
-- Display the ItemName, ItemCategory, StartingInventory, and MinimumRequired.
SELECT ItemSubCategory, ItemCategory, StartingInventory, MinimumRequired
FROM products
WHERE StartingInventory < MinimumRequired;


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
    

-- 9. Order Fulfillment Efficiency
-- Write a query to determine which products have been shipped in less than the average lead time across all orders.
-- Display the ItemName, OrderID, and LeadTime.
WITH AvgLeadTime AS (
    SELECT AVG(o.LeadTime) AS OverallAverageLeadTime
    FROM Orders o
)
SELECT p.ItemSubCategory AS ItemName, o.OrderID, o.LeadTime
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
JOIN AvgLeadTime alt ON o.LeadTime < alt.OverallAverageLeadTime;
