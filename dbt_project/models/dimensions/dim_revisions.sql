WITH source AS (
    SELECT
        id::VARCHAR AS revision_id,
        project_id::VARCHAR AS project_id,
        revision_number::VARCHAR AS revision_number,
        notes::VARCHAR AS notes,
        created_at::TIMESTAMP AS created_at,
        updated_at::TIMESTAMP AS updated_at
    FROM {{ source('raw_source', 'revisions') }}
)

SELECT *
FROM source