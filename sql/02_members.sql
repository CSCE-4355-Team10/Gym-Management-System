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
CREATE TABLE membership.members (
    member_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    join_date DATE NOT NULL,
    membership_status VARCHAR(20) NOT NULL,
    membership_end_date DATE,
    has_previous_membership BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_members PRIMARY KEY (member_id),
    CONSTRAINT uq_members_email UNIQUE (email),
    CONSTRAINT chk_members_full_name CHECK (TRIM(full_name) <> ''),
    CONSTRAINT chk_membership_status CHECK (membership_status IN ('active', 'inactive')),


    -- Constraint for: A membership cant end before the member joined
    CONSTRAINT chk_members_end_after_join CHECK (membership_end_date IS NULL OR membership_end_date >= join_date),

    -- Constraint for: Inactive memberships must have an end date
    CONSTRAINT chk_members_end_date_required CHECK ((membership_status = 'inactive' AND membership_end_date IS NOT NULL) OR (membership_status = 'active' AND membership_end_date IS NULL))
);
