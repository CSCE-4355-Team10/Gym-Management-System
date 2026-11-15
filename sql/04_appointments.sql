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
CREATE TABLE scheduling.appointments (
    appointment_id INT GENERATED ALWAYS AS IDENTITY,
    member_id INT NOT NULL,
    trainer_id INT NOT NULL,
    appointment_date TIMESTAMP NOT NULL,
    appointment_status VARCHAR(20) NOT NULL DEFAULT 'scheduled',

    CONSTRAINT pk_appointments PRIMARY KEY (appointment_id),
    CONSTRAINT fk_appointments_member FOREIGN KEY (member_id) REFERENCES membership.members(member_id) ON DELETE RESTRICT,
    CONSTRAINT fk_appointments_trainer FOREIGN KEY (trainer_id) REFERENCES staff.trainers(trainer_id) ON DELETE RESTRICT,
    CONSTRAINT chk_appointments_status CHECK (appointment_status IN ('scheduled', 'completed', 'cancelled'))
);

-- A trainer cannot have overlapping appointments. This constraint ensures that a trainer cannot have two appointments at the same time.
CREATE UNIQUE INDEX idx_trainer_appointment ON scheduling.appointments (trainer_id, appointment_date)
WHERE appointment_status <> 'cancelled';