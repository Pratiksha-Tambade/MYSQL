-- Trigger to Prevent Orders from Being Placed on Closed Dates

DELIMITER //

CREATE TRIGGER before_order_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    -- Assuming store closed dates are stored in a `closed_dates` table
    IF EXISTS (
        SELECT 1
        FROM closed_dates
        WHERE date = NEW.order_date
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot place orders on closed dates.';
    END IF;
END//

DELIMITER ;

