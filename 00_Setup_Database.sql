-- Drop the database if it already exists
DROP DATABASE IF EXISTS city_infos;

-- Create the database
CREATE DATABASE city_infos;

-- Use the database
USE city_infos;

-- ------------------------- 01. Create tables for cities data from web scraping ------------------------------------
-- Create the 'cities' table
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    PRIMARY KEY (city_id)
);
SELECT * FROM cities;

-- Create the 'population' table
CREATE TABLE population (
    city_id INT NOT NULL, 
    population FLOAT NOT NULL,
    population_timestamp DATETIME NOT NULL,
    PRIMARY KEY (city_id, population_timestamp),      -- Composite primary key
    FOREIGN KEY (city_id) REFERENCES cities(city_id)  -- Foreign key to refer to cities table
);
SELECT * FROM population;


-- ------------------------- 02. Create table for weather data from API calls ------------------------------------

-- Create 'weather' table
CREATE TABLE weather (
	city_id INT NOT NULL,					
	`time` DATETIME NOT NULL,				-- forecast time
    weather VARCHAR(255),					-- weather description
    temperature_c FLOAT,
    wind_speed_m_s FLOAT,
    rain_probability FLOAT,
    retrieval_time DATETIME NOT NULL,		-- time stamp for data retrieval
    PRIMARY KEY (city_id, `time`),			-- composite key to prevent duplicates
    FOREIGN KEY (city_id) REFERENCES cities(city_id) -- Foreign key to refer to cities table
);
SELECT * FROM weather;  


-- ------------------------- 03. Create tables for airport and flight data from API calls ------------------------------------

-- Create the 'airports' table
CREATE TABLE airports (
	city_id INT NOT NULL,
	airport_name VARCHAR(255),
    iata VARCHAR(10),
    icao VARCHAR(10), 	
    PRIMARY KEY (icao), 	-- ICAO codes are unique identifiers for airports
    FOREIGN KEY (city_id) REFERENCES cities(city_id) 	-- Foreign key to refer to cities table
);
SELECT * FROM airports;

-- Create the 'fights' table
CREATE TABLE flights (
    id INT AUTO_INCREMENT PRIMARY KEY,	-- set primary key for flight
    arrival_airport_icao VARCHAR(10) NOT NULL,
    departure_airport_icao VARCHAR(10),
    scheduled_arrival_time DATETIME NOT NULL,
    revised_arrival_time DATETIME,
    arrival_terminal VARCHAR(10),
    arrival_gate VARCHAR(10),
    flight_number VARCHAR(20) NOT NULL,
    retrieval_time DATETIME NOT NULL,
    FOREIGN KEY (arrival_airport_icao) REFERENCES airports(icao) -- Foreign key to refer to airports table
);
SELECT * FROM flights;
