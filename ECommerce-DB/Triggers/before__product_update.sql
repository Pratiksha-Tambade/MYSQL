-- Trigger for UPDATE on Products


DROP TRIGGER before_product_update;

DELIMITER //

CREATE TRIGGER before_product_update
BEFORE UPDATE ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO product_audit (product_id, action_type, old_stock_quantity, new_stock_quantity)
    VALUES (OLD.product_id, 'UPDATE', OLD.stock_quantity, NEW.stock_quantity);
END//

DELIMITER ;


update inventory
SET stock_quantity = 600
WHERE product_id=1;
