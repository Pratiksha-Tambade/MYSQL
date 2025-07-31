-- Trigger for DELETE on `order_items
DROP TRIGGER after_order_item_delete;

DELIMITER //

CREATE TRIGGER after_order_item_delete
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE product_id = OLD.item_id;
END//

DELIMITER ;

DELETE FROM order_items WHERE order_id = 1 AND item_id = 1;
SELECT * FROM inventory WHERE product_id = 1;

