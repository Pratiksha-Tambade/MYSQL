-- Trigger to Update the Last Modified Date on Product Changes

DELIMITER //

CREATE TRIGGER before_product_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    -- Set the last_modified field to the current timestamp
    SET NEW.last_modified = NOW();
END//

DELIMITER ;