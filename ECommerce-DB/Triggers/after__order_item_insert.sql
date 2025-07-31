-- Update Total Order Price
-- Trigger for AFTER INSERT on order_items

DROP TRIGGER IF EXISTS after_order_item_insert;

DELIMITER //

CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE total_amount DECIMAL(10, 2);

    -- Calculate the new total price for the order using the price from products table
    SELECT SUM(p.price * oi.quantity) INTO total_amount
    FROM order_items oi
    JOIN products p ON oi.item_id = p.id
    WHERE oi.order_id = NEW.order_id;

    -- Update the order's total price
    UPDATE orders
    SET total_amount = total_amount
    WHERE id = NEW.order_id;
END//

DELIMITER ;


INSERT INTO order_items (order_id, item_id, quantity) VALUES
(3, 1, 3); -- 2 Smartphones

SELECT * FROM orders WHERE id = 3;
