-- Trigger to Validate User Email Format

DELIMITER //

CREATE TRIGGER before_user_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    -- Check if email contains '@' and '.'
    IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email format.';
    END IF;
END//

DELIMITER ;