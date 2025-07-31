-- Trigger for DELETE on Products
DROP TRIGGER after_product_delete;

DELIMITER //

CREATE TRIGGER after_product_delete
AFTER DELETE ON inventory
FOR EACH ROW
BEGIN
INSERT INTO product_audit(product_id,action_type,old_stock_quantity)
VALUES(OLD.product_id,'DELETE', OLD.stock_quantity);
END //

DELIMITER ;

select * from product_audit;
DELETE FROM inventory WHERE product_id=3;
