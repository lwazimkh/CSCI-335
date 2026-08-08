CREATE DATABASE MuskieCo;
USE MuskieCo;
DROP DATABASE MuskieCo;

CREATE TABLE Store(
    StoreID INT PRIMARY KEY,
    ManagerID INT,
    store_address VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE Staff (
	StaffID INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	age INT NOT NULL,
	home_address VARCHAR(50) NOT NULL,
	job_title VARCHAR(50) NOT NULL,
	phone_number VARCHAR(20) UNIQUE NOT NULL,
	email VARCHAR(50) NOT NULL,
	time_of_employment DATE NOT NULL,
	StoreID INT,
	FOREIGN KEY (StoreID) REFERENCES Store(StoreID) 
    ON DELETE SET NULL,
	CHECK (email LIKE '%@%.%')
); 

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY
);

CREATE TABLE Member(
	CustomerID INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email_address VARCHAR(100),
	phone_number VARCHAR(20),
	home_address VARCHAR(250),
	active_status BOOLEAN,
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE CASCADE
);


CREATE TABLE Inventory (
        InventoryID INT PRIMARY KEY,
        Quantity INT NOT NULL,
        StoreID INT,
        FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
        ON DELETE SET NULL
);

CREATE TABLE Product (
    ProductId INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    buy_price DECIMAL(7,2),
    sell_price DECIMAL(7,2) NOT NULL,
    InventoryID INT,
    CONSTRAINT pk_Product PRIMARY KEY (ProductId),
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
    ON DELETE CASCADE
);

CREATE TABLE Discount(
    DiscountId INT NOT NULL,
    discount_start_date DATE NOT NULL,
    discount_end_date DATE,
    discount_amount DECIMAL(7,2) NOT NULL,
    CONSTRAINT pk_Discount PRIMARY KEY (DiscountId)
);

CREATE TABLE SignUp (
	CustomerID INT,
	StaffID INT,
	Signup_date DATE,
	PRIMARY KEY (CustomerID, StaffID, signup_date),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE CASCADE,
	FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ON DELETE CASCADE
);

