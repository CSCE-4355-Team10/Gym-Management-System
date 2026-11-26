-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : sample_queries.sql
-- Description : Sample queries for gym data and reporting
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- Display all gym records
-- ============================================================

SELECT * FROM membership.members;

SELECT * FROM staff.trainers;

SELECT * FROM scheduling.appointments;

-- ============================================================
-- Display database role privileges
-- ============================================================

SELECT 
    r.rolname AS role_name,
    n.nspname AS schema_name,
    c.relname AS table_name,
    p.perm AS privilege
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
CROSS JOIN pg_roles r
CROSS JOIN unnest(ARRAY['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'TRUNCATE', 'REFERENCES', 'TRIGGER']) AS p(perm)
WHERE c.relkind IN ('r', 'p', 'v', 'm') -- tables, partitioned tables, views, matviews
  AND n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND r.rolname NOT LIKE 'pg_%'
  AND has_table_privilege(r.oid, c.oid, p.perm)
ORDER BY r.rolname, n.nspname, c.relname, p.perm;

-- ============================================================
-- Find members who joined in 2026
-- ============================================================

SELECT * 
FROM membership.members 
WHERE join_date >= '2026-01-01';

-- ============================================================
-- Find inactive members
-- ============================================================

SELECT * 
FROM membership.members
WHERE membership_status = 'inactive';

-- ============================================================
-- Find inactive trainers
-- ============================================================

SELECT * 
FROM staff.trainers
WHERE employment_status = 'inactive';

-- ============================================================
-- Display appointments with member and trainer details
-- ============================================================

SELECT 
    a.appointment_id,
    a.appointment_date,
    a.appointment_status,
    m.full_name AS member_name,
    m.email AS member_email,
    t.full_name AS trainer_name,
    t.specialization
FROM scheduling.appointments a
INNER JOIN membership.members m 
    ON a.member_id = m.member_id
INNER JOIN staff.trainers t 
    ON a.trainer_id = t.trainer_id
ORDER BY a.appointment_date DESC;

-- ============================================================
-- Find scheduled appointments for active members and trainers
-- ============================================================

SELECT 
    a.appointment_id,
    a.appointment_date,
    m.full_name AS member_name,
    m.phone_number,
    t.full_name AS trainer_name,
    t.specialization
FROM scheduling.appointments a
JOIN membership.members m 
    ON a.member_id = m.member_id
JOIN staff.trainers t 
    ON a.trainer_id = t.trainer_id
WHERE a.appointment_status = 'scheduled'
  AND m.membership_status = 'active'
  AND t.employment_status = 'active'
ORDER BY a.appointment_date ASC;

-- ============================================================
-- Count appointments by trainer
-- ============================================================

SELECT 
    t.trainer_id,
    t.full_name AS trainer_name,
    t.specialization,
    t.employment_status,
    COUNT(a.appointment_id) AS total_appointments,
    COUNT(a.appointment_id) FILTER (WHERE a.appointment_status = 'completed') AS completed_sessions,
    COUNT(a.appointment_id) FILTER (WHERE a.appointment_status = 'scheduled') AS upcoming_sessions
FROM staff.trainers t
LEFT JOIN scheduling.appointments a 
    ON t.trainer_id = a.trainer_id
GROUP BY t.trainer_id, t.full_name, t.specialization, t.employment_status
ORDER BY total_appointments DESC;

-- ============================================================
-- Find active members without appointments
-- ============================================================

SELECT 
    m.member_id,
    m.full_name,
    m.email,
    m.join_date
FROM membership.members m
LEFT JOIN scheduling.appointments a 
    ON m.member_id = a.member_id
WHERE a.appointment_id IS NULL
  AND m.membership_status = 'active'
ORDER BY m.join_date ASC;

-- ============================================================
-- Find scheduled appointments for inactive members
-- ============================================================

SELECT 
    m.member_id,
    m.full_name AS member_name,
    m.membership_status,
    m.membership_end_date,
    a.appointment_id,
    a.appointment_date,
    a.appointment_status
FROM membership.members m
RIGHT JOIN scheduling.appointments a 
    ON m.member_id = a.member_id
WHERE m.membership_status = 'inactive' 
  AND a.appointment_status = 'scheduled';

-- ============================================================
-- Display appointment details
-- ============================================================
SELECT * FROM reporting.appointment_details
ORDER BY appointment_date;

-- ============================================================
-- Display member loyalty tiers and discounts
-- ============================================================
SELECT * FROM reporting.member_loyalty_view
ORDER BY member_id;

-- ============================================================
-- Display former members
-- ============================================================
SELECT * FROM reporting.former_members
ORDER BY member_id;