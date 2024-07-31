/*
Number of missions for each rocket
Shows the number of missions conducted using each rocket.

Most frequently used rocket
Identifies which rocket was used the most frequently.
*/


SELECT 
    DISTINCT rocket,
    COUNT(rocket) AS rocket_used
FROM space_mission
GROUP BY rocket
ORDER BY rocket_used DESC;

SELECT 
    DISTINCT rocket,
    COUNT(rocket) AS rocket_used
FROM space_mission
GROUP BY rocket
ORDER BY rocket_used DESC
LIMIT 10;