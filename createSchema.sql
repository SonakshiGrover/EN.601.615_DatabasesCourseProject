-- This file contains the DDL of all the tables



-- create new database for the project and use it
CREATE DATABASE IF NOT EXISTS projectDB;
USE projectDB;

-- Neighbourhood table schema
drop table if exists Neighbourhood;
CREATE TABLE Neighbourhood
(
Name char(100),
PopulationMale integer UNSIGNED NOT NULL,
PopulationFemale integer UNSIGNED NOT NULL,
AvgHouseholdSize Numeric(2,1) UNSIGNED NOT NULL,
MedianHouseholdIncome Numeric(10,2) UNSIGNED NOT NULL,
HHBelowPovertyLine Numeric(4,2) UNSIGNED NOT NULL,
ChildrenBelowPovertyLine Numeric(4,2) UNSIGNED NOT NULL,
Completed11 Numeric(4,2) DEFAULT 0.00,
Completed12 Numeric(4,2) DEFAULT 0.00,
PRIMARY KEY (Name)
);


-- Crime table schema
drop table if exists Crime;
CREATE TABLE Crime
(
Crime_Date Date NOT NULL,
Crime_time TIME NOT NULL,
CrimeCode char(60) NOT NULL,
Location char(60) NOT NULL,
Description char(60) NOT NULL,
PoliceDistrict char(30),
Neighbourhood char(30) NOT NULL,
Longitude Numeric(30,20) NOT NULL,
Latitude Numeric(30,20) NOT NULL,
PRIMARY KEY (Crime_Date,Crime_time,CrimeCode,Longitude,Latitude)
);


-- PoliceStation table schema

drop table if exists PoliceStation;
CREATE TABLE PoliceStation
(
Name char(15) NOT NULL,
Type char(20),
ZipCode integer,
Neighbourhood char(30) NOT NULL,
CouncilDistrict integer,
PoliceDistrict char(30) NOT NULL,
Location char(60) NOT NULL,
PRIMARY KEY (Name) 

);



-- Education table schema

drop table if exists Education;
CREATE TABLE Education
(
Neighbourhood char(30) NOT NULL,
Completed11 Numeric(4,2) DEFAULT 0.00,
Completed12 Numeric(4,2) DEFAULT 0.00,
PRIMARY KEY (Neighbourhood)

);



-- HomelessShelter table schema

drop table if exists HomelessShelter;
CREATE TABLE HomelessShelter
(
Name char(30) NOT NULL,
type char(30),
zipCode integer,
neighbourhood char(30),
councilDistrict integer DEFAULT 0.00,
policeDistrict  char(30),
Location char(30),
PRIMARY KEY (Name)
);


-- RealPropertyTax table schema

drop table if exists RealPropertyTax;
CREATE TABLE RealPropertyTax
(
PropertyID char(30),
Address char(60) NOT NULL,
Lotsize Numeric(5,3) DEFAULT 0.000,
CityTax Numeric(5,2) DEFAULT 0.00,
StateTax Numeric(5,2) DEFAULT 0.00,
ResidentialCode char(20),
Neighbourhood char(30) NOT NULL,
PoliceDistrict char(30),
PRIMARY KEY (PropertyID)
);



-- VacantBuilding table schema

drop table if exists VacantBuilding;
CREATE TABLE VacantBuilding
(
ReferenceID char(30) NOT NULL,
Block integer DEFAULT 0,
Lot integer DEFAULT 0,
BuildingAddress char(30),
NoticeDate Date,
Neighbourhood char(30),
PoliceDistrict char(30),
PRIMARY KEY (ReferenceID)
);



-- ReligiousBuildings table schema
drop table if exists ReligiousBuildings;
CREATE TABLE ReligiousBuildings
(
Name char(30) NOT NULL,
Type char(20),
ZipCode integer,
Neighbourhood char(30),
PoliceDistrict char(30),
PRIMARY KEY (Name)

);



-- Libraries table schema
drop table if exists Libraries;
CREATE TABLE Libraries
(
Name char(30) NOT NULL,
ZipCode integer,
Neighbourhood char(30),
PoliceDistrict char(30),
PRIMARY KEY (Name)

);


