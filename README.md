# Gym Management System

**CSCE 4355 – Database Administration | Team 10**

## Project Overview

The Gym Management System is a PostgreSQL database project designed to manage gym members, trainers, and appointments. The system tracks membership status, trainer schedules, and appointment records. It also identifies loyal and returning members who may qualify for membership discounts.

The project focuses on database design, data management, SQL queries, security, performance optimization, and backup/recovery.

## Technologies

- PostgreSQL
- SQL
- psql
- Git & GitHub

## Database Structure

The database consists of three main tables and four schemas:

| Schema | Table / Views | Description |
|---|---|---|
| `membership` | `members` | Stores member information and membership status. |
| `staff` | `trainers` | Stores trainer information and employment status. |
| `scheduling` | `appointments` | Stores appointments connecting members and trainers. |
| `reporting` | Reporting views | Provides appointment reports and loyalty classifications. |

### Reporting Views

- `reporting.appointment_details` — Displays appointment information with member and trainer details.
- `reporting.member_loyalty_view` — Classifies members into loyalty tiers and calculates applicable discounts.
- `reporting.former_members` — Identifies inactive members.

## Implemented Features

- Created database schemas, tables, relationships, and constraints.
- Generated and inserted simulated gym data, including 40 members, 10 trainers, and 60 appointments.
- Implemented SQL JOIN queries to retrieve member, trainer, and appointment information.
- Classified members into Regular, Silver, Gold, and Platinum loyalty tiers.
- Identified former and returning members eligible for discounts.
- Implemented role-based access control for Member, Trainer, and Admin.
- Created indexes and evaluated query performance using `EXPLAIN ANALYZE`.
- Added backup and recovery verification procedures.
- Implemented database integration tests covering constraints, permissions, reporting views, and data integrity.

## Project Structure

```text
Gym-Management-System/
├── README.md
├── run.sql
├── sql/
│   ├── 01_setup.sql
│   ├── 02_members.sql
│   ├── 03_trainers.sql
│   ├── 04_appointments.sql
│   ├── 05_seed_data.sql
│   ├── 06_indexes.sql
│   ├── 07_views.sql
│   ├── 08_roles.sql
│   ├── 09_tests.sql
│   └── verify_dbbackup.sql
├── queries/
│   └── sample_queries.sql
└── tests/
    └── performance_tests.sql
```

## Database Setup

### Requirements

- PostgreSQL installed and running.
- Access to a PostgreSQL account with permission to create databases and roles.
- psql command-line tool.

### Instructions

1. Clone or pull the latest version of the repository.
2. Create the project database:

   `createdb -h localhost -U postgres gym_management_db`

3. From the project root directory, execute:

   `psql -h localhost -U postgres -d gym_management_db -v ON_ERROR_STOP=1 -f run.sql`

The `run.sql` script executes all nine numbered SQL files in order, including the database integration tests.

**Note:** The setup expects the database to be initialized without existing project tables and the roles `member`, `trainer`, and `admin` not to exist on the PostgreSQL server. Back up existing data before resetting a previous installation.

## Testing

The project includes `sql/09_tests.sql` to verify database constraints, role permissions, reporting views, loyalty discounts, and appointment integrity.

All 11 test sections passed during the final integration test.

The test script uses a transaction with `ROLLBACK` to avoid retaining temporary test changes.

## Backup and Recovery

The `sql/verify_dbbackup.sql` script verifies database schemas, tables, views, constraints, indexes, sequences, and record counts.

It can be executed on the original and restored databases to compare their structures and data counts.

## Team Members

| Member | Responsibilities |
|---|---|
| Thi Ha Phuong Luu | Database setup, schema creation, simulated data, reporting views, loyalty classification, and integration testing |
| Prapti Pyakurel | Database tables, constraints, and backup/recovery |
| Reeve Damon | SQL JOIN queries, roles and privileges, indexing, and performance optimization |

## Project Status

**Database Implementation and Integration Testing Completed**

All nine numbered SQL scripts have been integrated and successfully tested on a newly created database. Final documentation, backup/recovery evidence, and presentation preparation are being completed.

## Course Information

- **Course:** CSCE 4355 – Database Administration
- **Team:** Group 10