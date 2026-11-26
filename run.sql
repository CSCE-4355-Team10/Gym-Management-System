-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : run.sql
-- Description : Execute gym management database scripts
-- Database    : gym_management_db
-- Run with    : psql
-- ============================================================

\set ON_ERROR_STOP on

-- Create schemas
\ir sql/01_setup.sql

-- Create tables
\ir sql/02_members.sql
\ir sql/03_trainers.sql
\ir sql/04_appointments.sql

-- Insert seed data
\ir sql/05_seed_data.sql

-- Create indexes and reporting views
\ir sql/06_indexes.sql
\ir sql/07_views.sql

-- Configure database roles
\ir sql/08_roles.sql

-- Run integration tests
\ir sql/09_tests.sql
