-- Automatically Set Order Status Based on Inventory Levels
-- Trigger for AFTER INSERT on order_items

DROP TRIGGER IF EXISTS after_order_item_insert;
-- Recreate the trigger with the updated logic

DELIMITER //

CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    -- Check the stock for the newly inserted item
    SELECT stock INTO available_stock
    FROM products
    WHERE id = NEW.item_id;

    -- If stock is insufficient, set the order status to "Cancelled"
    IF available_stock < NEW.quantity THEN
        UPDATE orders
        SET status = 'Cancelled'
        WHERE id = NEW.order_id;
    END IF;
END//

DELIMITER ;


SELECT * FROM orders WHERE id = 2;
SELECT stock FROM products WHERE id = 2;

INSERT INTO order_items (order_id, item_id, quantity) VALUES (2, 2, 50);
