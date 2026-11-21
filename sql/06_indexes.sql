-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : Create 06_indexes.sql
-- Description : Create indexes for Query Optimization
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- ============================================================

-- 
-- 
-- 
CREATE INDEX idx_members_email ON membership.members (email);
CREATE INDEX idx_members_full_name ON membership.members (full_name);
CREATE INDEX idx_members_status_end_date ON membership.members (membership_status, membership_end_date);
CREATE INDEX idx_trainers_email ON staff.trainers (email);
CREATE INDEX idx_trainers_specialization_status ON staff.trainers (specialization, employment_status);
CREATE INDEX idx_appointments_member_id ON scheduling.appointments (member_id);
CREATE INDEX idx_appointments_trainer_date ON scheduling.appointments (trainer_id, appointment_date);
CREATE INDEX idx_appointments_status_date ON scheduling.appointments (appointment_status, appointment_date);
