CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE Customer (
	CustomerID		INT 	NOT NULL PRIMARY KEY,
    CustomerName	VARCHAR(30),
    CustomerAge 	INT
);

CREATE TABLE CustomerOrder (
	CustomerID		INT NOT NULL,
	OrderID 		INT 	NOT NULL PRIMARY KEY,
    OrderDate 		DATE 	NOT NULL,
    OrderTotalPrice DOUBLE 	NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

CREATE TABLE Product (
	ProductID 		INT 	NOT NULL PRIMARY KEY,
    ProductName 	VARCHAR(30),
    ProductPrice 	DOUBLE 	NOT NULL
);

CREATE TABLE OrderDetail (
	OrderID 		INT 	NOT NULL,
    ProductID 		INT 	NOT NULL,
    OrderQTY 		INT DEFAULT 2 CHECK (OrderQTY > 1),
    FOREIGN KEY (OrderID) REFERENCES CustomerOrder (OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);