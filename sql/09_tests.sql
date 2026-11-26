-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 09_tests.sql
-- Description : Test database constraints, roles, and reporting
-- Database    : gym_management_db
-- ============================================================

BEGIN;

-- ============================================================
-- Test 1: Verify schemas and seed data
-- ============================================================
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM information_schema.schemata
        WHERE schema_name IN ('membership', 'staff', 'scheduling', 'reporting')) <> 4
    THEN
        RAISE EXCEPTION 'FAIL: Required schemas are missing';
    END IF;

    IF (SELECT COUNT(*) FROM membership.members) <> 40
       OR (SELECT COUNT(*) FROM staff.trainers) <> 10
       OR (SELECT COUNT(*) FROM scheduling.appointments) <> 60
    THEN
        RAISE EXCEPTION 'FAIL: Seed data counts are incorrect';
    END IF;

    RAISE NOTICE 'PASS: Schemas and seed data verified';
END $$;

-- ============================================================
-- Test 2: Verify member constraints
-- ============================================================

-- Test UNIQUE email constraint
DO $$
BEGIN
    BEGIN
        INSERT INTO membership.members
            (full_name, email, phone_number, join_date, membership_status)
        VALUES
            ('Test Member',
             (SELECT email FROM membership.members ORDER BY member_id LIMIT 1),
             '999-000-0001', CURRENT_DATE, 'active');

        RAISE EXCEPTION 'FAIL: Duplicate email was accepted';
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'PASS: Duplicate member email rejected';
    END;
END $$;

-- Test NOT NULL full name constraint
DO $$
BEGIN
    BEGIN
        INSERT INTO membership.members
            (full_name, email, phone_number, join_date, membership_status)
        VALUES
            (NULL, 'test.member@example.com',
             '999-000-0002', CURRENT_DATE, 'active');

        RAISE EXCEPTION 'FAIL: NULL member name was accepted';
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'PASS: NULL member name rejected';
    END;
END $$;

-- Test invalid membership status
DO $$
BEGIN
    BEGIN
        INSERT INTO membership.members
            (full_name, email, phone_number, join_date, membership_status)
        VALUES
            ('Test Member', 'test.status@example.com',
             '999-000-0003', CURRENT_DATE, 'unknown');

        RAISE EXCEPTION 'FAIL: Invalid membership status accepted';
    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'PASS: Invalid membership status rejected';
    END;
END $$;

-- Test inactive membership without end date
DO $$
BEGIN
    BEGIN
        INSERT INTO membership.members
            (full_name, email, phone_number, join_date, membership_status)
        VALUES
            ('Test Member', 'test.inactive@example.com',
             '999-000-0004', CURRENT_DATE, 'inactive');

        RAISE EXCEPTION 'FAIL: Inactive membership without end date accepted';
    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'PASS: Inactive membership requires end date';
    END;
END $$;

-- Test active membership with end date
DO $$
BEGIN
    BEGIN
        INSERT INTO membership.members
            (full_name, email, phone_number, join_date,
             membership_status, membership_end_date)
        VALUES
            ('Test Member', 'test.active@example.com',
             '999-000-0005', CURRENT_DATE,
             'active', CURRENT_DATE + 30);

        RAISE EXCEPTION 'FAIL: Active membership with end date accepted';
    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'PASS: Active membership end date constraint verified';
    END;
END $$;

-- ============================================================
-- Test 3: Verify trainer and appointment constraints
-- ============================================================

-- Test future trainer hire date
DO $$
BEGIN
    BEGIN
        INSERT INTO staff.trainers
            (full_name, email, specialization, hire_date, employment_status)
        VALUES
            ('Test Trainer', 'test.trainer@example.com',
             'Fitness', CURRENT_DATE + 30, 'active');

        RAISE EXCEPTION 'FAIL: Future trainer hire date accepted';
    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'PASS: Future trainer hire date rejected';
    END;
END $$;

-- Test appointment foreign key
DO $$
BEGIN
    BEGIN
        INSERT INTO scheduling.appointments
            (member_id, trainer_id, appointment_date, appointment_status)
        VALUES
            (-1, 1, CURRENT_TIMESTAMP, 'scheduled');

        RAISE EXCEPTION 'FAIL: Invalid member foreign key accepted';
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'PASS: Invalid appointment member ID rejected';
    END;
END $$;

