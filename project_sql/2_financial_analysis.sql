/*
Total cost of missions for each company
Sums the total cost of missions conducted by each company.

Average cost of missions
Calculates the average cost of a space mission.

Most expensive and least expensive mission (where data available and misison is not test mission(Demo Flight, Test Flight e.g.))
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
    AVG(cost) OVER (PARTITION BY mission) AS average_cost_of_mission
FROM space_mission
ORDER BY cost DESC;

SELECT
    DISTINCT company,
    mission,
    cost,
    total_cost,
    mission_count
FROM (
    SELECT
        company,
        mission,
        cost,
        ROUND(SUM(cost) OVER (PARTITION BY mission), 2) AS total_cost,
        COUNT(*) OVER (PARTITION BY mission) AS mission_count
    FROM space_mission
        WHERE mission NOT LIKE "%demo%"
        AND mission NOT LIKE "%test%" 
        AND cost IS NOT NULL
) AS temp_table
WHERE total_cost > 0 AND mission_count > 1
ORDER BY total_cost DESC;
