/*
Number of launch conducted by each company from each location,
Displays the number of launch conducted by each company from different launch locations.

Average cost of successful and unsuccessful launch,
Compares the average cost of launch that were successful with those that were unsuccessful.

Oldest rocket which is still on duty,
shows the oldest rocket that is still in service displays its 'on duty time' while it remains active.

Timeline of each retired rocket,
show the first and last launch, as well as the duration and count of launch for which the rocket remained active.
*/


SELECT
    company,
    cosmodrome,
    region,
    COUNT(cosmodrome) AS cosmodrome_count
FROM(SELECT
    company,
    location,
    IF(location LIKE '%,%,%,%',
        SUBSTRING_INDEX(location, ',', 1),
        IF(location LIKE '%,%,%',
            SUBSTRING_INDEX(location, ',', 1),
            NULL)) AS `site`,
    IF(location LIKE '%,%,%,%',
        SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ',', -1),
        IF(location LIKE '%,%,%',
            SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ',', -1),
            NULL)) AS `cosmodrome`,
    IF(location LIKE '%,%,%,%',
        SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 3), ',', -1),
        NULL) AS `state/district`,
        SUBSTRING_INDEX(location, ',', -1) AS region
    FROM space_mission) AS site
GROUP BY company, cosmodrome, region
ORDER BY cosmodrome_count DESC;

SELECT
    rocket,
    missionstatus,
    cost,
    ROUND(AVG(cost) OVER(PARTITION BY missionstatus), 2) AS avg_cost_per_status
FROM space_mission
WHERE cost IS NOT NULL;

SELECT
    DISTINCT rocket,
    MIN(date) OVER (PARTITION BY rocket) AS first_launch,
    MAX(date) OVER (PARTITION BY rocket) AS last_launch,
    TIMESTAMPDIFF(year, MIN(date) OVER (PARTITION BY rocket), MAX(date) OVER (PARTITION BY rocket)) AS duration,
    COUNT(rocket) OVER (PARTITION BY rocket) AS number_of_starts,
    rocketstatus
FROM space_mission
WHERE rocketstatus = 'Retired';

SELECT
    rocket,
    MIN(date) OVER (PARTITION BY rocket) AS first_launch,
    MAX(date) OVER (PARTITION BY rocket) AS last_launch,
    TIMESTAMPDIFF(year, MIN(date) OVER (PARTITION BY rocket), MAX(date) OVER (PARTITION BY rocket)) AS duration,
    rocketstatus
FROM space_mission
WHERE rocketstatus = 'Active'
ORDER BY duration DESC
LIMIT 1;