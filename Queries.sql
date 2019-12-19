-- ******* File containing all the queries ******************************
-- NOTE: The simpler queries are included first and the complex ones are build upon these simpler ones later. 

-- query for building heatmap - longitude, latitude with their crime count-------------------------------

-- Q1  -----------------------------------

SELECT Neighbourhood.Name, Longitude, Latitude, count(*) as CrimeCount
FROM Crime, Neighbourhood
WHERE NOT(Crime.Neighbourhood IS NULL OR Crime.Neighbourhood = '') AND Neighbourhood.Name LIKE CONCAT('%',Crime.Neighbourhood ,'%');


-- query for "List the number of reported crimes for the year 2017, 2018, 2019 for each of the
-- police districts in Baltimore City. "

-- Q2  -----------------------------------

SELECT PoliceDistrict, Count(*) as CrimeCount 
FROM (SELECT DISTINCT *
	  FROM Crime 
	  WHERE Year(Crime_Date) = 2017 ) T
GROUP BY PoliceDistrict      
ORDER BY CrimeCount DESC;

-- Q3  -----------------------------------
SELECT PoliceDistrict, Count(*) as CrimeCount 
FROM (SELECT DISTINCT *
	  FROM Crime 
	  WHERE Year(Crime_Date) = 2018 ) T
GROUP BY PoliceDistrict      
ORDER BY CrimeCount DESC;

-- Q4  -----------------------------------
SELECT PoliceDistrict, Count(*) as CrimeCount 
FROM (SELECT DISTINCT *
	  FROM Crime 
	  WHERE Year(Crime_Date) = 2019 ) T
GROUP BY PoliceDistrict      
ORDER BY CrimeCount DESC;



-- List the top 5 neighborhoods with the highest crime in the police district where Homewood campus of Johns Hopkins is situated. 
-- The crime number is calculated over a time range of 2015-2019.

-- Q5  -----------------------------------


SELECT Neighbourhood, Count(*) as CrimeCount
FROM (SELECT DISTINCT *
	  FROM Crime 
	  ) T
WHERE  NOT(Neighbourhood IS NULL OR Neighbourhood = '') AND PoliceDistrict='NORTHERN'
GROUP BY Neighbourhood
ORDER BY Count(*) DESC
LIMIT 5 ;


-- Q6 ------------------------------------

CREATE VIEW temp AS
(SELECT Neighbourhood.Name as NeighbourhoodName,Year(Crime_Date), COUNT(*) as CrimeNumberYear 
	  FROM Crime, Neighbourhood
	  WHERE NOT(Crime.Neighbourhood IS NULL OR Crime.Neighbourhood = '') AND Neighbourhood.Name LIKE CONCAT('%',Crime.Neighbourhood ,'%')
	  GROUP BY Neighbourhood.Name,Year(Crime_Date));


-- Q7  -----------------------------------
      
SELECT NeighbourhoodName, AVG(CrimeNumberYear) as AvgCrimeCount
FROM temp
GROUP BY NeighbourhoodName
ORDER BY AvgCrimeCount DESC
limit 10;




-- queries for police district and the crimecounts-----------------------------------


-- Q8  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'NORTHERN'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q9  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'NORTHEAST'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q10  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'NORTHWEST'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q11  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'CENTRAL'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q12  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'EASTERN'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q13  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'WESTERN'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q14  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'SOUTHERN'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q15  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'SOUTHWEST'
Group by Description
Order By Count(*) DESC
LIMIT 3;


-- Q16  -----------------------------------
SELECT Description, Count(*) as CrimeTypeCount
FROM Crime
WHERE PoliceDistrict = 'SOUTHEAST'
Group by Description
Order By Count(*) DESC
LIMIT 3;       



-- correlation between number of Homeless Shelters, Percentage of ChildrenBelowPovertyLine and Crime count in every district


-- Q17  -----------------------------------

drop view if exists T1;
create view T1 as 
(SELECT policeDistrict, count(*) as HomelessShelterCount
FROM HomelessShelter
where NOT(policeDistrict IS NULL OR policeDistrict = '') 
GROUP BY policeDistrict);


-- Q18  -----------------------------------
drop view if exists T2;
create view T2 as 
(SELECT PoliceDistrict, count(*) as CrimeCount
FROM Crime
where NOT(policeDistrict IS NULL OR policeDistrict = '') 
GROUP BY PoliceDistrict);


-- Q19  -----------------------------------
drop view if exists T3;
create view T3 as
(SELECT PoliceDistrict, (sum(ChildrenBelowPovertyLine * (PopulationMale + PopulationFemale)))/ (sum(PopulationMale + PopulationFemale)) as AvgWeightedChildrenBelowPovertyLinePerc
FROM Crime, Neighbourhood
WHERE NOT(Crime.Neighbourhood IS NULL OR Crime.Neighbourhood = '') AND Neighbourhood.Name LIKE CONCAT('%',Crime.Neighbourhood ,'%') AND NOT(PoliceDistrict IS NULL OR PoliceDistrict  = '')
group by PoliceDistrict);



