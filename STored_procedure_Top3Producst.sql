CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTop3Products`()
BEGIN
    SELECT p.ProductName, SUM(op.Quantity) AS TotalQuantityOrdered
    FROM Product p
    INNER JOIN VendorProduct vp ON p.ProductID = vp.ProductID
    INNER JOIN OrderedProduct op ON vp.VendorProductID = op.VendorProductID
    GROUP BY p.ProductID
    ORDER BY TotalQuantityOrdered DESC
    LIMIT 3;
END