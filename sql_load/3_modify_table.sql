LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\space_missions_utf8.csv'
INTO TABLE space_mission
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Checking if column 'Price' contains ","(comma) in any of record, later can be problematic in changing datatype.
SELECT * from space_mission;
SELECT * FROM space_mission WHERE `Price` LIKE '%,%';

-- Deleting unnecesary commas from Price column
UPDATE space_mission
SET Price = REPLACE(Price, ',', '');

-- Exchange empty cell for 'Price' column as a NULL value
UPDATE space_mission
SET Price = NULL WHERE Price = '';

-- Changing datatype from VARCHAR(255) to FLOAT
ALTER TABLE space_mission
MODIFY COLUMN Price FLOAT;