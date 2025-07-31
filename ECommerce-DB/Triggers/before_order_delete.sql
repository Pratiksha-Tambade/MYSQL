-- Trigger to Archive Orders Before Deletion

DELIMITER //

CREATE TRIGGER before_order_delete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    -- Insert the order into the archived_orders table
    INSERT INTO archived_orders (id, order_date, customer_id, total_amount, status)
    VALUES (OLD.id, OLD.order_date, OLD.customer_id, OLD.total_amount, OLD.status);
END//

DELIMITER ;
