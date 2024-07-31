LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\space_missions_utf8.csv'
INTO TABLE space_mission
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Checking if column 'Cost' contains ","(comma) in any of record, later can be problematic in changing datatype.
SELECT * from space_mission;
SELECT * FROM space_mission WHERE `Cost` LIKE '%,%';

-- Deleting unnecesary commas from Cost column
UPDATE space_mission
SET Cost = REPLACE(Cost, ',', '');

-- Exchange empty cell for 'Cost' column as a NULL value
UPDATE space_mission
SET Cost = NULL WHERE Cost = '';

-- Changing datatype from VARCHAR(255) to FLOAT
ALTER TABLE space_mission
MODIFY COLUMN Cost FLOAT;