# Unified DBT Project

## Overview
This project consolidates DBT models into a single structure, simplifying execution and management for multiple environments (e.g., `prod`, `preprod`). It eliminates inefficiencies and provides a scalable solution for model management.

## Folder Structure

unified_dbt_project/
├── README.md          # Documentation for the project
├── dbt_project.yml    # Core DBT project configuration
├── manifest.yml       # Environment-specific metadata and settings
├── models/            # Contains all DBT models
│   ├── reports/       # Models specific to reporting
│   │   ├── mo_report.sql
│   │   ├── m1_report.sql
│   │   ├── schema.yml
│   ├── shared/        # Shared logic and reusable configurations
│       ├── default.sql
│       ├── schema.yml