CREATE TABLE Transactions(
	TransactionID INT PRIMARY KEY, 
	purchase_date DATE,
	price_total DECIMAL (10,2),
	CustomerID INT NOT NULL,
	StaffID INT NOT NULL,
	StoreID INT NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
	FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE Quantity(
	TransactionID INT NOT NULL,
	ProductID INT NOT NULL,
	Amount INT,
	FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
    ON DELETE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
    ON DELETE CASCADE,
	PRIMARY KEY (TransactionID, ProductID)
);

-- Store
INSERT INTO Store VALUES 
(1, NULL, '7497 Sunset Drive', '123-485-1039'), 
(2, NULL, '7069 Washington Street', '123-102-5982'), 
(3, NULL, '11 College Street', '123-583-9034'), 
(4, NULL, '9090 Jefferson Court', '123-403-1384'), 
(5, NULL, '8022 13th Street', '123-753-1253');

-- Staff
INSERT INTO Staff VALUES 
(1, 'Emily', 'Johnson', 25, '9865 Olive Street', 'Cashier', '210-821-4892', 'emily@gmail.com', '2022-01-01', 1),
(2, 'Joe', 'Jameson', 28, '57 Chestnut Street', 'Manager', '593-201-2843', 'joe@gmail.com', '2021-03-12', 2),
(3, 'James', 'Matthews', 29, '9 Garden Street', 'Assistant to Manager', '292-482-1028', 'james@gmail.com', '2024-12-03', 3),
(4, 'Arthur', 'Stevens', 32, '745 Surrey Lane', 'Cashier', '293-483-1039', 'arthur@gmail.com', '2023-06-09', 4),
(5, 'Melissa', 'Adams', 24, '489 Primrose Lane', 'Cashier', '392-482-4821', 'melissa@gmail.com', '2022-11-10', 5);

-- Customer
INSERT INTO Customer VALUES 
(1),
(2),
(3),
(4),
(5);

-- Inventory
INSERT INTO Inventory VALUES 
(1, 220, 1),
(2, 150, 2),
(3, 110, 3),
(4, 250, 4),
(5, 125, 5);


-- Product
INSERT INTO Product VALUES
(1, 'Item1', 3.00, 5.00, 1),
(2, 'Item2', 8.00, 12.00, 2),
(3, 'Item3', 20.00, 29.00, 3),
(4, 'Item4', 35.00, 39.00, 4),
(5, 'Item5', 22.00, 25.00, 5);

-- Discount
INSERT INTO Discount VALUES 
(1, '2026-01-02', '2026-02-25', 2.00),
(2, '2025-05-13', '2025-06-01', 5.00),
(3, '2025-06-28', '2025-08-09', 10.00),
(4, '2025-12-12', '2026-01-11', 5.00),
(5, '2025-3-12', '2025-04-15', 4.00);

-- SignUp
INSERT INTO SignUp VALUES
(1, 2,'2022-01-07'),
(2, 1,'2021-08-09'),
(3, 3,'2024-01-10'),
(4, 1,'2023-02-22'),
(5, 4,'2022-10-07');

-- Transaction
INSERT INTO Transactions VALUES
(1, '2025-05-12', 30.00, 1, 1, 1),
(2, '2025-08-22', 20.00, 2, 2, 2), 
(3, '2025-09-13', 28.00, 3, 3, 3),
(4, '2025-12-28', 19.00, 4, 4, 4),
(5, '2026-02-05', 45.00, 5, 5, 5);

-- Quantity
INSERT INTO Quantity VALUES
(1, 1, 10),
(2, 2, 3),
(3, 3, 6),
(4, 4, 5), 
(5, 5, 2);

-- Member
INSERT INTO Member VALUES
(1, 'Abby', 'Lewis', 'alew@gmail.com', '392-481-1294', '24 Depot Street', 1),
(2, 'Lee', 'Josephs', 'leejoe@gmail.com', '482-194-2589', '941 Route 32', 0),
(3, 'Mya', 'Stevenson', 'MyStevenson@gmail.com', '283-482-5821', '65 Hillcrest Avenue', 1),
(4, 'Tina', 'Turntile', 'tinaturn@gmail.com', '284-238-5842', '26 Aspen Court', 0),
(5, 'Will', 'Halley', 'willhalley@gmail.com', '293-284-6859', '7606 Dogwood Drive', 1);


-- Operations

-- 1. Add a new store 
-- Data Manipulation
INSERT INTO Store (StoreID, ManagerID, store_address, phone_number)
VALUES (6, 6, '123 Main Street', '513-832-5567');
SELECT * FROM Store;

-- 2. Update Store
-- Data Manipulation
UPDATE Store
SET ManagerID = 1
WHERE StoreID = 1;
SELECT * FROM Store;

-- 3. Delete store From Database
-- Data Manipulation
DELETE FROM Transactions
WHERE StoreID = 2;
DELETE FROM Store
WHERE StoreID = 2;
SELECT * FROM Store;

-- 4. Search for a store in the Database
-- Data Querying
SELECT * FROM Store
WHERE StoreID = 1;

-- 5. Enter a customer into the Database
-- Data Manipulation
INSERT INTO Customer (CustomerID)
VALUES (6);
SELECT * FROM Customer;
-- Additionally, adding a member
INSERT INTO Member
(CustomerID, first_name, last_name, email_address, phone_number, home_address, active_status)
VALUES (6, 'Jack', 'Marshall', 'jackmarshall@gmail.com', '782-365-5036','128 Walnut Ln', 0);
SELECT * FROM Member;

-- 6. Update Customer in the Database
-- Data Manipulation
UPDATE Member
SET email_address = 'leejosephs7@gmail.com'
WHERE CustomerID = 2;
SELECT * FROM Member;

-- 7. Delete Customer
-- Data Manipulation
DELETE FROM Transactions
WHERE CustomerID = 3;
DELETE FROM Customer
WHERE CustomerID = 3;
SELECT * FROM Member;

-- 8. Search Customer
-- Data Querying
SELECT * FROM Member
WHERE CustomerID = 5;

-- 9. Enter Staff
-- Data Manipulation
INSERT INTO Staff 
(StaffID, first_name, last_name, age, home_address, job_title, phone_number, email, time_of_employment, storeID)
VALUES (6, 'Isaiah', 'Johnson', 19, '132 Sundae Street', 'Cashier', '513-221-4792', 'zayjohnson@gmail.com', '2024-09-07', 2);
SELECT * FROM Staff;

-- 10. Update Staff
-- Data Manipulation
UPDATE Staff
SET job_title = 'Manager'
WHERE staffID = 4;
SELECT * FROM Staff;

-- 11. Delete Staff
DELETE FROM Transactions
WHERE StaffID = 5;
DELETE FROM Staff
WHERE StaffID = 5;
SELECT * FROM Staff;

-- 12. Search Staff
-- Data Querying
SELECT * FROM Staff
WHERE StaffID = 3;

-- 13. Enter Product
-- Data Manipulation
INSERT INTO Product (ProductID, Name, buy_price, sell_price, inventoryID)
VALUES (6, 'Xavier Track Bottoms', 25.00, 35.00, 1);
SELECT * FROM Product;

-- 14. Update Product
-- Data Manipulation
UPDATE Product
SET sell_price = 14.00
WHERE productID = 2;
SELECT * FROM Product;

-- 15. Delete Product
-- Data Manipulation
DELETE FROM Product
WHERE ProductID = 4;
SELECT * FROM Product;

-- 16. Search Product
-- Data Querying
SELECT * FROM Product
WHERE name = 'Item3';

SELECT * FROM Discount;
-- 17. Enter Discount
-- Data Manipulation
INSERT INTO Discount (DiscountID, discount_start_date, discount_end_date, discount_amount)
VALUES (6, '2026-01-10', '2026-01-30',7.00);
SELECT * FROM Discount;

-- 18. Update Discount
-- Data Manipulation
UPDATE Discount
SET discount_end_date = '2026-02-02'
WHERE DiscountID = 1;
SELECT * FROM Discount;

-- 19. Delete Discount
-- Data Manipulation
DELETE FROM Discount
WHERE DiscountID = 5;
SELECT * FROM Discount;

-- 20. Search Discount
-- Data Querying
SELECT * FROM Discount
WHERE DiscountID = 1;
SELECT * FROM Discount;

-- 21. Increase Inventory
-- Data Manipulation
INSERT INTO Inventory VALUES
(6, 10, 5)
ON DUPLICATE KEY
UPDATE  Quantity = Quantity + 10;
SELECT * FROM Inventory;

-- 22. Decrease Inventory
-- Data Manipulation
UPDATE Inventory
SET Quantity = Quantity - 5
WHERE InventoryID = 6 AND StoreID = 5;
SELECT * FROM Inventory;

-- 23. Check Inventory
-- Data Querying
SELECT Quantity 
FROM Inventory
WHERE InventoryID = 6;

-- 24. Generate Member Rewards (Monthly)
-- Data Querying
SELECT DISTINCT m.CustomerID
FROM Member m
JOIN Transactions t ON m.CustomerID = t.CustomerID
WHERE MONTH(t.purchase_date) = 5
AND YEAR(t.purchase_date) = 2025
AND m.active_status = 1;

-- 25. Generate Employee Rewards (Quarterly)
-- Data Querying
SELECT DISTINCT StaffID
FROM Transactions
WHERE QUARTER(purchase_date) = 1
AND YEAR(purchase_date) = 2026;

-- 26. Create Transaction
-- Data Manipulation
INSERT INTO Transactions VALUES 
(6, '2026-03-12', 15.00, 1, 1, 1);
SELECT * FROM Transactions;

-- 27. Add item to transaction
-- Data Manipulation
INSERT INTO Quantity VALUES 
(6, 3, 2);
SELECT * FROM Quantity;

-- 28. Calculate Transaction Total (Discounts Included)
-- Data Querying
SELECT SUM(p.sell_price * q.Amount) - d.discount_amount AS Final_Total
FROM Quantity q
JOIN Product p ON q.ProductID = p.ProductID
JOIN Discount d ON d.DiscountID = 1
WHERE q.TransactionID = 6;

-- 29. View Transaction Details
-- Data Querying
SELECT t.TransactionID, t.purchase_date, t.price_total, p.Name, q.Amount
FROM Transactions t JOIN Quantity q 
ON t.TransactionID = q.TransactionID
JOIN Product p 
ON q.ProductID = p.ProductID
WHERE t.TransactionID = 1;

-- 30. Sales Report
-- Data Querying

-- By Day
SELECT purchase_date, SUM(price_total) AS Total_Sales
FROM Transactions
GROUP BY purchase_date;

-- By Month
SELECT YEAR(purchase_date) AS Year, MONTH(purchase_date) AS Month, SUM(price_total) AS Monthly_Sales 
FROM Transactions 
GROUP BY YEAR(purchase_date), MONTH(purchase_date);

-- By Year
SELECT YEAR(purchase_date) AS Year, SUM(price_total) AS Total_Sales
FROM Transactions
GROUP BY YEAR(purchase_date);

-- 31. Store/Product Inventory Report
-- Example Input: 5
-- Inventory of all products at a specific store
-- Data Querying
SELECT p.ProductID, p.Name, i.Quantity
FROM Product p
JOIN Inventory i 
ON p.InventoryID = i.InventoryID
WHERE i.StoreID = 5;

-- Example input: 3
-- Inventory of one product across all stores
-- Data Querying
SELECT p.ProductID, p.Name, i.StoreID, i.Quantity
FROM Product p
JOIN Inventory i 
ON p.InventoryID = i.InventoryID
WHERE p.ProductID = 3;

-- 32. Customer Total Purchase Report
-- Data Querying
SELECT CustomerID, SUM(price_total) AS Total_Purchase
FROM Transactions
WHERE CustomerID = 4
AND purchase_date BETWEEN '2025-01-01' AND '2026-12-31'
GROUP BY CustomerID;













