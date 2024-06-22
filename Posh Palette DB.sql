-- Drop the database if it already exists
DROP DATABASE IF EXISTS Posh_Palette;

-- Create the database
CREATE DATABASE Posh_Palette;

-- Use the created database
USE Posh_Palette;

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(50) NOT NULL,
    ItemCategory VARCHAR(50) NOT NULL,
    ItemSubCategory VARCHAR(50) NOT NULL,
    ItemNumber INT,
    StartingInventory INT,
    MinimumRequired INT,
    PricePerItem DECIMAL(5, 2) NOT NULL
    );
    
-- Create the Orders table
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ProductID INT,
    Size VARCHAR(10),
    NumberShipped INT NOT NULL,
    OrderDate DATE NOT NULL,
    LeadTime INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
    
    
-- Create the Suppliers table
CREATE TABLE Suppliers(
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(500) NOT NULL,
    SupplierEmail VARCHAR(5),
    SupplierPhone VARCHAR(10)
);

    
-- Create the Procurement table
CREATE TABLE Procurement (
    ProcurementID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT,
    ProductID INT,
    NumberReceived INT NOT NULL,
    PurchaseDate DATE NOT NULL,
    PricePerUnit DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Create the Historical Pricing table
CREATE TABLE HistoricalPricing (
    HistoricalPriceID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    Price DECIMAL(5, 2) NOT NULL,
    EffectiveDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Alter  Products table
ALTER TABLE Products DROP COLUMN ItemName;

ALTER TABLE Products
MODIFY COLUMN PricePerItem DECIMAL(10, 2) NOT NULL;

-- Insert data into Products table
INSERT INTO Products (ProductID, ItemCategory, ItemSubcategory, ItemNumber, StartingInventory, MinimumRequired, PricePerItem)
VALUES 
(1, 'Indian wear', 'Kurta', 50, 100, 20, 800),
(2, 'Indian wear', 'Sari', 20, 80, 15, 1500),
(3, 'Western wear', 'Jumpsuit', 40, 90, 18, 1800),
(4, 'Western wear', 'Dress', 50, 110, 22, 1000),
(5, 'Accessories', 'Wallet', 30, 90, 18, 800),
(6, 'Western wear', 'Top', 60, 130, 26, 600),
(7, 'Western wear', 'Shirt', 45, 95, 19, 900),
(8, 'Bottom wear', 'Pant', 40, 85, 17, 800),
(9, 'Bottom wear', 'Cullotes', 35, 75, 15, 700),
(10, 'Bottom wear', 'Leggings', 70, 110, 22, 600),
(11, 'Bottom wear', 'Shorts', 100, 120, 24, 500),
(12, 'Bottom wear', 'Skirt', 50, 100, 20, 1000),
(13, 'Hand bags', 'Sling', 40, 90, 18, 1200),
(14, 'Hand bags', 'Tote', 30, 80, 16, 1500),
(15, 'Hand bags', 'Clutch', 20, 70, 14, 800),
(16, 'Hand bags', 'Potli', 50, 85, 17, 900),
(17, 'Jewellery', 'Earrings', 74, 150, 30, 300),
(18, 'Jewellery', 'Anklet', 58, 130, 26, 400),
(19, 'Jewellery', 'Necklace', 56, 110, 22, 700),
(20, 'Jewellery', 'Bangle', 20, 120, 24, 600),
(21, 'Jewellery', 'Rings', 25, 100, 20, 500),
(22, 'Accessories', 'Belts', 35, 80, 16, 900)
;


-- Alter  Procurement table
ALTER TABLE Procurement
MODIFY COLUMN PricePerUnit DECIMAL(10, 2) NOT NULL;

-- Alter  Procurement table
ALTER TABLE HistoricalPricing
MODIFY COLUMN Price DECIMAL(10, 2) NOT NULL;

-- Alter  Suppliers table
ALTER TABLE Suppliers
MODIFY COLUMN SupplierEmail VARCHAR(25);

-- Insert data into Suppliers table
INSERT INTO Suppliers (SupplierID, SupplierName, SupplierEmail,	SupplierPhone)
VALUES
	(1,	'Ethnic Threads',	'ethnicthreads@google.com', '9876543210'),
	(2,	'Fashion Avenue',	'fashionavenue@google.com', '8765432109'),
	(3, 'Trendy Chic', 'trendychic@google.com', '7654321098'),
	(4,	'Accessorize Now', 'accessorizenow@google.com', '6543210987')
;

SELECT * FROM Suppliers;

SELECT * FROM products;


DROP TABLE Orders;
SELECT * FROM Orders;

TRUNCATE TABLE Orders;

-- Inserting orders data for each day from February 2024 to April 2024

-- February 2024
INSERT INTO Orders (FirstName, LastName, ProductID, Size, NumberShipped, OrderDate, LeadTime)
VALUES
    -- Day 1 (Feb 1, 2024)
    ('Navya', 'Mehta', 14, 'Free', 2, '2024-02-01', 4),
    ('Navya', 'Mehta', 2, 'Free', 1, '2024-02-01', 4),
    ('Navya', 'Mehta', 1, 'L', 1, '2024-02-01', 4),
    ('Navya', 'Mehta', 10, 'L', 1, '2024-02-01', 4),
    ('Vaani', 'Gupta', 11, 'XXL', 2, '2024-02-01', 3),
    ('Diya', 'Kumar', 12, 'XS', 1, '2024-02-01', 4),
    ('Diya', 'Kumar', 11, 'XS', 1, '2024-02-01', 4),
    ('Anushka', 'Mehta', 10, 'M', 2, '2024-02-01', 4),
    ('Anushka', 'Mehta', 1, 'M', 1, '2024-02-01', 4),
    ('Anushka', 'Mehta', 3, 'M', 1, '2024-02-01', 4),
    ('Anushka', 'Mehta', 4, 'M', 1, '2024-02-01', 4),
    ('Advika', 'Patel', 19, 'Free', 2, '2024-02-01', 2),
    ('Advika', 'Patel', 1, 'XS', 2, '2024-02-01', 2),
    ('Advika', 'Patel', 2, 'Free', 1, '2024-02-01', 2),
    ('Advika', 'Patel', 5, 'Free', 1, '2024-02-01', 2),
    ('Aadhya', 'Reddy', 6, 'XL', 1, '2024-02-01', 4),
    ('Aaradhya', 'Reddy', 7, 'L', 1, '2024-02-01', 2),
    ('Ishika', 'Kumar', 3, 'XL', 1, '2024-02-01', 4),
    ('Ishika', 'Kumar', 7, 'XL', 1, '2024-02-01', 4),
    ('Ishika', 'Kumar', 8, 'XL', 1, '2024-02-01', 4),
    ('Anika', 'Mehta', 18, 'Free', 2, '2024-02-01', 3),
    ('Aadhya', 'Reddy', 5, 'Free', 2, '2024-02-01', 4),
    
    -- Day 2 (Feb 2, 2024)
    ('Advika', 'Patel', 19, 'Free', 2, '2024-02-02', 2),
    ('Advika', 'Patel', 1, 'XS', 2, '2024-02-02', 2),
    ('Advika', 'Patel', 2, 'Free', 1, '2024-02-02', 2),
    ('Advika', 'Patel', 5, 'Free', 1, '2024-02-02', 2),
    ('Aadhya', 'Reddy', 6, 'XL', 1, '2024-02-02', 4),
    ('Aaradhya', 'Reddy', 7, 'L', 1, '2024-02-02', 2),
    ('Ishika', 'Kumar', 3, 'XL', 1, '2024-02-02', 4),
    ('Ishika', 'Kumar', 7, 'XL', 1, '2024-02-02', 4),
    ('Ishika', 'Kumar', 8, 'XL', 1, '2024-02-02', 4),
    ('Anika', 'Mehta', 18, 'Free', 2, '2024-02-02', 3),
    ('Aadhya', 'Reddy', 5, 'Free', 2, '2024-02-02', 4),
    
        -- Day 3 (Feb 3, 2024)
    ('Navya', 'Mehta', 14, 'Free', 1, '2024-02-03', 4),
    ('Vaani', 'Gupta', 11, 'XL', 2, '2024-02-03', 3),
    ('Diya', 'Kumar', 12, 'XS', 1, '2024-02-03', 4),
    ('Anushka', 'Mehta', 10, 'M', 2, '2024-02-03', 4),
    ('Advika', 'Patel', 19, 'Free', 2, '2024-02-03', 2),
    ('Aadhya', 'Reddy', 6, 'XL', 1, '2024-02-03', 4),
    ('Aaradhya', 'Reddy', 7, 'L', 1, '2024-02-03', 2),
    ('Ishika', 'Kumar', 3, 'XL', 1, '2024-02-03', 4),
    ('Anika', 'Mehta', 18, 'Free', 2, '2024-02-03', 3),
    ('Saanvi', 'Patel', 8, 'XS', 2, '2024-02-03', 4),
    ('Ishani', 'Mehta', 2, 'M', 2, '2024-02-03', 3),
    ('Sara', 'Jain', 17, 'XXL', 1, '2024-02-03', 3),
    ('Myra', 'Verma', 14, 'Free', 1, '2024-02-03', 2),
    ('Saanvi', 'Kumar', 16, 'XXS', 1, '2024-02-03', 3),
    ('Ananya', 'Gupta', 1, 'S', 1, '2024-02-03', 3),
    ('Aadhya', 'Sharma', 7, 'S', 1, '2024-02-03', 4),
    ('Sara', 'Verma', 4, 'M', 1, '2024-02-03', 2),
    ('Ishani', 'Jain', 5, 'Free', 2, '2024-02-03', 4),
    ('Advika', 'Jain', 3, 'XL', 1, '2024-02-03', 3),
    ('Myra', 'Sharma', 6, 'XXS', 1, '2024-02-03', 4),
    ('Zara', 'Sharma', 10, 'XS', 2, '2024-02-03', 2),
    
    ('Saanvi', 'Kumar', 16, 'Free', 1, '2024-02-04', 3),
    ('Aadhya', 'Mehta', 13, 'Free', 1, '2024-02-04', 2),
    ('Myra', 'Sharma', 6, 'XXS', 1, '2024-02-04', 4),
    ('Ananya', 'Gupta', 1, 'S', 1, '2024-02-04', 3),
    ('Sara', 'Verma', 4, 'M', 1, '2024-02-04', 2),
    ('Ishani', 'Jain', 5, 'Free', 2, '2024-02-04', 4),
	('Ishani', 'Jain', 7, 'L', 2, '2024-02-04', 4),
    ('Ishani', 'Jain', 8, 'L', 2, '2024-02-04', 4),
    ('Ishani', 'Jain', 7, 'L', 2, '2024-02-04', 4),

    ('Advika', 'Jain', 3, 'XL', 1, '2024-02-04', 3),
    ('Advika', 'Jain',4, 'XL', 1, '2024-02-04', 3),
    ('Myra', 'Verma', 14, 'Free', 1, '2024-02-04', 2),
	('Myra', 'Verma', 2, 'Free', 1, '2024-02-04', 2),
    ('Myra', 'Verma', 17, 'Free', 1, '2024-02-04', 2),
    ('Myra', 'Verma', 22, 'Free', 1, '2024-02-04', 2),
    ('Saanvi', 'Kumar', 8, 'XS', 2, '2024-02-04', 4),
    ('Ishani', 'Mehta', 2, 'Free', 2, '2024-02-04', 3),
    ('Sara', 'Jain', 17, 'Free', 1, '2024-02-04', 3),
    ('Ananya', 'Mehta', 15, 'Free', 1, '2024-02-04', 2),
	('Ananya', 'Mehta', 11, 'M', 1, '2024-02-04', 2),
    ('Aadhya', 'Sharma', 7, 'S', 1, '2024-02-04', 4),
    ('Saanvi', 'Verma', 20, 'Free', 1, '2024-02-04', 2),
    ('Saanvi', 'Verma', 22, 'Free', 3, '2024-02-04', 2),
    
    
    ('Anika', 'Mehta', 12, 'L', 2, '2024-02-05', 3),
    ('Anika', 'Mehta', 11, 'L', 2, '2024-02-05', 3),
    ('Navya', 'Verma', 19, 'Free', 1, '2024-02-05', 4),
    ('Aaradhya', 'Gupta', 7, 'XL', 1, '2024-02-05', 4),
    ('Aaradhya', 'Gupta', 9, 'XL', 1, '2024-02-05', 4),
    ('Myra', 'Jain', 11, 'XXS', 2, '2024-02-05', 3),
    ('Zara', 'Sharma', 10, 'XS', 2, '2024-02-05', 2),
    ('Anushka', 'Patel', 18, 'Free', 1, '2024-02-05', 4),
    ('Zara', 'Verma', 21, 'Free', 1, '2024-02-05', 3),
    ('Zara', 'Verma', 2, 'Free', 1, '2024-02-05', 3),
    ('Zara', 'Verma', 22, 'Free', 1, '2024-02-05', 3),
 
	('Navya', 'Mehta', 14, 'Free', 2, '2024-02-06', 4),
    ('Navya', 'Mehta', 2, 'Free', 1, '2024-02-06', 4),
    ('Vaani', 'Gupta', 11, 'XXL', 2, '2024-02-06', 3),
    ('Diya', 'Kumar', 12, 'XS', 1, '2024-02-06', 4),
    ('Anushka', 'Mehta', 10, 'M', 2, '2024-02-06', 4),
    ('Advika', 'Patel', 19, 'Free', 2, '2024-02-06', 2),
    ('Advika', 'Patel', 3, 'XL', 2, '2024-02-06', 2),
    ('Advika', 'Patel', 9, 'M', 2, '2024-02-06', 2),
    ('Advika', 'Patel', 11, 'M', 2, '2024-02-06', 2),
    ('Aadhya', 'Reddy', 6, 'XL', 1, '2024-02-06', 4),
    ('Aaradhya', 'Reddy', 7, 'L', 1, '2024-02-06', 2),
    ('Ishika', 'Kumar', 3, 'XL', 1, '2024-02-06', 4),
    ('Anika', 'Mehta', 18, 'Free', 2, '2024-02-06', 3),
    ('Saanvi', 'Patel', 8, 'XS', 2, '2024-02-06', 4),
    ('Ishani', 'Mehta', 2, 'Free', 2, '2024-02-06', 3),
    ('Ishani', 'Mehta', 11, 'M', 2, '2024-02-06', 3),
    ('Ishani', 'Mehta', 1, 'M', 2, '2024-02-06', 3),
    ('Sara', 'Jain', 17, 'Free', 1, '2024-02-06', 3),
    ('Myra', 'Verma', 14, 'Free', 1, '2024-02-06', 2),
    ('Myra', 'Verma', 2, 'Free', 1, '2024-02-06', 2),
    ('Saanvi', 'Kumar', 16, 'Free', 1, '2024-02-06', 3),
    
    ('Ananya', 'Gupta', 1, 'S', 1, '2024-02-07', 3),
	('Ananya', 'Gupta', 11, 'S', 1, '2024-02-07', 3),
    ('Aadhya', 'Sharma', 7, 'S', 1, '2024-02-07', 4),
    ('Sara', 'Verma', 4, 'M', 1, '2024-02-07', 2),
	('Sara', 'Verma', 7, 'M', 1, '2024-02-07', 2),
    ('Sara', 'Verma', 9, 'M', 1, '2024-02-07', 2),
    ('Ishani', 'Jain', 5, 'Free', 2, '2024-02-07', 4),
    ('Ishani', 'Jain', 3, 'Free', 1, '2024-02-07', 3),
    ('Myra', 'Sharma', 6, 'XXS', 1, '2024-02-07', 4),
    ('Zara', 'Sharma', 10, 'XS', 2, '2024-02-07', 2),
    ('Anushka', 'Patel', 18, 'Free', 1, '2024-02-07', 4),
    ('Zara', 'Verma', 21, 'Free', 1, '2024-02-07', 3),
    ('Aaradhya', 'Gupta', 9, 'XL', 1, '2024-02-07', 4),
    ('Myra', 'Jain', 11, 'XXS', 2, '2024-02-07', 3),
    ('Ananya', 'Mehta', 15, 'Free', 1, '2024-02-07', 2),
    ('Ananya', 'Mehta', 12, 'L', 2, '2024-02-07', 3),
    ('Navya', 'Verma', 19, 'Free', 1, '2024-02-07', 4),
    ('Ishika', 'Kumar', 7, 'XL', 1, '2024-02-07', 4),
    
    ('Aadhya', 'Reddy', 5, 'Free', 2, '2024-02-08', 4),
    ('Aadhya', 'Reddy', 3, 'Free', 2, '2024-02-08', 4),
    ('Diya', 'Sharma', 10, 'XXS', 1, '2024-02-08', 2),
    ('Sara', 'Jain', 2, 'Free', 1, '2024-02-08', 2),
    ('Sara', 'Jain', 22, 'Free', 1, '2024-02-08', 2),
    ('Sara', 'Jain', 21, 'Free', 1, '2024-02-08', 2),
    ('Sara', 'Jain', 19, 'Free', 1, '2024-02-08', 2),
    ('Myra', 'Reddy', 4, 'XXXL', 1, '2024-02-08', 2),
    ('Vaani', 'Mehta', 1, 'S', 1, '2024-02-08', 4),
    ('Anushka', 'Patel', 13, 'Free', 2, '2024-02-08', 3),
    ('Aaradhya', 'Verma', 20, 'Free', 1, '2024-02-08', 2),
    ('Myra', 'Jain', 9, 'XXL', 2, '2024-02-08', 3),
    ('Anika', 'Kumar', 15, 'Free', 1, '2024-02-08', 4),
    
    ('Anushka', 'Gupta', 8, 'M', 2, '2024-02-09', 4),
    ('Anushka', 'Sharma', 16, 'Free', 1, '2024-02-09', 3),
    ('Saanvi', 'Kumar', 5, 'Free', 2, '2024-02-09', 4),
    ('Aadhya', 'Sharma', 17, 'Free', 1, '2024-02-09', 2),
    ('Diya', 'Jain', 21, 'Free', 2, '2024-02-09', 3),
    ('Ishika', 'Gupta', 22, 'Free', 2, '2024-02-09', 4),
    ('Sara', 'Mehta', 3, 'Free', 1, '2024-02-09', 4),
    ('Saanvi', 'Gupta', 1, 'M', 1, '2024-02-09', 4),
    ('Advika', 'Reddy', 7, 'XL', 1, '2024-02-09', 4),
    ('Anika', 'Verma', 6, 'XXS', 1, '2024-02-09', 3),
    ('Aaradhya', 'Sharma', 7, 'L', 1, '2024-02-09', 2),
    
    ('Ishani', 'Kumar', 8, 'S', 2, '2024-02-10', 4),
    ('Myra', 'Gupta', 9, 'XXS', 1, '2024-02-10', 2),
    ('Zara', 'Kumar', 8, 'M', 1, '2024-02-10', 4),
    ('Aadhya', 'Verma', 1, 'S', 2, '2024-02-10', 3),
    ('Aadhya', 'Mehta', 4, 'XS', 1, '2024-02-10', 4),
    ('Myra', 'Sharma', 8, 'XL', 1, '2024-02-10', 2),
    ('Ananya', 'Sharma', 8, 'S', 1, '2024-02-10', 3),
    ('Saanvi', 'Jain', 8, 'L', 2, '2024-02-10', 4),
    ('Anika', 'Mehta', 8, 'M', 1, '2024-02-10', 2),
    ('Advika', 'Gupta', 7, 'XXS', 2, '2024-02-10', 3),
    ('Ishika', 'Patel', 8, 'Free', 2, '2024-02-10', 4),
    ('Sara', 'Gupta', 9, 'L', 1, '2024-02-10', 4),
    ('Aaradhya', 'Jain', 4, 'XXS', 1, '2024-02-10', 4),
    
    -- Day 11 (Feb 11, 2024)
	('Navya', 'Mehta', 14, 'Free', 2, '2024-02-11', 4),
	('Navya', 'Mehta', 2, 'Free', 1, '2024-02-11', 4),
	('Vaani', 'Gupta', 11, 'XXL', 2, '2024-02-11', 3),
	('Diya', 'Kumar', 12, 'XS', 1, '2024-02-11', 4),
	('Anushka', 'Mehta', 10, 'M', 2, '2024-02-11', 4),
	('Advika', 'Patel', 19, 'Free', 2, '2024-02-11', 2),
	('Advika', 'Patel', 1, 'XS', 2, '2024-02-11', 2),
	('Advika', 'Patel', 2, 'Free', 1, '2024-02-11', 2),
	('Advika', 'Patel', 5, 'Free', 1, '2024-02-11', 2),
	('Aadhya', 'Reddy', 6, 'XL', 1, '2024-02-11', 4),
	('Aaradhya', 'Reddy', 7, 'L', 1, '2024-02-11', 2),
	('Ishika', 'Kumar', 3, 'XL', 1, '2024-02-11', 4),
	('Anika', 'Mehta', 18, 'Free', 2, '2024-02-11', 3),
	('Saanvi', 'Patel', 8, 'XS', 2, '2024-02-11', 4),
	('Ishani', 'Mehta', 2, 'Free', 2, '2024-02-11', 3),
	('Sara', 'Jain', 17, 'Free', 1, '2024-02-11', 3),
	('Myra', 'Verma', 14, 'Free', 1, '2024-02-11', 2),
	('Myra', 'Verma', 2, 'Free', 1, '2024-02-11', 2),
	('Saanvi', 'Kumar', 16, 'Free', 1, '2024-02-11', 3),
	('Ananya', 'Gupta', 1, 'S', 1, '2024-02-11', 3),

	-- Day 12 (Feb 12, 2024)
	('Aadhya', 'Reddy', 5, 'Free', 2, '2024-02-12', 4),
	('Aadhya', 'Reddy', 3, 'Free', 2, '2024-02-12', 4),
	('Diya', 'Sharma', 10, 'XXS', 1, '2024-02-12', 2),
	('Sara', 'Jain', 2, 'Free', 1, '2024-02-12', 2),
	('Sara', 'Jain', 22, 'Free', 1, '2024-02-12', 2),
	('Sara', 'Jain', 21, 'Free', 1, '2024-02-12', 2),
	('Sara', 'Jain', 19, 'Free', 1, '2024-02-12', 2),
	('Myra', 'Reddy', 4, 'XXXL', 1, '2024-02-12', 2),
	('Vaani', 'Mehta', 1, 'S', 1, '2024-02-12', 4),
	('Anushka', 'Patel', 13, 'Free', 2, '2024-02-12', 3),
	('Aaradhya', 'Verma', 20, 'Free', 1, '2024-02-12', 2),
	('Myra', 'Jain', 9, 'XXL', 2, '2024-02-12', 3),
	('Anika', 'Kumar', 15, 'Free', 1, '2024-02-12', 4),

	-- Day 13 (Feb 13, 2024)
	('Anushka', 'Gupta', 8, 'M', 2, '2024-02-13', 4),
	('Anushka', 'Sharma', 16, 'Free', 1, '2024-02-13', 3),
	('Saanvi', 'Kumar', 5, 'Free', 2, '2024-02-13', 4),
	('Aadhya', 'Sharma', 17, 'Free', 1, '2024-02-13', 2),
	('Diya', 'Jain', 21, 'Free', 2, '2024-02-13', 3),
	('Ishika', 'Gupta', 22, 'Free', 2, '2024-02-13', 4),
	('Sara', 'Mehta', 3, 'Free', 1, '2024-02-13', 4),
	('Saanvi', 'Gupta', 1, 'M', 1, '2024-02-13', 4),
	('Advika', 'Reddy', 7, 'XL', 1, '2024-02-13', 4),
	('Anika', 'Verma', 6, 'XXS', 1, '2024-02-13', 3),
	('Aaradhya', 'Sharma', 7, 'L', 1, '2024-02-13', 2),

	-- Day 14 (Feb 14, 2024)
	('Ishani', 'Kumar', 8, 'S', 2, '2024-02-14', 4),
	('Myra', 'Gupta', 9, 'XXS', 1, '2024-02-14', 2),
	('Zara', 'Kumar', 8, 'M', 1, '2024-02-14', 4),
	('Aadhya', 'Verma', 1, 'S', 2, '2024-02-14', 3),
	('Aadhya', 'Mehta', 4, 'XS', 1, '2024-02-14', 4),
	('Myra', 'Sharma', 8, 'XL', 1, '2024-02-14', 2),
	('Ananya', 'Sharma', 8, 'S', 1, '2024-02-14', 3),
	('Saanvi', 'Jain', 8, 'L', 2, '2024-02-14', 4),
	('Anika', 'Mehta', 8, 'M', 1, '2024-02-14', 2),
	('Advika', 'Gupta', 7, 'XXS', 2, '2024-02-14', 3),
	('Ishika', 'Patel', 8, 'Free', 2, '2024-02-14', 4),
	('Sara', 'Gupta', 9, 'L', 1, '2024-02-14', 4),
	('Aaradhya', 'Jain', 4, 'XXS', 1, '2024-02-14', 4),

	-- Day 15 (Feb 15, 2024)
	('Ananya', 'Gupta', 11, 'S', 1, '2024-02-15', 3),
	('Ananya', 'Mehta', 11, 'M', 1, '2024-02-15', 2),
	('Aadhya', 'Sharma', 7, 'S', 1, '2024-02-15', 4),
	('Sara', 'Verma', 4, 'M', 1, '2024-02-15', 2),
	('Sara', 'Verma', 7, 'M', 1, '2024-02-15', 2),
	('Sara', 'Verma', 9, 'M', 1, '2024-02-15', 2),
	('Ishani', 'Jain', 5, 'Free', 2, '2024-02-15', 4),
	('Ishani', 'Jain', 3, 'Free', 1, '2024-02-15', 3),
	('Myra', 'Sharma', 6, 'XXS', 1, '2024-02-15', 4),
	('Zara', 'Sharma', 10, 'XS', 2, '2024-02-15', 2),
	('Anushka', 'Patel', 18, 'Free', 1, '2024-02-15', 4),
	('Myra', 'Patel', 3, 'XS', 1, '2024-02-15', 4),

	-- Day 16 (Feb 16, 2024)
	('Diya', 'Mehta', 15, 'Free', 1, '2024-02-16', 4),
	('Diya', 'Sharma', 16, 'Free', 1, '2024-02-16', 4),
	('Vaani', 'Mehta', 6, 'XXL', 2, '2024-02-16', 3),
	('Vaani', 'Mehta', 14, 'Free', 2, '2024-02-16', 3),
	('Vaani', 'Mehta', 10, 'Free', 1, '2024-02-16', 3),
	('Vaani', 'Mehta', 2, 'Free', 2, '2024-02-16', 3),
	('Vaani', 'Mehta', 5, 'Free', 1, '2024-02-16', 3),
	('Vaani', 'Mehta', 7, 'L', 1, '2024-02-16', 3),
	('Vaani', 'Mehta', 19, 'Free', 2, '2024-02-16', 3),
	('Vaani', 'Mehta', 1, 'M', 2, '2024-02-16', 3),
	('Vaani', 'Mehta', 4, 'M', 1, '2024-02-16', 3),
	('Vaani', 'Mehta', 20, 'Free', 1, '2024-02-16', 3),
	('Diya', 'Mehta', 13, 'M', 2, '2024-02-16', 4),
	('Sara', 'Mehta', 2, 'M', 2, '2024-02-16', 3),
    
	('Zara', 'Mehta', 1, 'M', 2, '2024-02-17', 4),
    ('Diya', 'Kumar', 3, 'XS', 1, '2024-02-17', 2),
    ('Myra', 'Sharma', 3, 'L', 2, '2024-02-17', 3),
    ('Advika', 'Mehta', 4, 'XXS', 1, '2024-02-17', 3),
    ('Ananya', 'Gupta', 4, 'XL', 1, '2024-02-17', 2),
    ('Aadhya', 'Jain', 4, 'M', 2, '2024-02-17', 4),
    ('Aaradhya', 'Mehta', 7, 'L', 1, '2024-02-17', 2),
    ('Ishika', 'Sharma', 8, 'XL', 1, '2024-02-17', 4),
    ('Anushka', 'Mehta', 9, 'S', 1, '2024-02-17', 4),
    ('Saanvi', 'Kumar', 5, 'Free', 2, '2024-02-17', 3),
    ('Vaani', 'Jain', 1, 'M', 1, '2024-02-17', 2),
    ('Diya', 'Mehta', 7, 'XXS', 2, '2024-02-17', 3),
    ('Myra', 'Kumar', 3, 'L', 1, '2024-02-17', 4),
    ('Sara', 'Patel', 4, 'XL', 1, '2024-02-17', 4),
    
    ('Ishani', 'Gupta', 6, 'S', 1, '2024-02-18', 2),
    ('Ananya', 'Kumar', 5, 'Free', 2, '2024-02-18', 3),
    ('Aadhya', 'Sharma', 7, 'XS', 1, '2024-02-18', 3),
    ('Aaradhya', 'Jain', 8, 'M', 2, '2024-02-18', 4),
    ('Ishika', 'Mehta', 9, 'XXS', 1, '2024-02-18', 2),
    ('Anika', 'Gupta', 6, 'L', 1, '2024-02-18', 3),
    ('Zara', 'Patel', 6, 'XL', 2, '2024-02-18', 4),
    ('Advika', 'Mehta', 6, 'S', 1, '2024-02-18', 4),
    ('Myra', 'Sharma', 6, 'M', 1, '2024-02-18', 2),
    ('Saanvi', 'Jain', 4, 'L', 2, '2024-02-18', 3),
    ('Sara', 'Kumar', 4, 'XXS', 2, '2024-02-18', 2),
    ('Anushka', 'Gupta', 6, 'S', 1, '2024-02-18', 3),
    
    ('Advika', 'Mehta', 7, 'XL', 1, '2024-02-19', 4),
    ('Ishani', 'Sharma', 8, 'Free', 2, '2024-02-19', 4),
    ('Zara', 'Mehta', 9, 'M', 1, '2024-02-19', 4),
    ('Anika', 'Kumar', 7, 'XXS', 2, '2024-02-19', 3),
    ('Aadhya', 'Sharma', 7, 'L', 1, '2024-02-19', 3),
    ('Myra', 'Jain', 7, 'S', 1, '2024-02-19', 2),
    ('Aaradhya', 'Gupta', 7, 'M', 2, '2024-02-19', 3),
    ('Ananya', 'Sharma', 7, 'XL', 1, '2024-02-19', 4),
    ('Saanvi', 'Jain', 7, 'XXS', 1, '2024-02-19', 4),
    ('Ishika', 'Gupta', 6, 'L', 1, '2024-02-19', 4),
    ('Anushka', 'Patel', 7, 'XL', 1, '2024-02-19', 2),
    ('Sara', 'Gupta', 2, 'Free', 2, '2024-02-19', 3)
;





-- Insert data into Procurement table
INSERT INTO Procurement (SupplierID, ProductID, NumberReceived, PurchaseDate, PricePerUnit)
VALUES
    -- Ethnic Threads (Indian wear)
    (1, 1, 100, '2024-02-01', 400.00),
    (1, 2, 80, '2024-02-01', 500.00),

    -- Fashion Avenue (Western wear, Bottom wear)
    (2, 3, 90, '2024-02-1', 800.00),
    (2, 4, 110, '2024-02-1', 400.00),
    (2, 6, 130, '2024-02-1', 200.00),
    (2, 7, 95, '2024-02-1', 200.00),
    (2, 8, 85, '2024-02-3', 300.00),
    (2, 9, 75, '2024-02-3', 300.00),
    (2, 10, 110, '2024-02-3', 100.00),
    (2, 11, 120, '2024-02-3', 200.00),
    (2, 12, 100, '2024-02-3', 400.00),

    -- Trendy Chic (Jewellery)
    (3, 17, 150, '2024-02-1', 100.00),
    (3, 18, 130, '2024-02-03', 100.00),
    (3, 19, 110, '2024-02-08', 130.00),
    (3, 20, 120, '2024-02-8', 100.00),
    (3, 21, 100, '2024-02-8', 120.00),

    -- Accessorize Now (Accessories, Bags)
    (4, 13, 90, '2024-02-2', 320.00),
    (4, 14, 80, '2024-02-2', 500.00),
    (4, 15, 70, '2024-02-2', 200.00),
    (4, 16, 85, '2024-02-2', 250.00),
    (4, 22, 80, '2024-02-2', 230.00),
	(4, 5, 90, '2024-02-2', 200.00)
;

SELECT * FROM Procurement;


-- Insert data into HistoricalPricing table
INSERT INTO HistoricalPricing (ProductID, Price, EffectiveDate)
VALUES
    (1, 730.00, '2022-01-01'),
    (2, 1430.00, '2022-01-01'),
    (3, 1730.00, '2022-01-01'),
    (4, 930.00, '2022-01-01'),
    (5, 730.00, '2022-01-01'),
    (6, 530.00, '2022-01-01'),
    (7, 830.00, '2022-01-01'),
    (8, 730.00, '2022-01-01'),
    (9, 630.00, '2022-01-01'),
    (10, 530.00, '2022-01-01'),
    (11, 430.00, '2022-01-01'),
    (12, 930.00, '2022-01-01'),
    (13, 1130.00, '2022-01-01'),
    (14, 1430.00, '2022-01-01'),
    (15, 730.00, '2022-01-01'),
    (16, 830.00, '2022-01-01'),
    (17, 230.00, '2022-01-01'),
    (18, 330.00, '2022-01-01'),
    (19, 630.00, '2022-01-01'),
    (20, 530.00, '2022-01-01'),
    (21, 430.00, '2022-01-01'),
    (22, 830.00, '2022-01-01'), 
    (1, 770.00, '2023-01-01'),
    (2, 1470.00, '2023-01-01'),
    (3, 1770.00, '2023-01-01'),
    (4, 970.00, '2023-01-01'),
    (5, 770.00, '2023-01-01'),
    (6, 570.00, '2023-01-01'),
    (7, 870.00, '2023-01-01'),
    (8, 770.00, '2023-01-01'),
    (9, 670.00, '2023-01-01'),
    (10, 570.00, '2023-01-01'),
    (11, 470.00, '2023-01-01'),
    (12, 970.00, '2023-01-01'),
    (13, 1170.00, '2023-01-01'),
    (14, 1470.00, '2023-01-01'),
    (15, 770.00, '2023-01-01'),
    (16, 870.00, '2023-01-01'),
    (17, 270.00, '2023-01-01'),
    (18, 370.00, '2023-01-01'),
    (19, 670.00, '2023-01-01'),
    (20, 570.00, '2023-01-01'),
    (21, 470.00, '2023-01-01'),
    (22, 870.00, '2023-01-01'),
    (1, 800.00, '2024-01-01'),
    (2, 1500.00, '2024-01-01'),
    (3, 1800.00, '2024-01-01'),
    (4, 1000.00, '2024-01-01'),
    (5, 800.00, '2024-01-01'),
    (6, 600.00, '2024-01-01'),
    (7, 900.00, '2024-01-01'),
    (8, 800.00, '2024-01-01'),
    (9, 700.00, '2024-01-01'),
    (10, 600.00, '2024-01-01'),
    (11, 500.00, '2024-01-01'),
    (12, 1000.00, '2024-01-01'),
    (13, 1200.00, '2024-01-01'),
    (14, 1500.00, '2024-01-01'),
    (15, 800.00, '2024-01-01'),
    (16, 900.00, '2024-01-01'),
    (17, 300.00, '2024-01-01'),
    (18, 400.00, '2024-01-01'),
    (19, 700.00, '2024-01-01'),
    (20, 600.00, '2024-01-01'),
    (21, 500.00, '2024-01-01'),
    (22, 900.00, '2024-01-01')
;


SELECT * FROM historicalpricing;