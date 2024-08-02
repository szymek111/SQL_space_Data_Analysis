/*
Number of space missions conducted by each company,
Displays the count of missions assigned to each company.

Number of space missions conducted from each location,
Shows the number of missions launched from different locations.

Number of space missions in each year,
Analyzes the count of missions conducted in different years.
*/


SELECT
    company,
    COUNT(DISTINCT mission) AS count_of_mission
FROM space_mission
GROUP BY company
ORDER BY count_of_mission DESC;

SELECT 
    COUNT(location) AS location_count,
    location
FROM space_mission
GROUP BY location
ORDER BY COUNT(location) DESC;


SELECT 
    EXTRACT(YEAR FROM date) AS years,
    COUNT(EXTRACT(YEAR FROM date)) AS count_of_occurences
FROM space_mission
GROUP BY years
ORDER BY years DESC;