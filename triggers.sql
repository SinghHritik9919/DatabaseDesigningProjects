DELIMITER //

CREATE TRIGGER Before_Insert_Customer
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
    -- Check if the Contact column of the new row is NULL
    IF NEW.Contact IS NULL THEN
        -- Set a default value for the Contact column
        SET NEW.Contact = 'Not Provided';
    END IF;
END //

DELIMITER ;

INSERT INTO Customer (FirstName, LastName, DOB, Email, Passwrd, Contact)
VALUES ('ram', 'sharma', '1990-01-01', 'ram@example.com', 'password123', NULL);

SELECT * FROM Customer WHERE FirstName = 'ram' AND LastName = 'sharma';