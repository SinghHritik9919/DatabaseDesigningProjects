
-- view
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER 
VIEW `ordersummary` AS 
SELECT 
    `o`.`OrderID` AS `OrderID`,
    `o`.`OrderDate` AS `OrderDate`,
    SUM(`op`.`Quantity`) AS `TotalQuantity`,
    SUM((`vp`.`Price` * `op`.`Quantity`)) AS `TotalAmount` 
FROM 
    `orders` `o`
    JOIN `orderedproduct` `op` ON `o`.`OrderID` = `op`.`OrderID`
    JOIN `vendorproduct` `vp` ON `op`.`VendorProductID` = `vp`.`VendorProductID`
GROUP BY 
    `o`.`OrderID`,
    `o`.`OrderDate`;
    
    
    
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER 
VIEW `productlist` AS 
SELECT 
    `product`.`ProductID` AS `ProductID`,
    `product`.`ProductName` AS `ProductName`,
    `category`.`CategoryName` AS `CategoryName` 
FROM 
    `product`
    JOIN `category` ON `product`.`CategoryID` = `category`.`CategoryID`;
    
-- stored procedures 
-- vendor
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVendorSalesReport`(
    IN vendorId INT
)
BEGIN
    SELECT vp.ProductID, p.ProductName, SUM(op.Quantity) AS TotalSales, SUM(vp.Price * op.Quantity) AS TotalRevenue
    FROM OrderedProduct op
    JOIN VendorProduct vp ON op.VendorProductID = vp.VendorProductID
    JOIN Product p ON vp.ProductID = p.ProductID
    JOIN Orders o ON op.OrderID = o.OrderID
    WHERE vp.VendorID = vendorId
    GROUP BY vp.ProductID, p.ProductName;
END$$
DELIMITER ;


-- customerorderHistory
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerOrderHistory`(
    IN customerId INT
)
BEGIN
    SELECT o.OrderID, o.OrderDate, a.Area, c.CityName, p.ProvinceName, co.CountryName
    FROM Orders o
    JOIN Address a ON o.AddressID = a.AddressID
    JOIN ZipCode z ON a.ZipCodeID = z.ZipCodeID
    JOIN City c ON z.CityID = c.CityID
    JOIN Province p ON z.ProvinceID = p.ProvinceID
    JOIN Country co ON z.CountryID = co.CountryID
    WHERE o.CustomerID = customerId;
END$$
DELIMITER ;

-- CalculateOrdertotalFunction
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateOrderTotal`(orderId INT) RETURNS decimal(19,2)
    READS SQL DATA
BEGIN
    DECLARE totalAmount DECIMAL(19, 2);
    
    SELECT SUM(vp.Price * op.Quantity)
    INTO totalAmount
    FROM OrderedProduct op
    JOIN VendorProduct vp ON op.VendorProductID = vp.VendorProductID
    WHERE op.OrderID = orderId;
    
    RETURN totalAmount;
END$$
DELIMITER ;


