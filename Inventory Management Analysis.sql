-- Use the created database
USE Posh_Palette;

-- How do you retrieve the total number of items in stock for each product?
select p.ProductID, p.ItemSubCategory, p.StartingInventory,
	p.StartingInventory - ifnull(SUM(o.NumberShipped), 0) As ItemInStocks
from products p
join orders o
	on p.ProductID = o.ProductID
group by p.ProductID, p.ItemSubCategory;


-- How can you find the names of products along with their supplier names?
select pd.ProductID, pd.ItemSubCategory, s.SupplierName
from products pd
join procurement p
	on p.ProductID = pd.ProductID
join suppliers s
	on p.SupplierID = s.SupplierID
order by pd.ProductID;

-- How do you get a list of all products that have never been ordered?
select p.ProductID, p.ItemSubCategory
from products p
left join orders o
	on p.ProductID = o.ProductID
where o.OrderID is NULL;

-- How can you list the products that need to be reordered by joining Products with Orders and checking 
-- if Item Numbers are below Minimum Required?
select p.ProductID, p.ItemSubCategory,
	p.StartingInventory - ifnull(SUM(o.NumberShipped), 0) As ItemInStocks, p.MinimumRequired
from products p
left join orders o
	on p.ProductID = o.ProductID
group by p.ProductID, p.ItemSubCategory, p.StartingInventory, p.MinimumRequired
having (p.StartingInventory - ifnull(SUM(o.NumberShipped), 0)) < p.MinimumRequired; 


-- How do you find the product with the highest price?
select ItemSubCategory, PricePerItem  from products
order by PricePerItem desc
limit 5;

-- Find the average price of products in each category?
with average_price AS(
	select ItemCategory, AVG(PricePerItem) as AveragePrice
    from products
    group by ItemCategory
    order by AveragePrice desc
)

select * from average_price;


-- Calculate the total sales for each product and then find products with sales greater than a specified amount?
with total_sales AS(
	select p.ProductID, p.ItemSubCategory, sum(o.NumberShipped * p.PricePerItem) as Total_price
    from products p 
    join orders o 
		on p.ProductID = o.ProductID
	group by p.ProductID, p.ItemSubCategory
)

select * from total_sales
order by Total_price desc;


-- How do you calculate the running total of sales for each product?
with data_table as (SELECT p.ProductID, p.ItemSubCategory, o.OrderDate, p.PricePerItem, o.NumberShipped, 
	(o.NumberShipped * p.PricePerItem) AS DailySales
from products p 
join orders o 
	on p.ProductID = o.ProductID
ORDER BY 
    p.ProductID, o.OrderDate)
    
select *,  Sum(DailySales) OVER (PARTITION BY p.ProductID ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalSales
from data_table ;
    

-- How can you find the rank of each product based on sales volume?
with total_sales AS(
	select p.ProductID, p.ItemSubCategory, sum(o.NumberShipped * p.PricePerItem) as Total_price
    from products p 
    join orders o 
		on p.ProductID = o.ProductID
	group by p.ProductID, p.ItemSubCategory
)

select *, rank() over (order by Total_price desc) as sales_rank, dense_rank() over (order by Total_price desc) as sales_dense_rank
from total_sales
order by Total_price desc;


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
order by SalesDifference;


-- How do you calculate the time difference between each order date and the corresponding delivery date?
SELECT o.OrderID, p.ProductID, p.ItemSubCategory, o.OrderDate,
    DATE_ADD(o.OrderDate, INTERVAL o.LeadTime DAY) AS DeliveryDate,
    o.LeadTime AS DaysDifference
FROM orders o
JOIN products p ON o.ProductID = p.ProductID
ORDER BY o.OrderDate
LIMIT 1000;


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


-- How do you compare the average price of products across different categories and find the highest-priced category?
SELECT p.ItemCategory, round(avg(o.NumberShipped * p.PricePerItem),2) AS AvgPrice
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ItemCategory
ORDER BY p.ItemCategory;


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