-- Test invalid appointment status
DO $$
BEGIN
    BEGIN
        INSERT INTO scheduling.appointments
            (member_id, trainer_id, appointment_date, appointment_status)
        VALUES
            (1, 1, CURRENT_TIMESTAMP, 'unknown');

        RAISE EXCEPTION 'FAIL: Invalid appointment status accepted';
    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'PASS: Invalid appointment status rejected';
    END;
END $$;

-- ============================================================
-- Test 4: Verify role permissions
-- ============================================================
DO $$
BEGIN
    -- Member permissions
    IF NOT has_table_privilege('member', 'membership.members', 'SELECT')
       OR NOT has_table_privilege('member', 'scheduling.appointments', 'SELECT')
       OR has_table_privilege('member', 'membership.members', 'UPDATE')
    THEN
        RAISE EXCEPTION 'FAIL: Member permissions incorrect';
    END IF;

    RAISE NOTICE 'PASS: Member permissions verified';

    -- Trainer permissions
    IF NOT has_table_privilege('trainer', 'membership.members', 'SELECT')
       OR NOT has_table_privilege('trainer', 'scheduling.appointments', 'SELECT')
       OR NOT has_table_privilege('trainer', 'scheduling.appointments', 'INSERT')
       OR NOT has_table_privilege('trainer', 'scheduling.appointments', 'UPDATE')
       OR has_table_privilege('trainer', 'membership.members', 'UPDATE')
       OR has_table_privilege('trainer', 'scheduling.appointments', 'DELETE')
    THEN
        RAISE EXCEPTION 'FAIL: Trainer permissions incorrect';
    END IF;

    RAISE NOTICE 'PASS: Trainer permissions verified';

    -- Admin permissions
    IF EXISTS (
        SELECT 1
        FROM (VALUES
            ('membership.members'),
            ('staff.trainers'),
            ('scheduling.appointments')
        ) AS tbl(table_name)
        CROSS JOIN (VALUES
            ('SELECT'), ('INSERT'), ('UPDATE'), ('DELETE')
        ) AS permission(privilege_name)
        WHERE NOT has_table_privilege(
            'admin', tbl.table_name, permission.privilege_name
        )
    )
    OR NOT has_table_privilege('admin', 'reporting.appointment_details', 'SELECT')
    OR NOT has_table_privilege('admin', 'reporting.member_loyalty_view', 'SELECT')
    OR NOT has_table_privilege('admin', 'reporting.former_members', 'SELECT')
    THEN
        RAISE EXCEPTION 'FAIL: Admin permissions incorrect';
    END IF;

    RAISE NOTICE 'PASS: Admin permissions verified';
END $$;

-- ============================================================
-- Test 5: Verify reporting views
-- ============================================================
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM reporting.appointment_details)
       <> (SELECT COUNT(*) FROM scheduling.appointments)
    THEN
        RAISE EXCEPTION 'FAIL: Appointment details view count mismatch';
    END IF;

    RAISE NOTICE 'PASS: Appointment details view verified';

    IF (SELECT COUNT(*) FROM reporting.member_loyalty_view)
       <> (SELECT COUNT(*) FROM membership.members)
    THEN
        RAISE EXCEPTION 'FAIL: Member loyalty view count mismatch';
    END IF;

    RAISE NOTICE 'PASS: Member loyalty view verified';

    IF (SELECT COUNT(*) FROM reporting.former_members)
       <> (SELECT COUNT(*) FROM membership.members
           WHERE membership_status = 'inactive')
    THEN
        RAISE EXCEPTION 'FAIL: Former members view count mismatch';
    END IF;

    RAISE NOTICE 'PASS: Former members view verified';
END $$;

-- ============================================================
-- Test 6: Verify loyalty tiers and discounts
-- ============================================================
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM reporting.member_loyalty_view
        WHERE (loyalty_tier = 'Regular' AND discount_percentage NOT IN (0, 20))
           OR (loyalty_tier = 'Silver' AND discount_percentage NOT IN (5, 20))
           OR (loyalty_tier = 'Gold' AND discount_percentage NOT IN (10, 20))
           OR (loyalty_tier = 'Platinum' AND discount_percentage NOT IN (15, 20))
           OR (loyalty_tier = 'Inactive' AND discount_percentage <> 0)
    ) THEN
        RAISE EXCEPTION 'FAIL: Loyalty discounts incorrect';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM reporting.member_loyalty_view
        WHERE membership_status = 'active'
          AND has_previous_membership = TRUE
          AND join_date <= CURRENT_DATE
          AND CURRENT_DATE < join_date + INTERVAL '1 month'
          AND discount_percentage <> 20
    ) THEN
        RAISE EXCEPTION 'FAIL: Returning member discount incorrect';
    END IF;

    RAISE NOTICE 'PASS: Loyalty tiers and returning discounts verified';
