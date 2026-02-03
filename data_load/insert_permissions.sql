/* Flight Logs */
-- Site Admin sees all
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('site_admin', 'flight-logs', 'read', 'allow', 'cel', 'true');

-- Squadron Admin and Squadron ARM see logs within their unit
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('squadron_arm', 'flight-logs', 'read', 'allow', 'cel', 'request_user.unit_id == log.unit_id');
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('squadron_admin', 'flight-logs', 'read', 'allow', 'cel', 'request_user.unit_id == log.unit_id');

-- Training officers see any logs they were instructor or training officer on and all logs for their unit
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('training_officer', 'flight-logs', 'read', 'allow', 'cel', 'request_user.user_id == log.user_id || request_user.unit_id == log.unit_id');

-- Pilot, Student, Instructor see any logs they are aircrew on
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('pilot', 'flight-logs', 'read', 'allow', 'cel', 'request_user.user_id == log.user_id || aircrew.exists(aircrew, request_user.user_id == aircrew.user_id && log.id == aircrew.flight_log_id)');
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('student', 'flight-logs', 'read', 'allow', 'cel', 'request_user.user_id == log.user_id || aircrew.exists(aircrew, request_user.user_id == aircrew.user_id && log.id == aircrew.flight_log_id)');
INSERT INTO permissions (role_name, resource, operation, effect, cond_type, cond_expr)
VALUES ('instructor', 'flight-logs', 'read', 'allow', 'cel', 'request_user.user_id == log.user_id || aircrew.exists(aircrew, request_user.user_id == aircrew.user_id && log.id == aircrew.flight_log_id)');
