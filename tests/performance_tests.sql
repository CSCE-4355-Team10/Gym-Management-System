
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

