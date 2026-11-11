
USE BE_PetShop;
GO

CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500)
);

CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(1000),
    ImageUrl NVARCHAR(255),
    CategoryID INT NOT NULL,
    IsActive BIT DEFAULT 1,

    CONSTRAINT FK_Product_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Category(CategoryID)
);

CREATE TABLE ProductDetail (
    ProductDetailID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    SKU NVARCHAR(50),
    Price DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    SoldQuantity INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_ProductDetail_Product
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100),
    Role NVARCHAR(20) DEFAULT 'Admin'
);

CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    OrderStatus NVARCHAR(50) DEFAULT N'Chờ xử lý',
    PaymentStatus NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    ShippingAddress NVARCHAR(255),
    Phone NVARCHAR(20),

    CONSTRAINT FK_Order_Customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetail (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductDetailID INT NOT NULL,
    ProductName NVARCHAR(200) NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL,
    SubTotal DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_OrderDetail_Order
    FOREIGN KEY (OrderID)
    REFERENCES [Order](OrderID),

    CONSTRAINT FK_OrderDetail_ProductDetail
    FOREIGN KEY (ProductDetailID)
    REFERENCES ProductDetail(ProductDetailID)
);
GO
