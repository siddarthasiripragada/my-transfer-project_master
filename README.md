# Unified DBT Project

## Overview
This DBT project is designed to consolidate models and manage multiple environments (prod, preprod, etc.) within a single unified structure. It eliminates inefficiencies from running each model as a separate DBT project and provides a simplified, maintainable, and scalable solution.

## Folder Structure
unified_dbt_project/ ├── README.md # Documentation for the project ├── dbt_project.yml # Core DBT project configuration ├── manifest.yml # Environment-specific metadata and settings ├── models/ # Contains all DBT models │ ├── reports/ # Models specific to reporting │ │ ├── mo_report.sql │ │ ├── m1_report.sql │ │ ├── schema.yml │ ├── shared/ # Shared logic and reusable configurations │ ├── default.sql │ ├── schema.yml

yaml
 

## File Explanations
1. **`dbt_project.yml`**:
   - Defines the configuration of the DBT project.
   - Dynamically enables models based on the target environment (e.g., prod, preprod).
   - Specifies paths for models and configuration files.

2. **`manifest.yml`**:
   - Contains metadata and environment-specific settings such as:
     - Source projects
     - Dataset locations
     - Service accounts
   - Provides a single source of truth for all environment-specific parameters.

3. **`models/`**:
   - **`reports/`**: Contains reporting models, shared across all environments.
     - Models dynamically adjust logic based on the environment using `{{ target.name }}`.
     - Example models:
       - `mo_report.sql`: Calculates sales by customer.
       - `m1_report.sql`: Calculates revenue by consultant.
   - **`shared/`**: Contains reusable SQL logic and common configurations, such as:
     - `default.sql`: A default view for shared tables.
     - `schema.yml`: Defines sources and schema configurations for shared models.

## How to Run

### Setup
Ensure the `profiles.yml` file is located at `~/.dbt/profiles.yml`. Example content for `profiles.yml`:

```yaml
unified_project:
  target: preprod
  outputs:
    preprod:
      type: bigquery
      method: service-account
      project: my-preprod-project
      dataset: preprod_dataset
      keyfile: ~/.gcp/preprod-key.json
    prod:
      type: bigquery
      method: service-account
      project: my-prod-project
      dataset: prod_dataset
      keyfile: ~/.gcp/prod-key.json
Execution
Run all models for a specific environment using a single command:

Preprod:

bash
 
dbt run --target preprod
Prod:

bash
 
dbt run --target prod
Expected Results
All models for the target environment will execute.
Environment-specific settings, such as schema or filtering logic, will apply dynamically.
Design Problems in the Previous Solution
Issues
Separation of Models into Multiple Projects:

Inefficient and redundant.
Required separate scripts (e.g., dbt_command_loop.sh) to manage execution.
Manual Environment-Specific Configurations:

Used external files (e.g., preprod_table_config.yml, table_config.yml) that were cumbersome to manage.
Inconsistent Practices:

Redundant SQL logic across multiple files.
Difficult to scale or maintain.
Alternative Solution: Unified DBT Project
Why We Did It This Way:

Single DBT Project for All Models and Environments:

Simplifies project structure.
Reduces maintenance by consolidating logic into a single repository.
Dynamic Environment Handling:

Environment-specific configurations are dynamically injected using DBT's {{ target.name }} and environment variables.
Eliminates the need for external scripts and configuration files.
Reusable Shared Logic:

Common logic (e.g., default.sql) is stored in the shared/ folder and reused across environments.
Scalable and Maintainable:

Adding new models or environments requires minimal effort.
All models adapt dynamically to their target environment.
Benefits of This Approach
Simplified Execution:

A single dbt run command per environment builds all models dynamically.
No need for external scripts or manual intervention.
Enhanced Maintainability:

Shared logic is centralized in the shared/ folder, avoiding redundancy.
Models and configurations are organized logically into reports/ and shared/.
Dynamic and Flexible Configuration:

Targets (prod, preprod) dynamically adjust the schema, filtering logic, or behavior using:
{{ target.name }}
env_var() for environment variables.
Security:

Sensitive environment-specific details (e.g., API keys, service accounts) are stored securely in profiles.yml outside the project folder.
Scalability:

Easily extendable for additional environments or models.
Supports complex requirements while maintaining a clean, unified structure.
Example Execution Output
Preprod Execution:

bash
 
dbt run --target preprod
Builds all models in the preprod environment using preprod_schema.

Prod Execution:

bash
 
dbt run --target prod
Builds all models in the prod environment using prod_schema.