END $$;

-- ============================================================
-- Test 7: Verify appointment data integrity
-- ============================================================
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM scheduling.appointments AS appt
        LEFT JOIN membership.members AS mem
            ON appt.member_id = mem.member_id
        LEFT JOIN staff.trainers AS tr
            ON appt.trainer_id = tr.trainer_id
        WHERE mem.member_id IS NULL
           OR tr.trainer_id IS NULL
    ) THEN
        RAISE EXCEPTION 'FAIL: Appointments contain invalid references';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM scheduling.appointments
        GROUP BY trainer_id, appointment_date
        HAVING COUNT(*) > 1
    ) THEN
        RAISE EXCEPTION 'FAIL: Duplicate trainer appointments detected';
    END IF;

    RAISE NOTICE 'PASS: Appointment data integrity verified';
END $$;

-- ============================================================
-- Test 8: Verify seed data remains unchanged
-- ============================================================
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM membership.members) <> 40
       OR (SELECT COUNT(*) FROM staff.trainers) <> 10
       OR (SELECT COUNT(*) FROM scheduling.appointments) <> 60
    THEN
        RAISE EXCEPTION 'FAIL: Seed data changed during testing';
    END IF;

    RAISE NOTICE 'PASS: Seed data unchanged';
END $$;

-- ============================================================
-- Test 9: Verify member role enforcement
-- ============================================================
SET LOCAL ROLE member;

-- Verify member can read membership records
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM membership.members) <> 40 THEN
        RAISE EXCEPTION 'FAIL: Member cannot read membership records';
    END IF;

    RAISE NOTICE 'PASS: Member SELECT permission verified';
END $$;

-- Verify member cannot update membership records
DO $$
BEGIN
    BEGIN
        UPDATE membership.members
        SET full_name = 'Unauthorized Update'
        WHERE member_id = 1;

        RAISE EXCEPTION 'FAIL: Member was allowed to update records';
    EXCEPTION
        WHEN insufficient_privilege THEN
            RAISE NOTICE 'PASS: Member UPDATE permission denied';
    END;
END $$;

RESET ROLE;

-- ============================================================
-- Test 10: Verify trainer role enforcement
-- ============================================================

SET LOCAL ROLE trainer;

-- Verify trainer can read member records
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM membership.members) <> 40 THEN
        RAISE EXCEPTION 'FAIL: Trainer cannot read member records';
    END IF;

    RAISE NOTICE 'PASS: Trainer SELECT permission verified';
END $$;

-- Verify trainer cannot delete appointments
DO $$
BEGIN
    BEGIN
        DELETE FROM scheduling.appointments
        WHERE appointment_id = 1;

        RAISE EXCEPTION 'FAIL: Trainer was allowed to delete appointments';
    EXCEPTION
        WHEN insufficient_privilege THEN
            RAISE NOTICE 'PASS: Trainer DELETE permission denied';
    END;
END $$;

RESET ROLE;

-- ============================================================
-- Test 11: Verify loyalty tier classification
-- ============================================================
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM reporting.member_loyalty_view AS loyalty
        JOIN membership.members AS mem
            ON loyalty.member_id = mem.member_id
        WHERE loyalty.loyalty_tier IS DISTINCT FROM
            CASE
                WHEN mem.membership_status = 'inactive' THEN 'Inactive'
                WHEN mem.join_date > CURRENT_DATE - INTERVAL '6 months' THEN 'Regular'
                WHEN mem.join_date > CURRENT_DATE - INTERVAL '12 months' THEN 'Silver'
                WHEN mem.join_date > CURRENT_DATE - INTERVAL '24 months' THEN 'Gold'
                ELSE 'Platinum'
            END
    ) THEN
        RAISE EXCEPTION 'FAIL: Loyalty tier classification incorrect';
    END IF;

    RAISE NOTICE 'PASS: Loyalty tier classification verified';
END $$;

-- ============================================================
-- Rollback test transaction
-- ============================================================
ROLLBACK;
