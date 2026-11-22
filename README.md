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

The database consists of three main tables organized into separate schemas:

| Schema | Table | Description |
|---|---|---|
| `membership` | `members` | Stores member information and membership status. |
| `staff` | `trainers` | Stores trainer information and employment status. |
| `scheduling` | `appointments` | Stores appointments connecting members and trainers. |
| `reporting` | Views | Provides appointment reports and loyalty classifications. |

## Planned Features

- Create database schemas, tables, and constraints.
- Generate and insert simulated gym data.
- Use SQL JOIN queries to retrieve member, trainer, and appointment information.
- Classify members into Regular, Silver, Gold, and Platinum loyalty tiers.
- Identify former and returning members eligible for discounts.
- Manage database roles and privileges using GRANT/REVOKE.
- Evaluate query performance using indexes and EXPLAIN ANALYZE.
- Perform database backup and recovery testing.

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
│   └── 08_roles.sql
├── queries/
│   └── sample_queries.sql
└── tests/
    ├── 09_tests.sql
    └── performance_tests.sql
```

## Team Members

| Member | Responsibilities |
|---|---|
| Thi Ha Phuong Luu | Database setup, schema creation, simulated data, reporting views, and loyalty classification |
| Prapti Pyakurel | Database tables, constraints, and backup/recovery |
| Reeve Damon | SQL JOIN queries, roles and privileges, indexing, and performance optimization |

## Project Status

**In Development**

The database modules, SQL queries, and testing procedures are currently being implemented.

## Course Information

- **Course:** CSCE 4355 – Database Administration
- **Team:** Group 10
