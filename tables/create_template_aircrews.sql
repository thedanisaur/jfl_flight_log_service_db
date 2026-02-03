CREATE TABLE template_aircrews (
      id BINARY(16) PRIMARY KEY
    , flight_log_id BINARY(16) NOT NULL
    , user_id BINARY(16) NOT NULL
    , flying_origin VARCHAR(255)  NOT NULL
    , flight_auth_code VARCHAR(255)  NOT NULL
    , time_primary DECIMAL(5,1) NULL
    , time_secondary DECIMAL(5,1) NULL
    , time_instructor DECIMAL(5,1) NULL
    , time_evaluator DECIMAL(5,1) NULL
    , time_other DECIMAL(5,1) NULL
    , total_aircrew_duration_decimal DECIMAL(5,1) NULL
    , total_aircrew_sorties INT NULL
    , cond_night_time DECIMAL(5,1) NULL
    , cond_instrument_time DECIMAL(5,1) NULL
    , cond_sim_instrument_time DECIMAL(5,1) NULL
    , cond_nvg_time DECIMAL(5,1) NULL
    , cond_combat_time DECIMAL(5,1) NULL
    , cond_combat_sortie INT NULL
    , cond_combat_support_time DECIMAL(5,1) NULL
    , cond_combat_support_sortie INT NULL
    , aircrew_role_type VARCHAR(255) /* TODO [drd] this is auto assigned as Pilot, fix */
    , created_on DATETIME NOT NULL
    , updated_on DATETIME NOT NULL

    , CONSTRAINT template_aircrews_flight_log_id_fkey FOREIGN KEY (flight_log_id)
        REFERENCES template_flight_logs (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS bi_template_aircrews;
DELIMITER $$
CREATE TRIGGER bi_template_aircrews BEFORE INSERT ON template_aircrews FOR EACH ROW
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
