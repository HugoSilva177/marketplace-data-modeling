WITH dim_designers_cte AS (
    SELECT *
    FROM {{ ref('dim_designers') }}
),

dim_projects_cte AS (
    SELECT *
    FROM {{ ref('dim_projects') }}
    WHERE is_completed_bool = true
),

joined_cte AS (
    SELECT
        d.designer_id AS designer_id,
        SUM(project_fee) AS revenue_total,
        STRFTIME('%Y', p.end_date) AS revenue_year
    FROM dim_designers_cte AS d
    LEFT JOIN dim_projects_cte AS p USING(designer_id)
    GROUP BY d.designer_id, revenue_year
),

final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['designer_id']) }} AS fact_key,
        *
    FROM joined_cte
)

SELECT *
FROM final