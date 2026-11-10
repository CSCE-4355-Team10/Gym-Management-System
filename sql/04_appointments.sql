-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 04_appointments.sql
-- Description : Create appointment tables and constraints
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- Create appointments table
-- ============================================================
CREATE TABLE appointments (
    appointment_id INT GENERATED ALWAYS AS IDENTITY,
    member_id INT NOT NULL,
    trainer_id INT NOT NULL,
    appointment_date TIMESTAMP NOT NULL, -- date and time
    appointment_status VARCHAR(20) NOT NULL DEFAULT 'scheduled' CHECK (appointment_status IN ('scheduled', 'completed', 'cancelled')),

    CONSTRAINT pk_appointments PRIMARY KEY (appointment_id),
    CONSTRAINT fk_appointments_member FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE RESTRICT
    CONSTRAINT fk_appointments_trainer FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id) ON DELETE RESTRICT,
    CONSTRAINT chk_appointments_status CHECK (appointment_status IN ('scheduled', 'completed', 'cancelled')),

    -- Constraint for: An appointment cannot be scheduled in the past
    CONSTRAINT chk_appointments_future_date CHECK (appointment_date >= CURRENT_TIMESTAMP)
);

-- A trainer cannot have overlapping appointments. This constraint ensures that a trainer cannot have two appointments at the same time.
CREATE UNIQUE INDEX idx_trainer_appointment ON appointments (trainer_id, appointment_date)
WHERE appointment_status <> 'cancelled';

-- Speeds up "all appointments for a member" lookups and joins.
CREATE INDEX ix_appointments_member_id ON appointments (member_id);

-- =============================================================
-- Sample Data Insertion
-- =============================================================
INSERT INTO appointments (member_id, trainer_id, appointment_date, appointment_status)
VALUES
    (1, 1, '2026-10-05 09:00', 'Completed'),
    (1, 2, '2026-10-12 17:30', 'Completed'),
    (1, 1, '2026-11-16 09:00', 'Scheduled'),
    (2, 3, '2026-10-20 18:00', 'Completed'),
    (2, 3, '2026-11-17 18:00', 'Scheduled'),
    (3, 2, '2026-11-16 09:00', 'Scheduled'),   -- same time as above, different trainer: allowed
    (3, 2, '2026-11-02 12:00', 'Cancelled'),
    (6, 2, '2026-11-02 12:00', 'Scheduled'),   -- rebooks the cancelled slot: allowed
    (7, 3, '2026-11-18 07:00', 'Scheduled'),
    (5, 4, '2026-11-10 10:00', 'Completed');