/*
    Creating table.

    Structure table contains:
    Company: Company responsible for the space mission
    Location: Location of the launch
    Date: Date of the launch
    Time: Time of the launch (UTC)
    Rocket: Name of the rocket used for the mission
    Mission: Name of the space mission (or missions)
    Rocket Status: Status of the rocket as of August 2022 (Active or Inactive)
    Price: Cost of the rocket in millions of US dollars
    Mission Status: Status of the mission (Success, Failure, Partial Failure, Prelaunch Failure)
*/
CREATE TABLE space_mission
(
    Company VARCHAR(255),
    Location VARCHAR(255),
    Date DATE,
    Time TIME,
    Rocket VARCHAR(255),
    Mission VARCHAR(255),
    RocketStatus VARCHAR(255),
    Price VARCHAR(255),
    MissionStatus VARCHAR(255),
);