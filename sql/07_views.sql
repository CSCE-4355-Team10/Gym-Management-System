-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 07_views.sql
-- Description : Create reporting views for gym management
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- Create appointment details view
-- ============================================================
CREATE OR REPLACE VIEW reporting.appointment_details AS
SELECT
    appt.appointment_id,
    mem.member_id,
    mem.full_name AS member_name,
    tr.trainer_id,
    tr.full_name AS trainer_name,
    tr.specialization,
    appt.appointment_date,
    appt.appointment_status
FROM scheduling.appointments AS appt
JOIN membership.members AS mem ON appt.member_id = mem.member_id
JOIN staff.trainers AS tr ON appt.trainer_id = tr.trainer_id;

-- ============================================================
-- Verify appointment details view
-- ============================================================
SELECT * FROM reporting.appointment_details
ORDER BY appointment_date;

-- ============================================================
-- Create member loyalty view
-- ============================================================
CREATE OR REPLACE VIEW reporting.member_loyalty_view AS
SELECT
    mem.member_id,
    mem.full_name AS member_name,
    mem.join_date,
    mem.membership_status,
    mem.has_previous_membership,
    CASE
        WHEN mem.membership_status = 'inactive' THEN 'Inactive'
        WHEN mem.join_date > CURRENT_DATE - INTERVAL '6 months' THEN 'Regular'
        WHEN mem.join_date > CURRENT_DATE - INTERVAL '12 months' THEN 'Silver'
        WHEN mem.join_date > CURRENT_DATE - INTERVAL '24 months' THEN 'Gold'
        ELSE 'Platinum'
    END AS loyalty_tier,
    CASE
        WHEN mem.membership_status = 'inactive' THEN 0
        WHEN mem.has_previous_membership = TRUE
             AND mem.join_date <= CURRENT_DATE
             AND CURRENT_DATE < mem.join_date + INTERVAL '1 month' THEN 20
        WHEN mem.join_date > CURRENT_DATE - INTERVAL '6 months' THEN 0
        WHEN mem.join_date > CURRENT_DATE - INTERVAL '12 months' THEN 5
        WHEN mem.join_date > CURRENT_DATE - INTERVAL '24 months' THEN 10
        ELSE 15
    END AS discount_percentage
FROM membership.members AS mem;

-- ============================================================
-- Verify member loyalty view
-- ============================================================
SELECT * FROM reporting.member_loyalty_view
ORDER BY member_id;

-- ============================================================
-- Verify inactive and returning members
-- ============================================================
SELECT * FROM reporting.member_loyalty_view
WHERE membership_status = 'inactive'
   OR has_previous_membership = TRUE
ORDER BY member_id;

-- ============================================================
-- Create former members view
-- ============================================================
CREATE OR REPLACE VIEW reporting.former_members AS
SELECT
    mem.member_id,
    mem.full_name AS member_name,
    mem.email,
    mem.join_date,
    mem.membership_end_date,
    mem.membership_status
FROM membership.members AS mem
WHERE mem.membership_status = 'inactive';

-- ============================================================
-- Verify former members view
-- ============================================================
SELECT * FROM reporting.former_members
ORDER BY member_id;




