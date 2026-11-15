-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 03_trainers.sql
-- Description : Create trainer tables and constraints
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- Create trainers table
-- ============================================================
CREATE TABLE staff.trainers (
    trainer_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    employment_status VARCHAR(20) NOT NULL,

    CONSTRAINT pk_trainers PRIMARY KEY (trainer_id),
    CONSTRAINT uq_trainers_email UNIQUE (email),
    CONSTRAINT chk_trainers_full_name CHECK (TRIM(full_name) <> ''),
    CONSTRAINT chk_trainers_status CHECK (employment_status IN ('active', 'inactive')),

    -- Constraint for: A trainer's hire date cannot be in the future
    CONSTRAINT chk_trainers_hire_date CHECK (hire_date <= CURRENT_DATE)
);
