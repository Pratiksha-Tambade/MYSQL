-- Trigger to Automatically Update User Points Based on Order Total
DELIMITER //

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Assuming 1 point per 10 units of order total
    UPDATE users
    SET points = points + FLOOR(NEW.total_amount / 10)
    WHERE id = NEW.customer_id;
END//

DELIMITER ;
