CREATE TABLE template_flight_logs (
      id BINARY(16) PRIMARY KEY
    , name VARCHAR(255) NOT NULL
    , user_id BINARY(16) NOT NULL
    , mds VARCHAR(255) NOT NULL
    , flight_log_date DATETIME NOT NULL
    , serial_number VARCHAR(255) NOT NULL
    , unit_charged VARCHAR(255) NOT NULL
    , harm_location VARCHAR(255) NOT NULL
    , flight_authorization VARCHAR(255) NOT NULL
    , issuing_unit VARCHAR(255) NOT NULL
    /* Fix this, we should really just have an ops flag and a training flag */
    , is_training_flight BOOLEAN NOT NULL /* is this for training, in addition to ops */
    , is_training_only BOOLEAN NOT NULL /* is this only for training, not for ops */
    , total_flight_decimal_time DECIMAL(5,1) NULL
    , scheduler_signature_id BINARY(16) NULL
    , sarm_signature_id BINARY(16) NULL
    , instructor_signature_id BINARY(16) NULL
    , student_signature_id BINARY(16) NULL
    , training_officer_signature_id BINARY(16) NULL
    , type VARCHAR(255) NULL
    , remarks TEXT NULL
    , created_on DATETIME NOT NULL
    , updated_on DATETIME NOT NULL

    , UNIQUE (name, user_id)
);

DROP TRIGGER IF EXISTS bi_template_flight_logs;
DELIMITER $$
CREATE TRIGGER bi_template_flight_logs BEFORE INSERT ON template_flight_logs FOR EACH ROW
BEGIN
    IF (NEW.id IS NULL) THEN
        SET NEW.id = UUID_TO_BIN(UUID());
    END IF;
    IF (NEW.is_training_flight IS NULL) THEN
        /* Set is_training_flight to 0 (FALSE) */
        SET NEW.is_training_flight = 0;
    END IF;
    IF (NEW.is_training_only IS NULL) THEN
        /* Set is_training_only to 0 (FALSE) */
        SET NEW.is_training_only = 0;
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
