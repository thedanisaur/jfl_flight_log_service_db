CREATE TABLE flight_log_comments (
      id BINARY(16) PRIMARY KEY
    , flight_log_id BINARY(16) NOT NULL
    , user_id BINARY(16) NOT NULL
    , role_name VARCHAR(255) NOT NULL
    , comment TEXT NULL
    , created_on DATETIME NOT NULL
    , updated_on DATETIME NOT NULL

    , CONSTRAINT flight_log_comments_flight_log_id_fkey FOREIGN KEY (flight_log_id)
        REFERENCES flight_logs (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS bi_flight_log_comments;
DELIMITER $$
CREATE TRIGGER bi_flight_log_comments BEFORE INSERT ON flight_log_comments FOR EACH ROW
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