-- Q20  -----------------------------------
select T2.policeDistrict, HomelessShelterCount, CrimeCount, AvgWeightedChildrenBelowPovertyLinePerc
from T1 JOIN T2 JOIN T3
where (T2.policeDistrict LIKE CONCAT('%',T1.policeDistrict ,'%') OR T1.policeDistrict LIKE CONCAT(T2.policeDistrict ,'___')) AND  T2.policeDistrict=T3.PoliceDistrict;


-- correlation between vacant buildings and crimecount -----------------

-- Neighbourhoods along with number of crimes


-- Q21  -----------------------------------
drop view if exists Neighbourhood_CrimeCount;
create view Neighbourhood_CrimeCount as
(SELECT Neighbourhood.Name, count(*) as CrimeCount
FROM Crime, Neighbourhood
WHERE NOT(Crime.Neighbourhood IS NULL OR Crime.Neighbourhood = '') AND Neighbourhood.Name LIKE CONCAT('%',Crime.Neighbourhood ,'%')
GROUP BY Neighbourhood.Name);


-- Neighbourhoods along with number of Vacant buildings

-- Q22  -----------------------------------

drop view if exists Neighbourhood_VacantBuildingCount;
create view Neighbourhood_VacantBuildingCount as
(select Neighbourhood, count(ReferenceID) as VacantBuildingCount
from VacantBuilding
where NOT(Neighbourhood IS NULL OR Neighbourhood = '')
group by Neighbourhood);


-- Q23  -----------------------------------
select Neighbourhood_VacantBuildingCount.Neighbourhood, Neighbourhood_VacantBuildingCount.VacantBuildingCount, Neighbourhood_CrimeCount.CrimeCount, (Neighbourhood_CrimeCount.CrimeCount/Neighbourhood_VacantBuildingCount.VacantBuildingCount) as CrimePerVB
from Neighbourhood_VacantBuildingCount,Neighbourhood_CrimeCount
where NOT(Neighbourhood_VacantBuildingCount.Neighbourhood is null or Neighbourhood_VacantBuildingCount.Neighbourhood= '') and Neighbourhood_CrimeCount.Name LIKE CONCAT('%',Neighbourhood_VacantBuildingCount.Neighbourhood ,'%');



-- correlation between religious buildings and crimecount

-- Neighbourhoods along with number of religious buildings


-- Q24  -----------------------------------
drop view if exists Neighbourhood_ReligiousBuildingsCount;
create view Neighbourhood_ReligiousBuildingsCount as
(select Neighbourhood, count(Name) as ReligiousBuildingCount
from ReligiousBuildings
where NOT(Neighbourhood IS NULL OR Neighbourhood = '')
group by Neighbourhood);


-- Q25  -----------------------------------
select Neighbourhood_ReligiousBuildingsCount.Neighbourhood, Neighbourhood_ReligiousBuildingsCount.ReligiousBuildingCount, Neighbourhood_CrimeCount.CrimeCount, (Neighbourhood_CrimeCount.CrimeCount/Neighbourhood_ReligiousBuildingsCount.ReligiousBuildingCount) as CrimePerRB
from Neighbourhood_ReligiousBuildingsCount,Neighbourhood_CrimeCount
where NOT(Neighbourhood_ReligiousBuildingsCount.Neighbourhood is null or Neighbourhood_ReligiousBuildingsCount.Neighbourhood= '') and Neighbourhood_CrimeCount.Name LIKE CONCAT('%',Neighbourhood_ReligiousBuildingsCount.Neighbourhood ,'%');



-- correlation between libraries and crimecount


-- Q26  -----------------------------------
drop view if exists Neighbourhood_LibrariesCount;
create view Neighbourhood_LibrariesCount as
(select Neighbourhood, count(Name) as LibrariesCount
from Libraries
where NOT(Neighbourhood IS NULL OR Neighbourhood = '')
group by Neighbourhood);


-- Q27  -----------------------------------

select Neighbourhood_LibrariesCount.Neighbourhood, Neighbourhood_LibrariesCount.LibrariesCount, Neighbourhood_CrimeCount.CrimeCount, (Neighbourhood_CrimeCount.CrimeCount/Neighbourhood_LibrariesCount.LibrariesCount) as CrimePerL
from Neighbourhood_LibrariesCount,Neighbourhood_CrimeCount
where NOT(Neighbourhood_LibrariesCount.Neighbourhood is null or Neighbourhood_LibrariesCount.Neighbourhood= '') and Neighbourhood_CrimeCount.Name LIKE CONCAT('%',Neighbourhood_LibrariesCount.Neighbourhood ,'%');



-- correlation between Neighbourhood, CrimePerCapita, HouseHoldsBelowPovertyLine
-- Q28 ------------------------------------


SELECT Neighbourhood.Name, count(*)/(PopulationMale + PopulationFemale) as CrimePerCapita, HHBelowPovertyLine
FROM Crime, Neighbourhood
WHERE NOT(Crime.Neighbourhood IS NULL OR Crime.Neighbourhood = '') AND Neighbourhood.Name LIKE CONCAT('%',Crime.Neighbourhood ,'%')
GROUP BY Neighbourhood.Name
ORDER BY CrimePerCapita DESC;



