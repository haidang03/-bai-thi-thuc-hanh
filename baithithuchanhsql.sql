CREATE DATABASE A_Zbank
GO
USE A_Zbank
GO
--Tạo bảng khách hàng 
CREATE TABLE Customer (
		CustomerID INT PRIMARY KEY NOT NULL,--Mã Khách Hàng 
		Name NVARCHAR(50) NULL, -- Tên Khách 
		City NVARCHAR(50) NULL, -- Thành Phố 
		Country NVARCHAR(50) NULL, --Quốc Gia 
		Phone NVARCHAR(15) NULL, --SĐT
		Email NVARCHAR(50) NULL
)
GO
--Tạo  bảng tài khoản khách hàng 
CREATE TABLE CustomerAccount (
	AccountNumber CHAR(9) PRIMARY KEY NOT NULL, --Số Tài Khoản 
	CustomerID INT FOREIGN KEY REFERENCES dbo.Customer(CustomerID) NOT NULL,-- Khách hàng
	Balance MONEY NOT NULL,-- Thăng bằng
	MinAccount MONEY NULL --TK Tối Thiểu 
)
GO
--Tạo Bảng giao dịch 
CREATE TABLE CustomerTransaction (
	TransactionID INT PRIMARY KEY NOT NULL, -- Mã Giao dịch 
	AccountNumber CHAR(9) FOREIGN KEY REFERENCES dbo.CustomerAccount(AccountNumber) NULL, --STK
	TransactionDate SMALLDATETIME NULL, -- Ngày giao dịch 
	Amount MONEY NULL,
	DepositorWithdraw BIT NULL 
)
INSERT INTO dbo.Customer
(
    CustomerID,
    Name,
    City,
    Country,
    Phone,
    Email
)
VALUES
(   1,    -- CustomerID - int
    N'ĐẶNG HẢI ĐĂNG', -- Name - nvarchar(50)
    N'HÀ NỘI', -- City - nvarchar(50)
    N'VIỆT NAM', -- Country - nvarchar(50)
    '0929659564', -- Phone - nvarchar(15)
    N'dangdhth2109022@fpt.edu.vn'  -- Email - nvarchar(50)
    ),
(   2,    -- CustomerID - int
    N'NGUYỄN HẢI ĐĂNG', -- Name - nvarchar(50)
    N'HẢI PHÒNG', -- City - nvarchar(50)
    N'VIỆT NAM', -- Country - nvarchar(50)
    '0964960768', -- Phone - nvarchar(15)
    N'nguyendangdayz@fpt.edu.vn'  -- Email - nvarchar(50)
    ),
(   3,    -- CustomerID - int
    N'ĐỖ HOÀNG ANH', -- Name - nvarchar(50)
    N'HÀ NỘI', -- City - nvarchar(50)
    N'VIỆT NAM', -- Country - nvarchar(50)
    N'0869132193', -- Phone - nvarchar(15)
    N'dohoanganh@fpt.edu.vn' -- Email - nvarchar(50)
    )
GO
INSERT INTO dbo.CustomerAccount
(
    AccountNumber,
    CustomerID,
    Balance,
    MinAccount
)
VALUES
(   '777788888',   -- AccountNumber - char(9)
    1,    -- CustomerID - int
    50000, -- Balance - money
    100000  -- MinAccount - money
    ),
(   '678988888',   -- AccountNumber - char(9)
    2,    -- CustomerID - int
    7000000, -- Balance - money
    200000000  -- MinAccount - money
    ),
(   '567899999',   -- AccountNumber - char(9)
    3,    -- CustomerID - int
    3000000, -- Balance - money
    500000000 -- MinAccount - money
    )
INSERT INTO dbo.CustomerTransaction
(
    TransactionID,
    AccountNumber,
    TransactionDate,
    Amount,
    DepositorWithdraw
)
VALUES
(   1,    -- TransactionID - int
    '777788888', -- AccountNumber - char(9)
    '20220119', -- TransactionDate - smalldatetime
    100000, -- Amount - money
    70000000  -- DepositorWithdraw - bit
    ),
(   2,    -- TransactionID - int
    '678988888', -- AccountNumber - char(9)
    '20220120', -- TransactionDate - smalldatetime
    600000, -- Amount - money
    90000000  -- DepositorWithdraw - bit
    ),
(   3,    -- TransactionID - int
    '567899999', -- AccountNumber - char(9)
    '20220121', -- TransactionDate - smalldatetime
    300000, -- Amount - money
    20000000  -- DepositorWithdraw - bit
    )
--4 Write a query to get all customers from Customer table who live in 'Hanoi'.
SELECT * FROM dbo.Customer 
WHERE City LIKE  N'HÀ NỘI'
--5  Write a query to get account information of the customers (Name, Phone, Email,AccountNumber, Balance).
SELECT Name,Phone, Email, AccountNumber,Balance FROM dbo.Customer
JOIN dbo.CustomerAccount 
ON CustomerAccount.CustomerID = Customer.CustomerID 
--6  A-Z bank has a business rule that each transaction (withdrawal or deposit) won't beover $1000000 (One million USDS). Create a CHECK constraint on Amount columnof CustomerTransaction table to check that each transaction amount is greater than
ALTER TABLE dbo.CustomerTransaction
ADD CONSTRAINT CK_Money
CHECK ( Amount > 0 AND Amount <= 1000000) 
--  Create AccountNumber, TransactionDate, Amount, and DepositorWithdraw from Customer, CustomerAccount and CustomerTransaction tables. view named vCustomerTransactions that display Name,
GO
CREATE VIEW vCustomerTransactions
AS
SELECT Name, CustomerAccount.AccountNumber,TransactionDate,Amount ,CustomerTransaction.DepositorWithdraw FROM dbo.Customer
JOIN dbo.CustomerAccount
ON CustomerAccount.CustomerID = Customer.CustomerID
JOIN dbo.CustomerTransaction
ON CustomerTransaction.AccountNumber = CustomerAccount.AccountNumber

