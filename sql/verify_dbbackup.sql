-- =============================================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- File        : verify_dbbackup.sql
-- Description : Backup & recovery verification. Run against the ORIGINAL
--               database and the RESTORED test database, then compare the two outputs.
-- Database    : gym_management_db / gym_management_db_test
--
--   psql -U postgres -d gym_management_db      -f verify_dbbackup.sql -o before.txt
--   psql -U postgres -d gym_management_db_test -f verify_dbbackup.sql -o after.txt
-- =============================================================================

\qecho '========== 1. SCHEMAS =========='
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN ('membership', 'staff', 'scheduling', 'reporting')
ORDER BY schema_name;

\qecho '========== 2. TABLES AND VIEWS =========='
SELECT table_schema, table_name, table_type
FROM information_schema.tables
WHERE table_schema IN ('membership', 'staff', 'scheduling', 'reporting')
ORDER BY table_schema, table_type, table_name;

\qecho '========== 3. CONSTRAINTS (PK, FK, UNIQUE, CHECK) =========='
SELECT n.nspname              AS schema_name,
  c.conrelid::regclass   AS table_name,
  c.conname              AS constraint_name,
    CASE c.contype
      WHEN 'p' THEN 'PRIMARY KEY'
      WHEN 'f' THEN 'FOREIGN KEY'
      WHEN 'u' THEN 'UNIQUE'
      WHEN 'c' THEN 'CHECK'
      ELSE c.contype::text
    END AS constraint_type
FROM pg_constraint c
JOIN pg_namespace n ON n.oid = c.connamespace
WHERE n.nspname IN ('membership', 'staff', 'scheduling', 'reporting')
AND c.contype IN ('p', 'f', 'u', 'c')
ORDER BY 1, 2::text, 4, 3;

\qecho '========== 4. INDEXES (includes unique index that blocks double-booking) =========='
SELECT schemaname AS schema_name, tablename AS table_name, indexname AS index_name
FROM pg_indexes
WHERE schemaname IN ('membership', 'staff', 'scheduling', 'reporting')
ORDER BY schemaname, tablename, indexname;

\qecho '========== 5. ID SEQUENCES (next ID values carried over) =========='
SELECT schemaname AS schema_name, sequencename AS sequence_name, last_value
FROM pg_sequences
WHERE schemaname IN ('membership', 'staff', 'scheduling', 'reporting')
ORDER BY schemaname, sequencename;

\qecho '========== 6. SUMMARY COUNTS =========='
SELECT 'schemas' AS object_type, COUNT(*) AS total
FROM information_schema.schemata
WHERE schema_name IN ('membership', 'staff', 'scheduling', 'reporting')

UNION ALL
SELECT 'tables', COUNT(*)
FROM information_schema.tables
WHERE table_schema IN ('membership', 'staff', 'scheduling', 'reporting')
AND table_type = 'BASE TABLE'

UNION ALL
SELECT 'views', COUNT(*)
FROM information_schema.tables
WHERE table_schema IN ('membership', 'staff', 'scheduling', 'reporting')
AND table_type = 'VIEW'

UNION ALL
SELECT 'constraints', COUNT(*)
FROM pg_constraint c JOIN pg_namespace n ON n.oid = c.connamespace
WHERE n.nspname IN ('membership', 'staff', 'scheduling', 'reporting')
AND c.contype IN ('p', 'f', 'u', 'c')

UNION ALL
SELECT 'indexes', COUNT(*)
FROM pg_indexes
WHERE schemaname IN ('membership', 'staff', 'scheduling', 'reporting');

\qecho '========== 7. RECORD COUNTS PER TABLE AND VIEW =========='
SELECT table_schema,
  table_name,
  table_type,
  (xpath('/row/cnt/text()',
    query_to_xml(format('SELECT COUNT(*) AS cnt FROM %I.%I', table_schema, table_name),
    false, true, '')))[1]::text::int AS record_count
FROM information_schema.tables
WHERE table_schema IN ('membership', 'staff', 'scheduling', 'reporting')
ORDER BY table_schema, table_type, table_name;
