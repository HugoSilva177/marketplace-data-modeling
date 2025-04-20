WITH source AS (
    SELECT
        id::VARCHAR AS client_id,
        company_name::VARCHAR AS company_name,
        created_at::TIMESTAMP AS created_at,
        updated_at::TIMESTAMP AS updated_at
    FROM {{ source('raw_source', 'clients') }}
)

SELECT *
FROM source