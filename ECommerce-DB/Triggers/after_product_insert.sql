-- Trigger for Insert on Products 
DROP TRIGGER after_product_insert;

	DELIMITER //

	CREATE TRIGGER after_product_insert
	AFTER INSERT ON inventory
	FOR EACH ROW 
	BEGIN
	INSERT INTO product_audit(Product_id, action_type, new_stock_quantity, action_timestamp )
	VALUES(NEW.product_id, 'INSERT', NEW.stock_quantity , NOW());
	END//

	DELIMITER ; 
    