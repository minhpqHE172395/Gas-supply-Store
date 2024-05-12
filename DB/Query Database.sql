USE master
GO
DROP DATABASE IF EXISTS GasSupply
GO
CREATE DATABASE GasSupply
GO
USE GasSupply
GO

-- Bảng Account
CREATE TABLE Account (
    AccountID INT IDENTITY PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    IsAdmin BIT,
    IsStaff BIT
);

-- Bảng User_Account
CREATE TABLE User_Account (
    UserID INT IDENTITY PRIMARY KEY,
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID),
    Name NVARCHAR(100),
    Gender NVARCHAR(10),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    IsGuest BIT,
    IsCustomer BIT,
    CreatedDate DATETIME,
    LastUpdated DATETIME
);

-- Bảng Staff
CREATE TABLE Staff (
    StaffID INT IDENTITY PRIMARY KEY,
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID),
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    Gender NVARCHAR(10),
    Address NVARCHAR(255),
    Phone NVARCHAR(20),
    Position NVARCHAR(100)
);

-- Bảng Categories
CREATE TABLE Categories (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(100),
    TotalProducts INT
);

-- Bảng Product
CREATE TABLE Product (
    ProductID INT IDENTITY PRIMARY KEY,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Name NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(18, 2),
    WarrantyPeriod INT, -- Thời hạn bảo hành (tháng)
    ImageLink NVARCHAR(255),
    Description NVARCHAR(MAX)
);

-- Bảng Cart
CREATE TABLE Cart (
    CartID INT IDENTITY PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES User_Account(UserID)
);

