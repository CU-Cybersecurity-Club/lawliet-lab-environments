--
-- Add a user for testing purposes
--
-- The test user's username and password are both "lawliet".
---
SET @salt = UNHEX(SHA2(UUID(), 256));

INSERT INTO guacamole_entity
    (name, type)
VALUES
    ("lawliet", "USER");

INSERT INTO guacamole_user 
    (entity_id, password_salt, password_hash, password_date)
SELECT
    entity_id,
    @salt,
    UNHEX(SHA2(CONCAT("lawliet", HEX(@salt)), 256)),
    NOW()
FROM guacamole_entity
WHERE name = "lawliet" AND type = "USER";

--
-- Grant permission to this account to read + update itself (but not
-- to administer itself).
--
INSERT INTO guacamole_user_permission
    (entity_id, affected_user_id, permission)
SELECT
    guacamole_entity.entity_id, guacamole_user.user_id, permission
FROM (
    SELECT
        "lawliet" AS username,
        "lawliet" AS affected_username,
        "READ"    AS permission
    UNION SELECT
        "lawliet" AS username,
        "lawliet" AS affected_username,
        "UPDATE"  AS permission
) permissions
JOIN
    guacamole_entity
    ON permissions.username = guacamole_entity.name
    AND guacamole_entity.type = "USER"
JOIN
    guacamole_entity affected
    ON permissions.affected_username = affected.name
    AND guacamole_entity.type = "USER"
JOIN
    guacamole_user
    ON guacamole_user.entity_id = affected.entity_id;

--
-- Force the new user to connect 0001_vnc.sql by default.
--
INSERT INTO guacamole_connection_permission
    (entity_id, connection_id, permission)
SELECT
    entity_id,
    (
        SELECT connection_id
        FROM guacamole_connection
        WHERE connection_name = "vnc-test"
    ) as connection_id,
    "READ"
FROM guacamole_entity
WHERE name = "lawliet" AND type = "USER";
