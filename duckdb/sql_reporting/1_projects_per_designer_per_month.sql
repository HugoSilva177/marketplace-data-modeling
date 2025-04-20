SELECT
    designer_id,
    month_completed,
    COUNT(DISTINCT project_id) AS number_of_completed_projects
FROM main.fact_projects_completed
GROUP BY designer_id, month_completed