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
    DISTINCT SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ',', -1) AS cosmodrome,
    SUBSTRING_INDEX(location, ',', -1) AS cosmodrome_country,
    COUNT(SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ',', -1)) AS cosmodrome_count
FROM
    space_mission
GROUP BY cosmodrome, cosmodrome_country
ORDER BY cosmodrome_count DESC;

SELECT 
    EXTRACT(YEAR FROM date) AS years,
    COUNT(EXTRACT(YEAR FROM date)) AS count_of_occurences
FROM space_mission
GROUP BY years
ORDER BY years DESC;