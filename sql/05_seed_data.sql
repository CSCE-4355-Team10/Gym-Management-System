-- ============================================================
-- GYM MANAGEMENT SYSTEM
-- CSCE 4355 - Database Administration
-- ============================================================
-- File        : 05_seed_data.sql
-- Description : Insert simulated gym management data
-- Database    : gym_management_db
-- ============================================================

-- ============================================================
-- 1. INSERT MEMBERS
-- ============================================================

-- Includes active, inactive, and returning members.
-- Membership dates cover all four loyalty tiers.
-- All names, emails, and phone numbers are fictional.

INSERT INTO membership.members (
    member_id,
    full_name,
    email,
    phone_number,
    join_date,
    membership_status,
    membership_end_date,
    has_previous_membership
) VALUES
    -- Regular Members: Less than 6 months
    (1, 'Emma Wilson', 'emma.wilson@example.com', '202-555-0101', '2026-09-15', 'Active', NULL, FALSE),
    (2, 'James Miller', 'james.miller@example.com', '202-555-0102', '2026-08-02', 'Active', NULL, FALSE),
    (3, 'Nguyen Minh Anh', 'minhanh.nguyen@example.com', '202-555-0103', '2026-10-01', 'Active', NULL, FALSE),
    (4, 'Daniel Tran', 'daniel.tran@example.com', '202-555-0104', '2026-07-20', 'Active', NULL, FALSE),
    (5, 'Kim Min-jun', 'minjun.kim@example.com', '202-555-0105', '2026-11-01', 'Active', NULL, FALSE),
    (6, 'Sofia Garcia', 'sofia.garcia@example.com', '202-555-0106', '2026-06-12', 'Active', NULL, FALSE),
    (7, 'Oliver Bennett', 'oliver.bennett@example.com', '202-555-0107', '2026-09-23', 'Active', NULL, FALSE),
    (8, 'Priya Sharma', 'priya.sharma@example.com', '202-555-0108', '2026-08-18', 'Active', NULL, FALSE),

    -- Silver Members: 6 to less than 12 months
    (9, 'Olivia Brown', 'olivia.brown@example.com', '202-555-0109', '2026-03-10', 'Active', NULL, FALSE),
    (10, 'Tran Gia Huy', 'giahuy.tran@example.com', '202-555-0110', '2026-02-20', 'Active', NULL, FALSE),
    (11, 'Michelle Nguyen', 'michelle.nguyen@example.com', '202-555-0111', '2026-04-01', 'Active', NULL, FALSE),
    (12, 'Park Seo-yeon', 'seoyeon.park@example.com', '202-555-0112', '2026-01-15', 'Active', NULL, FALSE),
    (13, 'Carlos Hernandez', 'carlos.hernandez@example.com', '202-555-0113', '2026-03-25', 'Active', NULL, FALSE),
    (14, 'Haruto Tanaka', 'haruto.tanaka@example.com', '202-555-0114', '2026-05-01', 'Active', NULL, FALSE),

    -- Gold Members: 12 to less than 24 months
    (15, 'Noah Davis', 'noah.davis@example.com', '202-555-0115', '2025-08-20', 'Active', NULL, FALSE),
    (16, 'Le Khanh Linh', 'khanhlinh.le@example.com', '202-555-0116', '2025-03-12', 'Active', NULL, FALSE),
    (17, 'Andrew Pham', 'andrew.pham@example.com', '202-555-0117', '2025-10-05', 'Active', NULL, FALSE),
    (18, 'Choi Ji-hoon', 'jihoon.choi@example.com', '202-555-0118', '2025-07-18', 'Active', NULL, FALSE),
    (19, 'Valentina Rodriguez', 'valentina.rodriguez@example.com', '202-555-0119', '2025-01-22', 'Active', NULL, FALSE),
    (20, 'Aisha Khan', 'aisha.khan@example.com', '202-555-0120', '2025-06-01', 'Active', NULL, FALSE),

    -- Platinum Members: 24 months or longer
    (21, 'Sophia Taylor', 'sophia.taylor@example.com', '202-555-0121', '2023-05-12', 'Active', NULL, FALSE),
    (22, 'Pham Bao Ngoc', 'baongoc.pham@example.com', '202-555-0122', '2022-09-01', 'Active', NULL, FALSE),
    (23, 'Emily Le', 'emily.le@example.com', '202-555-0123', '2024-01-17', 'Active', NULL, FALSE),
    (24, 'Lee Ha-eun', 'haeun.lee@example.com', '202-555-0124', '2023-11-20', 'Active', NULL, FALSE),
    (25, 'Diego Martinez', 'diego.martinez@example.com', '202-555-0125', '2022-06-15', 'Active', NULL, FALSE),

    -- Inactive Members
    (26, 'Ethan Walker', 'ethan.walker@example.com', '202-555-0126', '2024-02-10', 'Inactive', '2026-04-15', FALSE),
    (27, 'Vo Thanh Tung', 'thanhtung.vo@example.com', '202-555-0127', '2025-05-06', 'Inactive', '2026-08-20', FALSE),
    (28, 'Kevin Hoang', 'kevin.hoang@example.com', '202-555-0128', '2023-08-14', 'Inactive', '2025-12-01', FALSE),
    (29, 'Jung Soo-bin', 'soobin.jung@example.com', '202-555-0129', '2025-09-01', 'Inactive', '2026-05-10', FALSE),
    (30, 'Isabella Lopez', 'isabella.lopez@example.com', '202-555-0130', '2024-07-22', 'Inactive', '2026-01-15', FALSE),
    (31, 'William Carter', 'william.carter@example.com', '202-555-0131', '2026-01-10', 'Inactive', '2026-09-30', FALSE),
    (32, 'Yuki Nakamura', 'yuki.nakamura@example.com', '202-555-0132', '2025-04-13', 'Inactive', '2026-03-25', FALSE),
    (33, 'Arjun Patel', 'arjun.patel@example.com', '202-555-0133', '2024-10-01', 'Inactive', '2025-11-15', FALSE),
    (34, 'Camila Santos', 'camila.santos@example.com', '202-555-0134', '2025-12-05', 'Inactive', '2026-07-12', FALSE),
    (35, 'Liam O''Connor', 'liam.oconnor@example.com', '202-555-0135', '2023-03-19', 'Inactive', '2025-08-30', FALSE),

    -- Returning Members
    -- join_date represents the most recent rejoining date.
    (36, 'Alex Johnson', 'alex.johnson@example.com', '202-555-0136', '2026-11-02', 'Active', NULL, TRUE),
    (37, 'Dang Thao Vy', 'thaovy.dang@example.com', '202-555-0137', '2026-10-25', 'Active', NULL, TRUE),
    (38, 'Jessica Vu', 'jessica.vu@example.com', '202-555-0138', '2026-10-15', 'Active', NULL, TRUE),
    (39, 'Fernanda Morales', 'fernanda.morales@example.com', '202-555-0139', '2026-09-01', 'Active', NULL, TRUE),
    (40, 'Kang Hyun-woo', 'hyunwoo.kang@example.com', '202-555-0140', '2026-05-20', 'Active', NULL, TRUE);

