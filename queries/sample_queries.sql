-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : sample_queries.sql
-- Description : Code to output our data
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- ============================================================

-- 
-- 
-- 
SELECT * FROM membership.members;

SELECT * FROM staff.trainers;

SELECT * FROM scheduling.appointments;

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

SELECT * 
FROM membership.members 
WHERE join_date >= '2026-01-01';

SELECT * 
FROM membership.members
WHERE membership_status = 'inactive';

SELECT * 
FROM staff.trainers
WHERE employment_status = 'inactive';
