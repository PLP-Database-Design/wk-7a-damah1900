
-- Question 1: Achieving 1NF

-- SQL Query to Achieve 1NF:
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6) n
  ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1;


-- Question 2: Achieving 2NF

-- 1. Create a new table for Customers:
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- 2. Insert Customer data into the Customers table:
INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- 3. Modify the OrderDetails table to remove the CustomerName column:
CREATE TABLE OrderDetails2 (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- 4. Insert the remaining data into the modified OrderDetails2 table:
INSERT INTO OrderDetails2 (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
