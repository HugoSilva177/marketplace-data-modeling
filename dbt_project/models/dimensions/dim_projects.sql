WITH source AS (
    SELECT
        id::VARCHAR AS project_id,
        client_id::VARCHAR AS client_id,
        designer_id::VARCHAR AS designer_id,
        project_fee::DECIMAL AS project_fee,
        CASE
            WHEN is_completed = 'TRUE' THEN true
            WHEN is_completed = 'FALSE' THEN false
            ELSE null
        END AS is_completed_bool,
        start_date::DATE AS start_date,
        end_date::DATE AS end_date,
        created_at::TIMESTAMP AS created_at,
        updated_at::TIMESTAMP AS updated_at
    FROM {{ source('raw_source', 'projects') }}
)

SELECT *
FROM source