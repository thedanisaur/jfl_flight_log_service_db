DROP VIEW IF EXISTS flight_logs_vw;

CREATE OR REPLACE VIEW flight_logs_vw
AS
    SELECT BIN_TO_UUID(fl.id) AS "flight_log_id"
        , BIN_TO_UUID(fl.user_id) AS "user_id"
        , fl.mds
        , fl.flight_log_date
        , fl.serial_number
        , fl.unit_charged
        , fl.harm_location
        , fl.flight_authorization
        , fl.issuing_unit
        , fl.is_training_flight
        , fl.is_training_only
        , fl.total_flight_decimal_time
        , fl.scheduler_signature_id
        , fl.sarm_signature_id
        , fl.instructor_signature_id
        , fl.student_signature_id
        , fl.training_officer_signature_id
        , fl.type
        , fl.remarks
        , GROUP_CONCAT(DISTINCT BIN_TO_UUID(a.user_id) ORDER BY a.user_id SEPARATOR ',') AS aircrew_user_ids
    FROM flight_logs fl
    LEFT JOIN
        aircrews a ON fl.id = a.flight_log_id
    GROUP BY
        fl.id,
        fl.user_id,
        fl.flight_log_date
;