-- Bảng Cart_Detail
CREATE TABLE Cart_Detail (
    DetailID INT IDENTITY PRIMARY KEY,
    CartID INT FOREIGN KEY REFERENCES Cart(CartID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    PaymentMethod NVARCHAR(50),
    PurchaseDate DATETIME,
    Status NVARCHAR(50),
    TotalAmount DECIMAL(18, 2),
    IsPromotionApplied BIT
);

-- Bảng Shipping
CREATE TABLE Shipping (
    ShippingID INT IDENTITY PRIMARY KEY,
    CartID INT FOREIGN KEY REFERENCES Cart(CartID),
    Status NVARCHAR(50),
    StartShippingDate DATETIME,
    EndShippingDate DATETIME,
    Shipper NVARCHAR(100),
    ShippingAddress NVARCHAR(255),
    ShippingCost DECIMAL(18, 2) -- Thêm trường ShippingCost
);

-- Bảng Product_Statistics
CREATE TABLE Product_Statistics (
    StatisticID INT IDENTITY PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    ProductName NVARCHAR(100),
    TotalSold INT,
    TotalRemaining INT,
    CONSTRAINT FK_Product_Statistics_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Bảng Sales
CREATE TABLE Sales (
    SaleID INT IDENTITY PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    UserID INT FOREIGN KEY REFERENCES User_Account(UserID),
    CustomerName NVARCHAR(100),
    Quantity INT,
    SaleDate DATETIME
);

-- Cập nhật dữ liệu trong bảng Product_Statistics dựa trên dữ liệu từ bảng Sales
MERGE INTO Product_Statistics AS tgt
USING (
    SELECT 
        ProductID,
        SUM(Quantity) AS TotalSold
    FROM Sales
    GROUP BY ProductID
) AS src ON tgt.ProductID = src.ProductID
WHEN MATCHED THEN 
    UPDATE SET tgt.TotalSold = src.TotalSold,
               tgt.TotalRemaining = (SELECT Quantity FROM Product WHERE ProductID = src.ProductID) - src.TotalSold
WHEN NOT MATCHED BY TARGET THEN 
    INSERT (ProductID, TotalSold, TotalRemaining)
    VALUES (src.ProductID, src.TotalSold, (SELECT Quantity FROM Product WHERE ProductID = src.ProductID));

-- Bảng Special_Offers
CREATE TABLE Special_Offers (
    OfferID INT IDENTITY PRIMARY KEY,
    OfferCode NVARCHAR(20),
    StartDate DATETIME,
    EndDate DATETIME,
    DiscountPercentage DECIMAL(5, 2),
    Description NVARCHAR(MAX),
    UsageCount INT
);

-- Bảng Combo_Product
CREATE TABLE Combo_Product (
    ComboID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    Price DECIMAL(18, 2),
    Description NVARCHAR(MAX),
    Quantity INT,
    ImageLink NVARCHAR(255),
    WarrantyPeriod INT -- Thời hạn bảo hành (tháng)
);

-- Bảng Product_Requires_Maintenance
CREATE TABLE Product_Requires_Maintenance (
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Name NVARCHAR(100),
    CustomerName NVARCHAR(100),
    WarrantyPeriod INT, -- Thời hạn bảo hành còn lại (tháng)
    MaintenanceStatus NVARCHAR(50),
    ServiceType NVARCHAR(100)
);

ALTER TABLE Product_Statistics
ADD WarrantyStatus BIT;

-- Insert Test
INSERT INTO Account (Username, Password, IsAdmin, IsStaff) 
VALUES 
('admin', 'admin@123', 1, 1),
('user1', 'password1', 0, 0),
('user2', 'password2', 0, 0);

INSERT INTO User_Account (AccountID, Name, Gender, Email, Phone, Address, IsGuest, IsCustomer, CreatedDate, LastUpdated) 
VALUES 
(2, N'Trần Văn A', N'Nam', 'user1@example.com', '0123456789', N'Hà Nội', 0, 1, '2024-05-11', '2024-05-11'),
(3, N'Nguyễn Thị B', N'Nữ', 'user2@example.com', '0987654321', N'Hồ Chí Minh', 0, 1, '2024-05-11', '2024-05-11'),
(NULL, N'Người Dùng Mới', NULL, 'newuser@example.com', NULL, NULL, 1, 0, '2024-05-11', '2024-05-11');

INSERT INTO Staff (AccountID, Name, Email, Gender, Address, Phone, Position) 
VALUES 
(1, N'Nguyễn Văn X', 'staff1@example.com', N'Nam', N'Hà Nội', '0123456789', N'Nhân viên bán hàng'),
(1, N'Trần Thị Y', 'staff2@example.com', N'Nữ', N'Hồ Chí Minh', '0987654321', N'Kế toán');

INSERT INTO Categories (CategoryName, TotalProducts) 
VALUES 
(N'Bếp gas gia đình', 10),
(N'Vật liệu và phụ kiện', 5),
(N'Thiết bị an toàn', 3);

INSERT INTO Product (CategoryID, Name, Quantity, Price, WarrantyPeriod, ImageLink, Description) 
VALUES 
(1, N'Bếp gas Sunhouse SHB 3022', 50, 1500000, 24, 'sunhouse-shb3022.jpg', N'Bếp gas 2 bếp, chất lượng cao'),
(1, N'Bếp gas Rinnai RS-14SA', 30, 2500000, 36, 'rinnai-rs14sa.jpg', N'Bếp gas 4 bếp, nhập khẩu từ Nhật Bản'),
(2, N'Bình gas 12kg', 100, 500000, 24, 'binh-gas-12kg.jpg', N'Bình gas chất lượng tốt, dung tích 12kg'),
(3, N'Ống dẫn gas cao áp', 20, 100000, 12, 'ong-dan-gas.jpg', N'Ống dẫn gas cao áp, an toàn và chất lượng');

INSERT INTO Cart (UserID) 
VALUES 
(1),
(2);

INSERT INTO Cart_Detail (CartID, ProductID, Quantity, PaymentMethod, PurchaseDate, Status, TotalAmount, IsPromotionApplied) 
VALUES 
(1, 1, 2, N'Thanh toán khi nhận hàng', '2024-05-11', N'Đã thanh toán', 3000000, 1),
(1, 2, 1, N'Chuyển khoản', '2024-05-11', N'Chờ xác nhận', 2500000, 0),
(2, 3, 2, N'Thanh toán khi nhận hàng', '2024-05-11', N'Chờ thanh toán', 1000000, 1);

INSERT INTO Shipping (CartID, Status, StartShippingDate, ShippingAddress, ShippingCost) 
VALUES 
(1, N'Đang vận chuyển', '2024-05-11', N'Giao hàng nhanh', 50000),
(2, N'Chờ lấy hàng', NULL, N'Hồ Chí Minh', NULL);

INSERT INTO Product_Statistics (ProductID, ProductName, TotalSold, TotalRemaining) 
VALUES 
(1, N'Bếp gas Sunhouse SHB 3022', 3, 47),
(2, N'Bếp gas Rinnai RS-14SA', 1, 29);

INSERT INTO Special_Offers (OfferCode, StartDate, EndDate, DiscountPercentage, Description, UsageCount) 
VALUES 
('SPRINGSALE', '2024-05-01', '2024-05-31', 10, N'Giảm giá 10% cho đơn hàng trên 1.000.000đ', 100),
('NEWUSER', '2024-05-01', '2024-06-30', 15, N'Giảm giá 15% cho người dùng mới', 50);

INSERT INTO Combo_Product (Name, Price, Description, Quantity, ImageLink, WarrantyPeriod) 
VALUES 
(N'Combo bếp gas gia đình', 4000000, N'Combo gồm bếp gas Sunhouse SHB 3022 và bình gas 12kg', 10, 'combo-gas.jpg', 24);

INSERT INTO Product_Requires_Maintenance (ProductID, Name, CustomerName, WarrantyPeriod, MaintenanceStatus, ServiceType) 
VALUES 
(1, N'Bếp gas Sunhouse SHB 3022', N'Trần Văn A', 12, N'Cần bảo dưỡng', N'Bảo dưỡng định kỳ'),
(2, N'Bếp gas Rinnai RS-14SA', N'Nguyễn Thị B', 24, N'Còn hạn', N'Bảo dưỡng định kỳ');
