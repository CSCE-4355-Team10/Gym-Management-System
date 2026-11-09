-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 01_setup.sql
-- Description : Initialize database schemas
-- Database    : gym_management_db
-- ===========================================================

-- ============================================================
-- 1. CREATE DATABASE SCHEMAS
-- ============================================================

-- 1.1 Membership Schema
-- Stores gym member information and membership records.
CREATE SCHEMA IF NOT EXISTS membership;

-- 1.2 Staff Schema
-- Stores trainer information and employment details.
CREATE SCHEMA IF NOT EXISTS staff;

-- 1.3 Scheduling Schema
-- Manages appointments between members and trainers.
CREATE SCHEMA IF NOT EXISTS scheduling;

-- 1.4 Reporting Schema
-- Contains reporting views and loyalty classifications.
CREATE SCHEMA IF NOT EXISTS reporting;

-- ============================================================
-- 2. VERIFY DATABASE SCHEMAS
-- ============================================================

-- Confirm that all four required schemas exist.
SELECT schema_name FROM information_schema.schemata
WHERE schema_name IN ( 'membership','staff','scheduling','reporting')
ORDER BY schema_name;

-- ============================================================
-- END OF SCRIPT
-- ============================================================
