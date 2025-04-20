WITH dim_projects_cte AS (
    SELECT *
    FROM {{ ref('dim_projects') }}
),

dim_revisions_cte AS (
    SELECT
        project_id,
        COUNT(DISTINCT revision_number) AS number_of_revisions
    FROM {{ ref('dim_revisions') }}
    GROUP BY project_id
),

joined_cte AS (
    SELECT
        p.project_id,
        p.designer_id,
        COALESCE(r.number_of_revisions, 0) AS number_of_revisions
    FROM dim_projects_cte AS p
    LEFT JOIN dim_revisions_cte AS r ON p.project_id = r.project_id
),

final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['project_id', 'designer_id']) }} AS fact_key,
        *
    FROM joined_cte
)

SELECT *
FROM final