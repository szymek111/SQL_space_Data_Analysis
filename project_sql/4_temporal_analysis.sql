/*
Number of space missions in each month Displays the number of missions conducted in each month of the year.

Most active month in terms of number of missions Determines which month was the most active in terms of the number of space missions.
*/


SELECT 
    month_value,
    COUNT(month_value) AS month_occurence
FROM(SELECT EXTRACT(MONTH FROM date) AS month_value FROM space_mission) AS month_table
GROUP BY month_value
ORDER BY month_value;

SELECT 
    month_value,
    COUNT(month_value) AS month_occurence
FROM(SELECT EXTRACT(MONTH FROM date) AS month_value FROM space_mission) AS month_table
GROUP BY month_value
ORDER BY month_occurence DESC
LIMIT 1;