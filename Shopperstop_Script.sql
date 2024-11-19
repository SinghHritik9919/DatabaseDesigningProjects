CREATE DATABASE IF NOT EXISTS shopperstop;

USE shopperstop;

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Passwrd VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL
);

CREATE TABLE Country (
    CountryID INT AUTO_INCREMENT PRIMARY KEY,
    CountryName VARCHAR(255) NOT NULL
);

CREATE TABLE Province (
    ProvinceID INT AUTO_INCREMENT PRIMARY KEY,
    ProvinceName VARCHAR(255) NOT NULL
);

CREATE TABLE City (
    CityID INT AUTO_INCREMENT PRIMARY KEY,
    CityName VARCHAR(255) NOT NULL
);

CREATE TABLE ZipCode (
    ZipCodeID INT AUTO_INCREMENT PRIMARY KEY,
    CityID INT,
    ProvinceID INT,
    CountryID INT,
    FOREIGN KEY (CityID) REFERENCES City(CityID),
    FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    HouseNo VARCHAR(255) NOT NULL,
    Street INT NOT NULL,
    CustomerID INT,
    ZipCodeID INT,
    Area  VARCHAR(255) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ZipCodeID) REFERENCES ZipCode(ZipCodeID)
);

CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Vendor (
    VendorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Passwrd VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE VendorProduct (
    VendorProductID INT AUTO_INCREMENT PRIMARY KEY,
    VendorID INT,
    ProductID INT,
    Price DECIMAL(19, 2) NOT NULL,
    Quantity INT NOT NULL,
    Descrption TEXT NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Courier (
    CourierID INT AUTO_INCREMENT PRIMARY KEY,
    courier_name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL
);

CREATE TABLE VendorCourier (
    VendorCourierID INT AUTO_INCREMENT PRIMARY KEY,
    VendorID INT,
    CourierID INT,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    AddressID INT,
    VendorCourierID INT,
    TrackingID VARCHAR(255) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (VendorCourierID) REFERENCES VendorCourier(VendorCourierID)
);

CREATE TABLE OrderedProduct (
    OrderedProductID INT AUTO_INCREMENT PRIMARY KEY,
    VendorProductID INT,
    OrderID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (VendorProductID) REFERENCES VendorProduct(VendorProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    Rating TINYINT NOT NULL,
    review TEXT,
    CustomerID INT,
    OrderedProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (OrderedProductID) REFERENCES OrderedProduct(OrderedProductID)
);

CREATE TABLE Cart (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    DateCreated DATE NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE CartProduct (
    CartProductID INT AUTO_INCREMENT PRIMARY KEY,
    VendorProductID INT,
    Quantity INT NOT NULL,
    CartID INT,
    FOREIGN KEY (VendorProductID) REFERENCES VendorProduct(VendorProductID),
    FOREIGN KEY (CartID) REFERENCES Cart(CartID)
);


-- Inserting data into Customer table
INSERT INTO Customer (FirstName, LastName, DOB, Email, Passwrd, Contact) VALUES
('John', 'Doe', '1990-05-15', 'john@example.com', 'password', '1234567890'),
('Alice', 'Smith', '1985-09-20', 'alice@example.com', 'password', '9876543210'),
('Michael', 'Johnson', '1982-07-10', 'michael@example.com', 'password', '7890123456'),
('Emily', 'Brown', '1993-02-28', 'emily@example.com', 'password', '8901234567'),
('Daniel', 'Lee', '1988-11-12', 'daniel@example.com', 'password', '4567890123'),
('Sophia', 'Taylor', '1976-04-08', 'sophia@example.com', 'password', '2345678901'),
('David', 'Anderson', '1995-08-03', 'david@example.com', 'password', '6789012345'),
('Emma', 'Wilson', '1980-12-25', 'emma@example.com', 'password', '9012345678'),
('James', 'Martinez', '1979-03-17', 'james@example.com', 'password', '3456789012'),
('Olivia', 'Garcia', '1991-06-30', 'olivia@example.com', 'password', '5678901234');

Select * from Customer;

-- Inserting data into Country table
INSERT INTO Country (CountryName) VALUES
('USA'),
('Canada'),
('UK'),
('Germany'),
('France'),
('Australia'),
('Japan'),
('Brazil'),
('India'),
('Italy');

-- Inserting data into Province table
INSERT INTO Province (ProvinceName) VALUES
('California'),
('Ontario'),
('England'),
('Bavaria'),
('Île-de-France'),
('New South Wales'),
('Tokyo'),
('São Paulo'),
('Maharashtra'),
('Lazio');

-- Inserting data into City table
INSERT INTO City (CityName) VALUES
('Los Angeles'),
('Toronto'),
('London'),
('Munich'),
('Paris'),
('Sydney'),
('Tokyo'),
('São Paulo'),
('Mumbai'),
('Rome');

-- Inserting data into ZipCode table
INSERT INTO ZipCode (CityID, ProvinceID, CountryID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

-- Inserting data into Address table
INSERT INTO Address (HouseNo, Street, CustomerID, ZipCodeID, Area) VALUES
('123', 1, 1, 1, 'Downtown LA'),
('456', 2, 2, 2, 'Downtown Toronto'),
('789', 3, 3, 3, 'Central London'),
('321', 4, 4, 4, 'Central Munich'),
('654', 5, 5, 5, 'Central Paris'),
('987', 6, 6, 6, 'Central Sydney'),
('210', 7, 7, 7, 'Central Tokyo'),
('543', 8, 8, 8, 'Central São Paulo'),
('876', 9, 9, 9, 'Central Mumbai'),
('987', 10, 10, 10, 'Central Rome');

-- Inserting data into Category table
INSERT INTO Category (CategoryName) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Sports'),
('Beauty'),
('Toys'),
('Food & Grocery'),
('Health'),
('Automotive');

-- Inserting data into Vendor table
INSERT INTO Vendor (Name, Address, Email, Passwrd, Contact) VALUES
('ElectroTech', '123 Tech Avenue, Los Angeles', 'info@electrotech.com', 'password', '1234567890'),
('FashionFusion', '456 Fashion Street, Toronto', 'info@fashionfusion.com', 'password', '9876543210'),
('BookBarn', '789 Book Road, London', 'info@bookbarn.com', 'password', '7890123456'),
('HomeHeaven', '321 Home Street, Munich', 'info@homeheaven.com', 'password', '8901234567'),
('SportSpot', '654 Sport Avenue, Paris', 'info@sportspot.com', 'password', '4567890123'),
('BeautyBoutique', '987 Beauty Boulevard, Sydney', 'info@beautyboutique.com', 'password', '2345678901'),
('ToyEmporium', '210 Toy Street, Tokyo', 'info@toyemporium.com', 'password', '6789012345'),
('GroceryGalore', '543 Grocery Avenue, São Paulo', 'info@grocerygalore.com', 'password', '9012345678'),
('HealthyHub', '876 Health Street, Mumbai', 'info@healthyhub.com', 'password', '3456789012'),
('AutoAccess', '987 Auto Road, Rome', 'info@autoaccess.com', 'password', '5678901234');

-- Inserting data into Product table
INSERT INTO Product (ProductName, CategoryID) VALUES
('Smartphone', 1),
('T-shirt', 2),
('Novel', 3),
('Cookware Set', 4),
('Football', 5),
('Lipstick', 6),
('Action Figure', 7),
('Rice', 8),
('Vitamin Supplement', 9),
('Car Battery', 10);

-- Inserting data into VendorProduct table
INSERT INTO VendorProduct (VendorID, ProductID, Price, Quantity, Descrption) VALUES
(1, 1, 499.99, 100, 'Latest model smartphone with advanced features'),
(2, 2, 29.99, 200, 'Comfortable cotton T-shirt in various colors'),
(3, 3, 14.99, 150, 'Bestselling novel by renowned author'),
(4, 4, 149.99, 50, 'Non-stick cookware set for your kitchen needs'),
(5, 5, 19.99, 100, 'Official football for professional matches'),
(6, 6, 9.99, 300, 'Long-lasting lipstick in a variety of shades'),
(7, 7, 24.99, 50, 'Popular action figure for kids and collectors'),
(8, 8, 9.99, 500, 'High-quality rice for everyday cooking'),
(9, 9, 29.99, 200, 'Essential vitamin supplement for daily health'),
(10, 10, 99.99, 50, 'Reliable car battery for various vehicle models');

-- Inserting data into Courier table
INSERT INTO Courier (courier_name, Contact) VALUES
('Speedy Express', '123-456-7890'),
('Swift Delivery', '987-654-3210'),
('Fast Track', '789-012-3456'),
('Rapid Ship', '890-123-4567'),
('Quick Courier', '456-789-0123'),
('Express Service', '234-567-8901'),
('Prompt Parcel', '678-901-2345'),
('Speedy Shipment', '901-234-5678'),
('Swift Transport', '345-678-9012'),
('Fast Delivery', '567-890-1234');

-- Inserting data into VendorCourier table
INSERT INTO VendorCourier (VendorID, CourierID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Inserting data into Orders table
INSERT INTO Orders (CustomerID, OrderDate, AddressID, VendorCourierID, TrackingID) VALUES
(1, '2024-04-01', 1, 1, 'TRACK123456'),
(2, '2024-04-02', 2, 2, 'TRACK654321'),
(3, '2024-04-03', 3, 3, 'TRACK789012'),
(4, '2024-04-04', 4, 4, 'TRACK210987'),
(5, '2024-04-05', 5, 5, 'TRACK345678'),
(6, '2024-04-06', 6, 6, 'TRACK876543'),
(7, '2024-04-07', 7, 7, 'TRACK901234'),
(8, '2024-04-08', 8, 8, 'TRACK456789'),
(9, '2024-04-09', 9, 9, 'TRACK234567'),
(10, '2024-04-10', 10, 10, 'TRACK567890');

-- Inserting data into OrderedProduct table
INSERT INTO OrderedProduct (VendorProductID, OrderID, Quantity) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1),
(4, 4, 2),
(5, 5, 1),
(6, 6, 4),
(7, 7, 2),
(8, 8, 3),
(9, 9, 1),
(10, 10, 2);

-- Inserting data into Review table
INSERT INTO Review (Rating, review, CustomerID, OrderedProductID) VALUES
(5, 'Great product, highly recommended!', 1, 1),
(4, 'Good quality, fast delivery.', 2, 2),
(5, 'Excellent service and product.', 3, 3),
(4, 'Satisfied with the purchase.', 4, 4),
(5, 'Awesome experience overall.', 5, 5),
(3, 'Product was okay, delivery took longer than expected.', 6, 6),
(4, 'Nice toy, my kid loves it!', 7, 7),
(5, 'Delicious rice, will buy again.', 8, 8),
(4, 'Feeling healthier already!', 9, 9),
(5, 'Car started up smoothly, thank you!', 10, 10);

-- Inserting data into Cart table
INSERT INTO Cart (DateCreated, CustomerID) VALUES
('2024-04-01', 1),
('2024-04-02', 2),
('2024-04-03', 3),
('2024-04-04', 4),
('2024-04-05', 5),
('2024-04-06', 6),
('2024-04-07', 7),
('2024-04-08', 8),
('2024-04-09', 9),
('2024-04-10', 10);

-- Inserting data into CartProduct table
INSERT INTO CartProduct (VendorProductID, Quantity, CartID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 3),
(4, 2, 4),
(5, 1, 5),
(6, 3, 6),
(7, 2, 7),
(8, 1, 8),
(9, 1, 9),
(10, 2, 10);

show create view ordersummary;
show create view productlist;