-- ============================================================
-- 2. VERIFY MEMBERS DATA
-- ============================================================

-- Count all members.
SELECT COUNT(*) AS total_members
FROM membership.members;

-- Count members by membership status.
SELECT membership_status, COUNT(*) AS total
FROM membership.members
GROUP BY membership_status
ORDER BY membership_status;

-- Identify members with previous memberships.
SELECT member_id, full_name, join_date
FROM membership.members
WHERE has_previous_membership = TRUE
ORDER BY member_id;

-- ============================================================
-- 3. INSERT TRAINERS
-- ============================================================

-- Includes active and inactive trainers with different specializations.
-- All names and email addresses are fictional.

INSERT INTO staff.trainers (
    trainer_id,
    full_name,
    email,
    specialization,
    hire_date,
    employment_status
)
VALUES
    -- Active Trainers
    (1, 'Michael Anderson', 'michael.anderson@example.com', 'Strength Training', '2022-03-15', 'Active'),
    (2, 'Nguyen Quoc Bao', 'quocbao.nguyen@example.com', 'Weight Loss', '2023-06-20', 'Active'),
    (3, 'Sarah Kim', 'sarah.kim@example.com', 'Yoga', '2021-09-10', 'Active'),
    (4, 'Diego Ramirez', 'diego.ramirez@example.com', 'Cardio Fitness', '2024-01-08', 'Active'),
    (5, 'Emily Park', 'emily.park@example.com', 'Pilates', '2023-11-12', 'Active'),
    (6, 'David Johnson', 'david.johnson@example.com', 'Bodybuilding', '2020-07-01', 'Active'),
    (7, 'Tran Minh Khang', 'minhkhang.tran@example.com', 'HIIT', '2024-05-18', 'Active'),
    (8, 'Priya Patel', 'priya.patel@example.com', 'Functional Training', '2022-10-25', 'Active'),

    -- Inactive Trainers
    (9, 'Carlos Mendoza', 'carlos.mendoza@example.com', 'General Fitness', '2021-04-12', 'Inactive'),
    (10, 'Jessica Lee', 'jessica.lee@example.com', 'Rehabilitation Fitness', '2022-08-30', 'Inactive');

