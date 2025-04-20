WITH source AS (
    SELECT
        id::VARCHAR AS designer_id,
        name::VARCHAR AS name,
        email::VARCHAR AS email,
        created_at::TIMESTAMP AS created_at,
        updated_at::TIMESTAMP AS updated_at
    FROM {{ source('raw_source', 'designers') }}
)

SELECT *
FROM source