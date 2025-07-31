-- Trigger to Log Changes to Product Prices

DELIMITER //

CREATE TRIGGER after_product_price_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    -- Insert a record into the price_changes table
    INSERT INTO price_changes (product_id, old_price, new_price, change_date)
    VALUES (OLD.id, OLD.price, NEW.price, NOW());
END//

DELIMITER ;


UPDATE products
SET price = 733.99
WHERE id = 1;

SELECT * FROM price_changes
WHERE product_id = 1
ORDER BY change_date DESC;
