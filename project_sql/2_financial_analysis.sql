/*
Total cost of missions for each company,
Sums the total cost of missions conducted by each company.

Average cost of missions,
Calculates the average cost of a space mission.

Most expensive and least expensive mission (where data available and misison is not test mission(Demo Flight, Test Flight e.g.)),
Identifies the mission with the highest and lowest cost.
*/


SELECT
    company,
    ROUND(sum(Cost),2) AS sum_of_mission_cost
FROM space_mission
GROUP BY company
ORDER BY sum_of_mission_cost DESC;

SELECT
    mission,
    cost,
    ROUND(AVG(cost) OVER (PARTITION BY mission), 2) AS average_cost_of_mission,
    COUNT(*) OVER (PARTITION BY mission) AS launch_count
FROM space_mission
ORDER BY cost DESC;

--most expensive
SELECT
    DISTINCT company,
    mission,
    cost,
    total_cost,
    launch_count
FROM (
    SELECT
        company,
        mission,
        cost,
        ROUND(SUM(cost) OVER (PARTITION BY mission), 2) AS total_cost,
        COUNT(*) OVER (PARTITION BY mission) AS launch_count
    FROM space_mission
        WHERE cost IS NOT NULL
) AS temp_table
WHERE total_cost > 0
ORDER BY total_cost DESC
LIMIT 1;

--least expensive
SELECT
    DISTINCT company,
    mission,
    cost,
    total_cost,
    launch_count
FROM (
    SELECT
        company,
        mission,
        cost,
        ROUND(SUM(cost) OVER (PARTITION BY mission), 2) AS total_cost,
        COUNT(*) OVER (PARTITION BY mission) AS launch_count
    FROM space_mission
        WHERE cost IS NOT NULL
) AS temp_table
WHERE total_cost > 0
ORDER BY total_cost ASC
LIMIT 1;