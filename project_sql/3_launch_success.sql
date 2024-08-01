/*
Percentage of successful rocket launches for each company,
Analyzes the percentage of successful rocket launches relative to all company's launches.
*/


SELECT
    DISTINCT p.company,
    success_table.success_count,
    failure_table.failure_count,
    ROUND(((success_table.success_count)/(success_table.success_count + failure_table.failure_count)) * 100,2) AS success_percentage_rate
FROM space_mission p
JOIN
    (SELECT
        company,
        COUNT(company) AS success_count
    FROM space_mission
    WHERE missionstatus LIKE "%success%" GROUP BY company) AS success_table
ON
    success_table.company = p.company
JOIN
    (SELECT
        company,
        COUNT(company) AS failure_count
    FROM space_mission
    WHERE missionstatus LIKE "%failure%" GROUP BY company) AS failure_table
ON
    failure_table.company = p.company
ORDER BY success_percentage_rate DESC;