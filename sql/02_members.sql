-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 02_members.sql
-- Description : Create member tables and constraints
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- Create members table
-- ============================================================
CREATE TABLE members (
    member_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    join_date DATE NOT NULL,
    membership_status VARCHAR(20) NOT NULL DEFAULT 'inactive' CHECK (membership_status IN ('active', 'inactive', 'suspended')),
    membership_end_date DATE,
    has_previous_membership BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_members PRIMARY KEY (member_id),
    CONSTRAINT uq_members_email UNIQUE (email),
    CONSTRAINT chk_members_full_name CHECK (full_name <> ''),
    CONSTRAINT chk_membership_status CHECK (membership_status IN ('active', 'inactive', 'suspended')),

    -- Constraint for: A membership cant end before the member joined
    CONSTRAINT chk_members_end_after_join CHECK (membership_end_date IS NULL OR membership_end_date >= join_date),

    -- Constraint for: Expired or cancelled memberships must have an end date
    CONSTRAINT chk_members_end_date_required CHECK (membership_status IN ('inactive', 'suspended') AND membership_end_date IS NOT NULL OR membership_status = 'active' AND membership_end_date IS NULL)
);

-- Speeds up filtering by status.
CREATE INDEX ix_members_status ON membership.members (membership_status);

-- =============================================================
-- Sample Data Insertion
-- =============================================================
INSERT INTO members (full_name, email, phone_number, join_date, membership_status, membership_end_date, has_previous_membership)
VALUES
    ('Lisa Smith', 'lisa.smith@example.com', '555-1234', '2023-01-15', 'active', NULL, FALSE),
    ('John Doe', 'john.doe@example.com', '555-5678', '2024-02-01', 'active', NULL, TRUE),
    ('Emily Johnson', 'emily.johnson@example.com', '555-9012', '2024-03-18', 'active', NULL, FALSE),
    ('Michael Brown', 'michael.brown@example.com', '555-3456', '2026-04-01', 'active', NULL, TRUE),
    ('Sarah Davis', 'sarah.davis@example.com', '555-7890', '2022-05-30', 'active', NULL, FALSE),
    ('David Wilson', 'david.wilson@example.com', '555-2468', '2023-06-01', 'active', NULL, TRUE),
    ('Jessica Taylor', 'jessica.taylor@example.com', '555-0123', '2025-07-01', 'active', NULL, FALSE);