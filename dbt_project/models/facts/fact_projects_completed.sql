WITH dim_projects_cte AS (
    SELECT *
    FROM {{ ref('dim_projects') }}
    WHERE is_completed_bool = true
),

dim_designers_cte AS (
    SELECT *
    FROM {{ ref('dim_designers') }}
),

dim_clients_cte AS (
    SELECT *
    FROM {{ ref('dim_clients') }}
),

joined_cte AS (
    SELECT
        p.project_id,
        d.designer_id,
        c.client_id,
        p.is_completed_bool,
        p.start_date,
        p.end_date,
        STRFTIME('%B', p.end_date) AS month_completed,
        DATE_DIFF('day', start_date, end_date) AS duration_in_days
    FROM dim_projects_cte AS p
    LEFT JOIN dim_designers_cte AS d ON p.designer_id = d.designer_id
    LEFT JOIN dim_clients_cte AS c ON p.client_id = c.client_id
),

final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['project_id', 'designer_id']) }} AS fact_key,
        *
    FROM joined_cte
)

SELECT *
FROM final