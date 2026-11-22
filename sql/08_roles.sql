-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 08_roles.sql
-- Description : Create and assign permissions to specific roles
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- ============================================================

-- 
-- 
-- 
    
CREATE ROLE Member NOLOGIN;
GRANT CONNECT ON DATABASE gym_management_db TO Member;
GRANT USAGE ON SCHEMA membership TO Member;
GRANT SELECT ON ALL TABLES IN SCHEMA membership TO Member;
GRANT USAGE ON SCHEMA scheduling TO Member;
GRANT SELECT ON ALL TABLES IN SCHEMA scheduling TO Member;

CREATE ROLE Trainer NOLOGIN;
GRANT CONNECT ON DATABASE gym_management_db TO Trainer;
GRANT USAGE ON SCHEMA staff TO Trainer;
GRANT SELECT ON ALL TABLES IN SCHEMA staff TO Trainer;
GRANT USAGE ON SCHEMA scheduling TO Trainer;
GRANT SELECT ON ALL TABLES IN SCHEMA scheduling TO Trainer;
GRANT INSERT ON ALL TABLES IN SCHEMA scheduling TO Trainer;
GRANT UPDATE ON ALL TABLES IN SCHEMA scheduling TO Trainer;
GRANT USAGE ON SCHEMA membership TO Trainer;
GRANT SELECT ON ALL TABLES IN SCHEMA membership TO Trainer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA scheduling TO Trainer;

CREATE ROLE admin NOLOGIN;

GRANT ALL PRIVILEGES ON DATABASE gym_management_db TO admin;
GRANT ALL PRIVILEGES ON SCHEMA staff, scheduling, membership, reporting TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA staff, scheduling, membership, reporting TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA staff, scheduling, membership, reporting TO admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA staff, scheduling, membership, reporting
GRANT ALL PRIVILEGES ON TABLES TO admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA staff, scheduling, membership, reporting
GRANT ALL PRIVILEGES ON SEQUENCES TO admin;
