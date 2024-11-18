{{
    config(
        alias=env_var('DBT_TGT_TABLE_NAME'),
        materialized='view'
    )
}}

SELECT *
FROM {{ source('dataset_name', 'table_name') }};
