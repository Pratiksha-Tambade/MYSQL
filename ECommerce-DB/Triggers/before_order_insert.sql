-- Trigger to Automatically Apply Discount to Orders Over a Certain Amount

DELIMITER //

CREATE TRIGGER before_order_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    -- Apply discount if order total exceeds 1000
    IF NEW.total_amount > 1000 THEN
        SET NEW.total_amount = NEW.total_amount * 0.9; -- Apply 10% discount
    END IF;
END//

DELIMITER ;

