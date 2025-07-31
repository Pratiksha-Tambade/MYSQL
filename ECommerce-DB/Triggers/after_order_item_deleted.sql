-- Automatically Update total_amount in orders Table After Deleting an Item from order_items.

DROP TRIGGER IF EXISTS after_order_item_deleted;

DELIMITER //

CREATE TRIGGER after_order_item_deleted
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    DECLARE total_amount DECIMAL(10, 2);

    -- Calculate the new total amount for the order
    SELECT SUM(p.price * oi.quantity) INTO total_amount
    FROM order_items oi
    JOIN products p ON oi.item_id = p.id
    WHERE oi.order_id = OLD.order_id;

    -- Update the order's total amount
    UPDATE orders
    SET total_amount = total_amount
    WHERE id = OLD.order_id;
END//

DELIMITER ;
