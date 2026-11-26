-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : performance_tests.sql
-- Description : Evaluate reporting and query performance
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- Test appointment details query performance
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM reporting.appointment_details
WHERE trainer_id = 3
ORDER BY appointment_date;

-- ============================================================
-- Test member loyalty query performance
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM reporting.member_loyalty_view
WHERE loyalty_tier = 'Gold'
ORDER BY join_date;

-- ============================================================
-- Test former members query performance
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM reporting.former_members
WHERE membership_end_date >= DATE '2026-01-01'
ORDER BY membership_end_date;

-- ============================================================
-- Test members who joined before 2026 query performance
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE join_date < DATE '2026-01-01'
ORDER BY join_date;

-- ============================================================
-- Test inactive members query performance
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE membership_status = 'inactive'
ORDER BY member_id;

-- ============================================================
-- Test inactive staff query performance
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM staff.trainers
WHERE employment_status = 'inactive'
ORDER BY trainer_id;

-- ============================================================
-- Compare sequential scan and index scan
-- ============================================================

-- Test sequential scan
BEGIN;
SET LOCAL enable_indexscan = off;
SET LOCAL enable_bitmapscan = off;
SET LOCAL enable_indexonlyscan = off;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE membership_status = 'inactive'
ORDER BY membership_end_date;

ROLLBACK;

-- Test index scan
BEGIN;
SET LOCAL enable_seqscan = off;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE membership_status = 'inactive'
ORDER BY membership_end_date;

ROLLBACK;

-- Test default query planner
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE membership_status = 'inactive'
ORDER BY membership_end_date;


-- ============================================================
-- Compare query performance before and after indexing
-- ============================================================
BEGIN;

-- Before indexing
DROP INDEX IF EXISTS membership.idx_members_status_end_date;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE membership_status = 'inactive'
ORDER BY membership_end_date;

-- After indexing
CREATE INDEX idx_members_status_end_date
ON membership.members (membership_status, membership_end_date);

ANALYZE membership.members;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM membership.members
WHERE membership_status = 'inactive'
ORDER BY membership_end_date;

-- Restore original database state
ROLLBACK;
