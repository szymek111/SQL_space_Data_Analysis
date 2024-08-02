/*
Percentage of successful rocket launches for each company,
Analyzes the percentage of successful rocket launches relative to all company's launches (Only for company with at least 10 launch).
*/


SELECT
    DISTINCT p.company,
    success_table.success_count,
    total_launches - success_table.success_count AS failure_table_failure_count,
    ROUND(((success_table.success_count)/(total_launches)) * 100, 2) AS success_percentage_rate
FROM space_mission p
LEFT JOIN
    (SELECT
        company,
        COUNT(company) AS success_count
    FROM space_mission
    WHERE missionstatus = "Success" GROUP BY company) AS success_table
ON
    success_table.company = p.company
LEFT JOIN
    (SELECT
        company,
        COUNT(company) AS total_launches
    FROM space_mission
    GROUP BY company) AS total_launches_table
ON
    total_launches_table.company = p.company
WHERE total_launches_table.total_launches >= 10
ORDER BY success_percentage_rate DESC;

-- Those two queries shows same output but the query above uses JOIN statments and bellow - CTE (Common Table Expressions).

WITH
launch_counts_table AS (
    SELECT
        company,
        COUNT(*) AS total_launches,
        SUM(CASE WHEN missionstatus = 'Success' THEN 1 ELSE 0 END) AS success_count,
        SUM(CASE WHEN missionstatus LIKE '%failure%' THEN 1 ELSE 0 END) AS failure_count
    FROM
        space_mission
    GROUP BY
        company),
success_rate_table AS (
    SELECT
        company,
        success_count,
        failure_count,
        total_launches,
        ROUND(((success_count)/(failure_count + success_count))*100, 2) AS success_rate
    FROM
        launch_counts_table)
SELECT * FROM success_rate_table
WHERE total_launches >= 10
ORDER BY success_rate DESC;