CREATE TABLE permissions (
      id BINARY(16) PRIMARY KEY
    , role_name VARCHAR(255) NOT NULL
    , resource VARCHAR(255) NOT NULL
    , operation ENUM('create', 'read', 'update', 'delete') NOT NULL
    , effect ENUM('allow', 'deny') NOT NULL
    , cond_type VARCHAR(255) NOT NULL
    , cond_expr TEXT NULL
    , created_on DATETIME NOT NULL
    , updated_on DATETIME NOT NULL

    , UNIQUE (role_name, resource, operation)
);

DROP TRIGGER IF EXISTS bi_permissions;
DELIMITER $$
CREATE TRIGGER bi_permissions BEFORE INSERT ON permissions FOR EACH ROW
BEGIN
    IF (NEW.id IS NULL) THEN
        SET NEW.id = UUID_TO_BIN(UUID());
    END IF;
    IF (NEW.created_on IS NULL) THEN
        SET NEW.created_on = UTC_TIMESTAMP();
    END IF;
    IF (NEW.updated_on IS NULL) THEN
        SET NEW.updated_on = UTC_TIMESTAMP();
    END IF;
END;
$$

-- Don't forget to reset the delimiter
DELIMITER ;
