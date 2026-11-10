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
CREATE TABLE trainers (
    trainer_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    employment_status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (employment_status IN ('active', 'inactive', 'suspended')),

    CONSTRAINT pk_trainers PRIMARY KEY (trainer_id),
    CONSTRAINT uq_trainers_email UNIQUE (email),
    CONSTRAINT chk_trainers_full_name CHECK (full_name <> ''),
    CONSTRAINT chk_trainers_status CHECK (employment_status IN ('active', 'inactive', 'suspended')),

    -- Constraint for: A trainer's hire date cannot be in the future
    CONSTRAINT chk_trainers_hire_date CHECK (hire_date <= CURRENT_DATE)
);

-- Speeds up filtering by status (e.g. only booking Active trainers).
CREATE INDEX ix_trainers_status ON trainers (employment_status);

-- =============================================================
-- Sample Data Insertion
-- =============================================================
INSERT INTO trainers (full_name, email, specialty, hire_date, employment_status)
VALUES
    ('Alice Johnson', 'alice.johnson@example.com', 'Pilates', '2020-01-15', 'active'),
    ('Sergio Martinez', 'sergio.martinez@example.com', 'Strength Training', '2019-06-10', 'active'),
    ('Hanah Matthews', 'hanah.matthews@example.com', 'Yoga', '2021-03-22', 'active'),
    ('David Lee', 'david.lee@example.com', 'Cardio', '2020-11-05', 'active'),
    ('Emily Davis', 'emily.davis@example.com', 'Strength Training', '2020-08-12', 'active');