-- ============================================================
-- 4. VERIFY TRAINERS DATA
-- ============================================================

-- Count all trainers.
SELECT COUNT(*) AS total_trainers
FROM staff.trainers;

-- Count trainers by employment status.
SELECT employment_status, COUNT(*) AS total
FROM staff.trainers
GROUP BY employment_status
ORDER BY employment_status;

-- List trainers and their specializations.
SELECT trainer_id, full_name, specialization, employment_status 
FROM staff.trainers
ORDER BY trainer_id;

-- ============================================================
-- 5. INSERT APPOINTMENTS
-- ============================================================

-- Includes completed, scheduled, and cancelled appointments.
-- Each appointment references an existing member and trainer.
-- No trainer has duplicate appointments at the same date and time.

INSERT INTO scheduling.appointments (
    appointment_id,
    member_id,
    trainer_id,
    appointment_date,
    appointment_status
)
VALUES
    -- Completed Appointments (30 records)
    (1, 1, 1, '2026-10-01 09:00:00', 'Completed'),
    (2, 2, 2, '2026-10-02 10:00:00', 'Completed'),
    (3, 3, 3, '2026-10-03 11:00:00', 'Completed'),
    (4, 4, 4, '2026-10-04 14:00:00', 'Completed'),
    (5, 5, 5, '2026-11-03 09:00:00', 'Completed'),
    (6, 6, 6, '2026-10-06 10:00:00', 'Completed'),
    (7, 7, 7, '2026-10-07 11:00:00', 'Completed'),
    (8, 8, 8, '2026-10-08 14:00:00', 'Completed'),
    (9, 9, 9, '2026-10-09 09:00:00', 'Completed'),
    (10, 10, 10, '2026-10-10 10:00:00', 'Completed'),
    (11, 26, 1, '2026-03-11 11:00:00', 'Completed'),
	(12, 27, 2, '2026-07-12 14:00:00', 'Completed'),
	(13, 28, 3, '2025-10-13 09:00:00', 'Completed'),
	(14, 29, 4, '2026-04-14 10:00:00', 'Completed'),
	(15, 30, 5, '2025-12-15 11:00:00', 'Completed'),
    (16, 16, 6, '2026-10-16 14:00:00', 'Completed'),
    (17, 17, 7, '2026-10-17 09:00:00', 'Completed'),
    (18, 18, 8, '2026-10-18 10:00:00', 'Completed'),
    (19, 19, 9, '2026-10-19 11:00:00', 'Completed'),
    (20, 20, 10, '2026-10-20 14:00:00', 'Completed'),
    (21, 21, 1, '2026-10-21 09:00:00', 'Completed'),
    (22, 22, 2, '2026-10-22 10:00:00', 'Completed'),
    (23, 23, 3, '2026-10-23 11:00:00', 'Completed'),
    (24, 24, 4, '2026-10-24 14:00:00', 'Completed'),
    (25, 25, 5, '2026-10-25 09:00:00', 'Completed'),
    (26, 1, 6, '2026-10-26 10:00:00', 'Completed'),
    (27, 2, 7, '2026-10-27 11:00:00', 'Completed'),
    (28, 3, 8, '2026-10-28 14:00:00', 'Completed'),
    (29, 4, 1, '2026-10-29 09:00:00', 'Completed'),
    (30, 5, 2, '2026-11-06 10:00:00', 'Completed'),

    -- Scheduled Appointments (20 records)
    (31, 1, 1, '2026-11-16 09:00:00', 'Scheduled'),
    (32, 2, 2, '2026-11-17 10:00:00', 'Scheduled'),
    (33, 3, 3, '2026-11-18 11:00:00', 'Scheduled'),
    (34, 4, 4, '2026-11-19 14:00:00', 'Scheduled'),
    (35, 5, 5, '2026-11-20 09:00:00', 'Scheduled'),
    (36, 6, 6, '2026-11-21 10:00:00', 'Scheduled'),
    (37, 7, 7, '2026-11-22 11:00:00', 'Scheduled'),
    (38, 8, 8, '2026-11-23 14:00:00', 'Scheduled'),
    (39, 9, 1, '2026-11-24 09:00:00', 'Scheduled'),
    (40, 10, 2, '2026-11-25 10:00:00', 'Scheduled'),
    (41, 11, 3, '2026-11-26 11:00:00', 'Scheduled'),
    (42, 12, 4, '2026-11-27 14:00:00', 'Scheduled'),
    (43, 13, 5, '2026-11-28 09:00:00', 'Scheduled'),
    (44, 14, 6, '2026-11-29 10:00:00', 'Scheduled'),
    (45, 15, 7, '2026-11-30 11:00:00', 'Scheduled'),
    (46, 16, 8, '2026-12-01 14:00:00', 'Scheduled'),
    (47, 36, 1, '2026-12-02 09:00:00', 'Scheduled'),
    (48, 37, 2, '2026-12-03 10:00:00', 'Scheduled'),
    (49, 38, 3, '2026-12-04 11:00:00', 'Scheduled'),
    (50, 39, 4, '2026-12-05 14:00:00', 'Scheduled'),

    -- Cancelled Appointments (10 records)
    -- These appointments were cancelled before their scheduled dates
	(51, 17, 1, '2026-11-10 14:00:00', 'Cancelled'),
    (52, 18, 2, '2026-11-11 09:00:00', 'Cancelled'),
    (53, 19, 3, '2026-11-12 10:00:00', 'Cancelled'),
    (54, 20, 4, '2026-11-13 11:00:00', 'Cancelled'),
    (55, 21, 5, '2026-11-14 14:00:00', 'Cancelled'),
    (56, 22, 6, '2026-11-15 09:00:00', 'Cancelled'),
    (57, 23, 7, '2026-11-16 10:00:00', 'Cancelled'),
    (58, 24, 8, '2026-11-17 11:00:00', 'Cancelled'),
    (59, 25, 1, '2026-11-18 14:00:00', 'Cancelled'),
    (60, 40, 2, '2026-11-19 09:00:00', 'Cancelled');


-- ============================================================
-- 6. VERIFY APPOINTMENTS DATA
-- ============================================================

-- Count all appointments.
SELECT COUNT(*) AS total_appointments
FROM scheduling.appointments;

-- Count appointments by status.
SELECT appointment_status, COUNT(*) AS total
FROM scheduling.appointments
GROUP BY appointment_status
ORDER BY appointment_status;

-- Check for duplicate trainer bookings.
SELECT trainer_id, appointment_date, COUNT(*) AS booking_count
FROM scheduling.appointments
GROUP BY trainer_id, appointment_date
HAVING COUNT(*) > 1;

-- Check for invalid member references.
SELECT a.appointment_id
FROM scheduling.appointments a
LEFT JOIN membership.members m ON a.member_id = m.member_id
WHERE m.member_id IS NULL;

-- Check for invalid trainer references.
SELECT a.appointment_id
FROM scheduling.appointments a
LEFT JOIN staff.trainers t ON a.trainer_id = t.trainer_id
WHERE t.trainer_id IS NULL;

